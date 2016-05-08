//
//  WBRequestManager.m
//  BaiSiBuDeJieDemo
//
//  Created by wangbing on 16/3/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBRequestManager.h"

@implementation WBRequestManager

+ (instancetype)manager
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userRequset = [[WBUserRequest alloc] init];
        self.messageRequest = [[WBMessageRequest alloc] init];
    }
    return self;
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static  WBRequestManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
    });
    return manager;
}

@end
