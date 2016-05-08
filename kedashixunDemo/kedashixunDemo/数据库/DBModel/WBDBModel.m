//
//  WBDBModel.m
//  FreeShuQiNovel
//
//  Created by wangbing on 16/5/1.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBDBModel.h"
#import "WBDBHelper.h"

#import <objc/runtime.h>
@implementation WBDBModel
+ (void)initialize
{
    if (self != [WBDBModel class]) {
        if (![[self class] isExistInTable]) {
             [self createTable];
        }
       
    }
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDictionary *dic = [self.class getAllProperties];
        _columeNames = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"name"]];
        _columeTypes = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"type"]];
    }
    
    return self;
}

#pragma mark - base method
/**
 *  获取该类的所有属性(除主键之外)
 */
+ (NSDictionary *)getPropertys
{
    NSMutableArray *proNames = [NSMutableArray array];
    NSMutableArray *proTypes = [NSMutableArray array];
    NSMutableArray *theTransients = [[self class] transients];
    NSString *primaryKeyName = [[self class] setPrimaryKey];
    if (primaryKeyName) {
           [theTransients addObject:primaryKeyName];
    }
 
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        //获取属性名
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if ([theTransients containsObject:propertyName]) {
            continue;
        }
        [proNames addObject:propertyName];
        //获取属性类型等参数
        NSString *propertyType = [NSString stringWithCString: property_getAttributes(property) encoding:NSUTF8StringEncoding];
        /*
         c char         C unsigned char
         i int          I unsigned int
         l long         L unsigned long
         s short        S unsigned short
         d double       D unsigned double
         f float        F unsigned float
         q long long    Q unsigned long long
         B BOOL
         @ 对象类型 //指针 对象类型 如NSString 是@“NSString”
         
         
         64位下long 和long long 都是Tq
         SQLite 默认支持五种数据类型TEXT、INTEGER、REAL、BLOB、NULL
         */
        if ([propertyType hasPrefix:@"T@"]) {
            [proTypes addObject:SQLTEXT];
        } else if ([propertyType hasPrefix:@"Ti"]||[propertyType hasPrefix:@"TI"]||[propertyType hasPrefix:@"Ts"]||[propertyType hasPrefix:@"TS"]||[propertyType hasPrefix:@"TB"]) {
            [proTypes addObject:SQLINTEGER];
        } else {
            [proTypes addObject:SQLREAL];
        }
        
    }
    free(properties);
    
    return [NSDictionary dictionaryWithObjectsAndKeys:proNames,@"name",proTypes,@"type",nil];
}

/** 获取所有属性，包含主键pk */
+ (NSDictionary *)getAllProperties
{
    NSDictionary *dict = [self.class getPropertys];
    
    NSMutableArray *proNames = [NSMutableArray array];
    NSMutableArray *proTypes = [NSMutableArray array];
    NSString *primaryKeyName = [[self class] setPrimaryKey];
    if (primaryKeyName) {
        [proNames addObject:primaryKeyName];
        [proTypes addObject:[NSString stringWithFormat:@"%@ %@",SQLINTEGER,PrimaryKey]];
  
    }else
    {
        [proNames addObject:primaryId];
        [proTypes addObject:[NSString stringWithFormat:@"%@ %@",SQLINTEGER,PrimaryKey]];

    }
    [proNames addObjectsFromArray:[dict objectForKey:@"name"]];
    [proTypes addObjectsFromArray:[dict objectForKey:@"type"]];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:proNames,@"name",proTypes,@"type",nil];
}

/** 数据库中是否存在表 */
+ (BOOL)isExistInTable
{
    __block BOOL result = NO;
    WBDBHelper *DBHelper = [WBDBHelper shareInstance];
    [DBHelper.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass([self class]);
        result = [db tableExists:tableName];
    }];
    return result;
}
+ (NSArray *)getColumns
{
    WBDBHelper *DBHelper = [WBDBHelper shareInstance];
    NSMutableArray *columns = [NSMutableArray array];
    [DBHelper.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass([self class]);
        FMResultSet *resultSet = [db getTableSchema:tableName];
        while ([resultSet next]) {
            NSString *column = [resultSet stringForColumn:@"name"];
            [columns addObject:column];
        }
        
        
        
    }];
    return [columns copy];
}
/**
 * 创建表
 * 如果已经创建，返回YES
 */
