//
//  WBRequestManager.h
//  BaiSiBuDeJieDemo
//
//  Created by wangbing on 16/3/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBUserRequest.h"
#import "WBMessageRequest.h"

@interface WBRequestManager : NSObject
@property (nonatomic, strong) WBUserRequest *userRequset;
@property (nonatomic, strong) WBMessageRequest *messageRequest;
+ (instancetype)manager;
@end
