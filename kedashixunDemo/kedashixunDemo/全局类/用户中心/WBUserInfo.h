//
//  WBUserInfo.h
//  kedashixunDemo
//
//  Created by wangbing on 16/5/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBDBModel.h"

@interface WBUserInfo : WBDBModel

@property (nonatomic, assign) int userid;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *phonenum;
@property (nonatomic, copy) NSString *motto;
+ (instancetype)share;

- (void)getUserInfo;

- (void)saveUserInfoWithUserDict:(NSDictionary *)userDict;



@end
