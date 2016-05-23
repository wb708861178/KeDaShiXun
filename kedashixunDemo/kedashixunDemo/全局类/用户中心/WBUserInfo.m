//
//  WBUserInfo.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBUserInfo.h"

@implementation WBUserInfo

+ (instancetype)share
{
   return  [[self alloc] init];
    
}


- (void)getUserInfo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id userDict = [defaults objectForKey:@"userDict"];
    if (userDict) {
        [self loadUserInfoWithUserDict:userDict];
    }
}



- (void)saveUserInfoWithUserDict:(NSDictionary *)userDict
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userDict forKey:@"userDict"];
 
    [self loadUserInfoWithUserDict:userDict];
}

- (void)loadUserInfoWithUserDict:(NSDictionary *)userDict
{
    self.userid = [userDict[@"userid"] intValue];
    self.account = userDict[@"account"];
    self.password = userDict[@"password"];
    self.icon = userDict[@"icon"];
    self.sex = userDict[@"sex"];
    self.nickname = userDict[@"nickname"];
    self.phonenum = userDict[@"phonenum"];
    self.motto = userDict[@"motto"];
   
   
    
}













+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static WBUserInfo *userInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [super allocWithZone:zone];
    });
    return userInfo;
}

@end
