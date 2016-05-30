//
//  WBTool.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBTool.h"
@implementation WBTool


/**
 *  去除字符串里的空格
 *
 *  @param string 原始字符串
 *
 *  @return 新的字符串
 */
+(NSString *)deleteSapceWithString:(NSString *)string
{
     NSString *deleteSpacePhoneStr = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return deleteSpacePhoneStr;
}

/**
 *  判断是不是手机号
 *
 *  @param mobileNum 手机号
 *
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,181,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,181,189
     */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextestphs evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO; //暂时不做检查
    }
}



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
