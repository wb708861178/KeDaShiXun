//
//  WBMessageRequest.h
//  BaiSiBuDeJieDemo
//
//  Created by wangbing on 16/3/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBBaseRequest.h"

@interface WBMessageRequest : WBBaseRequest

- (void)getRequestWithparameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

@end
