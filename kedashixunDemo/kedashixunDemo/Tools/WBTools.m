//
//  WBTools.m
//  BaiSiBuDeJieDemo
//
//  Created by wangbing on 16/3/22.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBTools.h"

@implementation WBTools
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
