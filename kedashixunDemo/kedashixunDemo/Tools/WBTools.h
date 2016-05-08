//
//  WBTools.h
//  BaiSiBuDeJieDemo
//
//  Created by wangbing on 16/3/22.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WBTools : NSObject


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
