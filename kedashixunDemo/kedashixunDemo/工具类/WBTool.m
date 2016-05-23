//
//  WBTool.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBTool.h"
@implementation WBTool
#pragma mark -判断版本是否更新 或者 第一次进入
+ (BOOL)isVersionUpdate
{
    NSDictionary *infoDict =  [NSBundle mainBundle].infoDictionary;
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersionStr = infoDict[key];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *versionStr = [defaults objectForKey:@"versionStr"];
    
    if (versionStr) {
        if (![currentVersionStr isEqualToString:versionStr])
        {
            [defaults setObject:currentVersionStr forKey:@"versionStr"];
            
            return YES;
        }
        
    }else
    {
        [defaults setObject:currentVersionStr forKey:@"versionStr"];
        return YES;
        
        
    }
    //为YES调试
    return NO;
}



#pragma mark -判断日期是否是今天或昨天的
+ (NSString *)isYesterdayOrTodayWithDateStr:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm.ss";
    NSDate *date = [formatter dateFromString:dateStr];
    if (!date) {
        
        return nil;
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    if ([calendar isDateInToday:date]) {
        formatter.dateFormat = @"HH:mm.ss";
        NSString *todayStr = [NSString stringWithFormat:@"今天 %@",[formatter stringFromDate:date]];
        return todayStr;
    }
    
    if ([calendar isDateInYesterday:date]) {
        formatter.dateFormat = @"HH:mm.ss";
        NSString *yesterdayStr = [NSString stringWithFormat:@"昨天 %@",[formatter stringFromDate:date]];
        return yesterdayStr;
    }
    
    formatter.dateFormat = @"MM-dd HH:mm.ss";
    
    return [formatter stringFromDate:date];
    
    
}

//根据颜色得到一张图片




#pragma mark - 获取沙盒Document的文件目录
+ (NSString *)getDocumentDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
#pragma mark - 获取沙盒Library的文件目录
+ (NSString *)getLibraryDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}
#pragma mark - 获取沙盒Library/Caches的文件目录
+ (NSString *)getCachesDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}
#pragma mark - 获取沙盒Preference的文件目录
+ (NSString *)getPreferencePanesDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
}
#pragma mark - 获取沙盒tmp的文件目录
+ (NSString *)getTmpDirectory{
    return NSTemporaryDirectory();
}


@end