+ (BOOL)createTable
{
    FMDatabase *db = [FMDatabase databaseWithPath:[WBDBHelper dbPath]];
    if (![db open]) {
        NSLog(@"数据库打开失败!");
        return NO;
    }
    
    NSString *tableName = NSStringFromClass(self.class);
    NSString *columeAndType = [self.class getColumeAndTypeString];
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@);",tableName,columeAndType];
    
 
    
    if (![db executeUpdate:sql]) {
        return NO;
    }
    
    NSMutableArray *columns = [NSMutableArray array];
    FMResultSet *resultSet = [db getTableSchema:tableName];
    while ([resultSet next]) {
        NSString *column = [resultSet stringForColumn:@"name"];
        [columns addObject:column];
    }
    NSDictionary *dict = [self.class getAllProperties];
    NSArray *properties = [dict objectForKey:@"name"];
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",columns];
    //过滤数组
    NSArray *resultArray = [properties filteredArrayUsingPredicate:filterPredicate];
    
    for (NSString *column in resultArray) {
        NSUInteger index = [properties indexOfObject:column];
        NSString *proType = [[dict objectForKey:@"type"] objectAtIndex:index];
        NSString *fieldSql = [NSString stringWithFormat:@"%@ %@",column,proType];
        NSString *sql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN %@ ",NSStringFromClass(self.class),fieldSql];
        if (![db executeUpdate:sql]) {
            return NO;
        }
    }
    [db close];
    return YES;
}
#pragma mark - util method
+ (NSString *)getColumeAndTypeString
{
    NSMutableString* pars = [NSMutableString string];
    NSDictionary *dict = [self.class getAllProperties];
    
    NSMutableArray *proNames = [dict objectForKey:@"name"];
    NSMutableArray *proTypes = [dict objectForKey:@"type"];
    
    for (int i=0; i< proNames.count; i++) {
        [pars appendFormat:@"%@ %@",[proNames objectAtIndex:i],[proTypes objectAtIndex:i]];
        if(i+1 != proNames.count)
        {
            [pars appendString:@","];
        }
    }
    return pars;
}


