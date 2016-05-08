//
//  WBDBHelper.h
//  FreeShuQiNovel
//
//  Created by wangbing on 16/5/1.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface WBDBHelper : NSObject

@property (nonatomic, retain) FMDatabaseQueue *dbQueue;
+ (instancetype)shareInstance;

+ (NSString *)dbPath;
@end
