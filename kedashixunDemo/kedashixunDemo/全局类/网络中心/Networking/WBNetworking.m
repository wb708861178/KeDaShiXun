//
//  WBNetworking.m
//  AFN简单封装
//
//  Created by wangbing on 16/2/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBNetworking.h"
#import "AFNetworking.h"

#define kBaseUrl @"http://115.28.87.147/phpfile/kedashixun/netCon.php"
@implementation WBNetworking



+ (void)networkRequstWithNetworkRequestMethod:(NetworkRequestMethod)networkRequestMethod
                          networkRequestStyle:(NetworkRequestStyle)networkRequestStyle
                                       params:(NSDictionary *)params
                                 successBlock:(SuccessBlock)successBlock
                                 failureBlock:(FailureBlock)failureBlock
{
    NSMutableDictionary *tempParams = [NSMutableDictionary dictionaryWithDictionary:params];
    switch (networkRequestStyle) {
        case NetType_getRegister:
        {
            [tempParams setObject:@"getRegister" forKey:@"act"];
        }
            break;
        case NetType_getLogin:
        {
            [tempParams setObject:@"getLogin" forKey:@"act"];
        }
            break;
        case NetType_getUpdateNickname:
        {
            [tempParams setObject:@"getUpdateNickname" forKey:@"act"];
        }
            break;
        case NetType_getUpdateSex:
        {
            [tempParams setObject:@"getUpdateSex" forKey:@"act"];
        }
            break;
        case NetType_getUpdateMotto:
        {
            [tempParams setObject:@"getUpdateMotto" forKey:@"act"];
        }
            break;
        case NetType_getKedamessage:
        {
            [tempParams setObject:@"getKedamessage" forKey:@"act"];
        }
            break;
        case NetType_getForum:
        {
            [tempParams setObject:@"NetType_getForum" forKey:@"act"];
        }
            break;
        case NetType_getComment:
        {
            [tempParams setObject:@"getComment" forKey:@"act"];
        }
            break;
            
        default:
            break;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];


    
    
    
    if (networkRequestMethod == GetNetworkRequest) {
        [manager GET:kBaseUrl parameters:tempParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             failureBlock(error);
        }];
        
       
        
    }else if(networkRequestMethod == PostNetworkRequest ){
        [manager POST:kBaseUrl parameters:tempParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             failureBlock(error);
        }];
        
       
    }
}






@end