- (BOOL)save
{
    NSString *tableName = NSStringFromClass(self.class);
    NSMutableString *keyString = [NSMutableString string];
    NSMutableString *valueString = [NSMutableString string];
    NSMutableArray *insertValues = [NSMutableArray  array];
     NSString *primaryKeyName = [[self class] setPrimaryKey];
    for (int i = 0; i < self.columeNames.count; i++) {
        NSString *proname = [self.columeNames objectAtIndex:i];
       
        if (!primaryKeyName) {
            if ([proname isEqualToString:primaryId]) {
                continue;
            }
            
        }

        
        [keyString appendFormat:@"%@,", proname];
        [valueString appendString:@"?,"];
        id value = [self valueForKey:proname];
        if (!value) {
            value = @"";
        }
        [insertValues addObject:value];
    }
    
    [keyString deleteCharactersInRange:NSMakeRange(keyString.length - 1, 1)];
    [valueString deleteCharactersInRange:NSMakeRange(valueString.length - 1, 1)];
    
    WBDBHelper *DBHelper = [WBDBHelper shareInstance];
    __block BOOL result = NO;
    [DBHelper.dbQueue inDatabase:^(FMDatabase *db) {
        
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(%@) VALUES (%@);", tableName, keyString, valueString];
                result = [db executeUpdate:sql withArgumentsInArray:insertValues];
        if (!primaryKeyName) {
             self.pk = result?[NSNumber numberWithLongLong:db.lastInsertRowId].intValue:0;
        }
       
        NSLog(result?@"插入成功":@"插入失败");
    }];
    return result;
}
/** 批量保存用户对象 */
+ (BOOL)saveObjects:(NSArray *)array
{
    //判断是否是JKBaseModel的子类
    for (WBDBModel *model in array) {
        if (![model isKindOfClass:[WBDBModel class]]) {
            return NO;
        }
    }
    
    __block BOOL res = YES;
    WBDBHelper *DBHelper = [WBDBHelper shareInstance];
    // 如果要支持事务
      NSString *primaryKeyName = [[self class] setPrimaryKey];
    [DBHelper.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (WBDBModel *model in array) {
            NSString *tableName = NSStringFromClass(model.class);
            NSMutableString *keyString = [NSMutableString string];
            NSMutableString *valueString = [NSMutableString string];
            NSMutableArray *insertValues = [NSMutableArray  array];
            for (int i = 0; i < model.columeNames.count; i++) {
                NSString *proname = [model.columeNames objectAtIndex:i];
                if (!primaryKeyName) {
                    if ([proname isEqualToString:primaryId]) {
                        continue;
                    }
                    
                }
                [keyString appendFormat:@"%@,", proname];
                [valueString appendString:@"?,"];
                id value = [model valueForKey:proname];
                if (!value) {
                    value = @"";
                }
                [insertValues addObject:value];
            }
            [keyString deleteCharactersInRange:NSMakeRange(keyString.length - 1, 1)];
            [valueString deleteCharactersInRange:NSMakeRange(valueString.length - 1, 1)];
            
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(%@) VALUES (%@);", tableName, keyString, valueString];
            BOOL flag = [db executeUpdate:sql withArgumentsInArray:insertValues];
            if (!primaryKeyName) {
                model.pk = flag?[NSNumber numberWithLongLong:db.lastInsertRowId].intValue:0;

            }

            NSLog(flag?@"插入成功":@"插入失败");
            if (!flag) {
                res = NO;
                *rollback = YES;
                return;
            }
        }
    }];
    return res;
}
/** 更新单个对象 */
- (BOOL)update
{
    WBDBHelper *DBHelper = [WBDBHelper shareInstance];
    __block BOOL res = NO;
    [DBHelper.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        id primaryValue;
         NSString *primaryKeyName = [[self class] setPrimaryKey];
        if (primaryKeyName) {
            primaryValue = [self valueForKey:primaryKeyName];
            if (!primaryValue) {
                return ;
            }
        }else
        {
             primaryValue = [self valueForKey:primaryId];
            if (!primaryValue || primaryValue <= 0) {
                return ;
            }

        }
        
               NSMutableString *keyString = [NSMutableString string];
        NSMutableArray *updateValues = [NSMutableArray  array];
        for (int i = 0; i < self.columeNames.count; i++) {
            NSString *proname = [self.columeNames objectAtIndex:i];
             if (!primaryKeyName) {
                 if ([proname isEqualToString:primaryId]) {
                     continue;
                 }

             }
            [keyString appendFormat:@" %@=?,", proname];
            id value = [self valueForKey:proname];
            if (!value) {
                value = @"";
            }
            [updateValues addObject:value];
        }
        
        //删除最后那个逗号
        [keyString deleteCharactersInRange:NSMakeRange(keyString.length - 1, 1)];
        NSString *sql = @"";
        if (primaryKeyName) {
             sql  = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@ = ?;", tableName, keyString, primaryKeyName];
        }else
        {
         sql  = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@ = ?;", tableName, keyString, primaryId];
        }
        
        [updateValues addObject:primaryValue];
        res = [db executeUpdate:sql withArgumentsInArray:updateValues];
        NSLog(res?@"更新成功":@"更新失败");
    }];
    return res;
}

/** 删除单个对象 */
- (BOOL)deleteObject
{
    WBDBHelper *DBHelper = [WBDBHelper shareInstance];
    __block BOOL res = NO;
    [DBHelper.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        id primaryValue;
        NSString *sql;
        NSString *primaryKeyName = [[self class] setPrimaryKey];
        if (primaryKeyName) {
            primaryValue = [self valueForKey:primaryKeyName];
            if (!primaryValue) {
                return ;
            }
            sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?",tableName,primaryKeyName];
            
        }else
        {
            primaryValue = [self valueForKey:primaryId];
            if (!primaryValue || primaryValue <= 0) {
                return ;
            }
            sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?",tableName,primaryId];
            
        }
        res = [db executeUpdate:sql withArgumentsInArray:@[primaryValue]];
        NSLog(res?@"删除成功":@"删除失败");
    }];
    return res;
}

