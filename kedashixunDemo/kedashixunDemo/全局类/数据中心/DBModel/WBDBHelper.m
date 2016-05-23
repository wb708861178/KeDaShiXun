//
//  WBDBHelper.m
//  FreeShuQiNovel
//
//  Created by wangbing on 16/5/1.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBDBHelper.h"

@implementation WBDBHelper
+ (instancetype)shareInstance
{
    return [[self alloc] init];
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static  WBDBHelper *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
    });
    return manager;
}

+ (NSString *)dbPath
{
       NSString *dbpath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"WB.sqlite"];
    NSLog(@"------%@",dbpath);
    return dbpath;
}


- (FMDatabaseQueue *)dbQueue
{
    if (!_dbQueue) {
        _dbQueue = [[FMDatabaseQueue alloc] initWithPath:[[self class] dbPath]];
    }
    
    return _dbQueue;
    
}


@end
