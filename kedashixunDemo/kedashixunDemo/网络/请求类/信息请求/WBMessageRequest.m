//
//  WBMessageRequest.m
//  BaiSiBuDeJieDemo
//
//  Created by wangbing on 16/3/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBMessageRequest.h"
#import "WBRequest.h"

@implementation WBMessageRequest
- (void)getRequestWithparameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
   [self GET:kBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       success(responseObject);
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       failure(error);
   }];
}
@end