/** 通过条件删除数据 */
+ (BOOL)deleteObjectsByCriteria:(NSString *)criteria
{
    WBDBHelper *DBHelper = [WBDBHelper shareInstance];
    __block BOOL res = NO;
    [DBHelper.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ %@ ",tableName,criteria];
        res = [db executeUpdate:sql];
        NSLog(res?@"删除成功":@"删除失败");
    }];
    return res;
}


/** 清空表 */
+ (BOOL)clearTable
{
    WBDBHelper *DBHelper = [WBDBHelper shareInstance];
    __block BOOL res = NO;
    [DBHelper.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@",tableName];
        res = [db executeUpdate:sql];
        NSLog(res?@"清空成功":@"清空失败");
    }];
    return res;
}
/** 查询全部数据 */
+ (NSArray *)findAll
{
    NSLog(@"wbdb---%s",__func__);
    WBDBHelper *DBHelper = [WBDBHelper shareInstance];
    NSMutableArray *users = [NSMutableArray array];
    [DBHelper.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            WBDBModel *model = [[self.class alloc] init];
            for (int i=0; i< model.columeNames.count; i++) {
                NSString *columeName = [model.columeNames objectAtIndex:i];
                NSString *columeType = [model.columeTypes objectAtIndex:i];
                if ([columeType isEqualToString:SQLTEXT]) {
                    [model setValue:[resultSet stringForColumn:columeName] forKey:columeName];
                } else {
                    [model setValue:[NSNumber numberWithDouble:[resultSet doubleForColumn:columeName]] forKey:columeName];
                }
            }
            [users addObject:model];
            FMDBRelease(model);
        }
    }];
    
    return users;
}
/** 查找某条数据 */
+ (instancetype)findFirstByCriteria:(NSString *)criteria
{
    NSArray *results = [self.class findByCriteria:criteria];
    if (results.count < 1) {
        return nil;
    }
    
    return [results firstObject];
}
/** 通过条件查找数据 */
+ (NSArray *)findByCriteria:(NSString *)criteria
{
    WBDBHelper *DBHelper = [WBDBHelper shareInstance];
    NSMutableArray *users = [NSMutableArray array];
    [DBHelper.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ %@",tableName,criteria];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            WBDBModel *model = [[self.class alloc] init];
            for (int i=0; i< model.columeNames.count; i++) {
                NSString *columeName = [model.columeNames objectAtIndex:i];
                NSString *columeType = [model.columeTypes objectAtIndex:i];
                if ([columeType isEqualToString:SQLTEXT]) {
                    [model setValue:[resultSet stringForColumn:columeName] forKey:columeName];
                } else {
                   [model setValue:[NSNumber numberWithDouble:[resultSet doubleForColumn:columeName]] forKey:columeName];
                   
                    
                }
            }
            [users addObject:model];
            FMDBRelease(model);
        }
    }];
    
    return users;
}


- (NSString *)description
{
    NSString *result = @"";
    NSDictionary *dict = [self.class getAllProperties];
    NSMutableArray *proNames = [dict objectForKey:@"name"];
    for (int i = 0; i < proNames.count; i++) {
        NSString *proName = [proNames objectAtIndex:i];
        id  proValue = [self valueForKey:proName];
        result = [result stringByAppendingFormat:@"%@:%@\n",proName,proValue];
    }
    return result;
}




#pragma mark - must be override method
/** 如果子类中有一些property不需要创建数据库字段，那么这个方法必须在子类中重写
 */
+ (NSMutableArray *)transients
{
    return [NSMutableArray array];
}


/**
 *  设置模型的主键
 *
 *  @return 主键名
 */
+ (NSString *)setPrimaryKey
{
    return nil;
}


@end
