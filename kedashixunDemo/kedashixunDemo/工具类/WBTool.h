//
//  WBTool.h
//  kedashixunDemo
//
//  Created by wangbing on 16/5/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WBTool : NSObject

/**
 *  去除字符串里的空格
 *
 *  @param string 原始字符串
 *
 *  @return 新的字符串
 */
+(NSString *)deleteSapceWithString:(NSString *)string;

/**
 *  判断是不是手机号
 *
 *  @param mobileNum 手机号
 *
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;



//判断版本是否更新  或者 第一次进入
+ (BOOL)isVersionUpdate;


//判断日期是否是今天或昨天的
+ (NSString *)isYesterdayOrTodayWithDateStr:(NSString *)dateStr;



// 获取沙盒Document的文件目录
+ (NSString *)getDocumentDirectory;
// 获取沙盒Library的文件目录
+ (NSString *)getLibraryDirectory;
// 获取沙盒Library/Caches的文件目录
+ (NSString *)getCachesDirectory;
// 获取沙盒Preference的文件目录
+ (NSString *)getPreferencePanesDirectory;
// 获取沙盒tmp的文件目录
+ (NSString *)getTmpDirectory;

@end
