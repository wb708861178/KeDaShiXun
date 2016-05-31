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
         
        case NetType_getUserInfo://得到用户信息
        {
            [tempParams setObject:@"getUserInfo" forKey:@"act"];
        }
            break;
        case  NetType_getIsRegiste://是否注册
        {
            [tempParams setObject:@"getIsRegiste" forKey:@"act"];
        }
            break;
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
        case NetType_getUpdateUserPwd:
        {
            [tempParams setObject:@"getUpdateUserPwd" forKey:@"act"];
        }
            break;
         
            
            
            
            
            
            
            
            
        case NetType_getKedamessage:
        {
            [tempParams setObject:@"getKedamessage" forKey:@"act"];
        }
            break;
        case NetType_getForum:
        {
            [tempParams setObject:@"getForum" forKey:@"act"];
        }
            break;
        case NetType_getComment:
        {
            [tempParams setObject:@"getComment" forKey:@"act"];
        }
            break;
        case NetType_getPhonelist:
        {
            [tempParams setObject:@"getPhonelist" forKey:@"act"];
        }
            break;
        case NetType_getHistory:
        {
            [tempParams setObject:@"getHistory" forKey:@"act"];
        }
            break;
        case NetType_getForumPartIn:
        {
            [tempParams setObject:@"getForumPartIn" forKey:@"act"];
        }
            break;
        case NetType_getHistoryDelete:
        {
            [tempParams setObject:@"getHistoryDelete" forKey:@"act"];
        }
            break;
        case NetType_getSearch:
        {
            [tempParams setObject:@"getSearch" forKey:@"act"];
        }
            break;
        case NetType_getSearchresult:
        {
            [tempParams setObject:@"getSearchresult" forKey:@"act"];
        }
            break;
        case NetType_getIsaddhistory:
        {
            [tempParams setObject:@"getIsaddhistory" forKey:@"act"];
        }
            break;
            
        case NetType_getAddhistory:
        {
            [tempParams setObject:@"getAddhistory" forKey:@"act"];
        }
            break;

        case NetType_getKedamessageCollection:
        {
            [tempParams setObject:@"getKedamessageCollection" forKey:@"act"];
        }
            break;
        case NetType_getAddKedamcollection:
        {
            [tempParams setObject:@"getAddKedamcollection" forKey:@"act"];
        }
            break;
        case NetType_getKedamcollectionstatus://得到科大时讯收藏状态
        {
            [tempParams setObject:@"getKedamcollectionstatus" forKey:@"act"];
        }
            break;
        case NetType_getAddkedamcollectionstatus://增加科大时讯收藏状态
        {
            [tempParams setObject:@"getAddkedamcollectionstatus" forKey:@"act"];
        }
            break;
            
        case NetType_getUpdateKedamCollectionStatus://更改科大时讯收藏状态
        {
            [tempParams setObject:@"getUpdateKedamCollectionStatus" forKey:@"act"];
        }
            break;
        case NetType_getForumsupportstatus://得到点赞和收藏状态（空时400插入）
        {
            [tempParams setObject:@"getForumsupportstatus" forKey:@"act"];
        }
            break;
        case NetType_getForumaddsupport://增加论坛收藏点赞用户状态
        {
            [tempParams setObject:@"getForumaddsupport" forKey:@"act"];
        }
            break;
        case NetType_getUpdateForumCollectStatus://修改论坛收藏状态
        {
            [tempParams setObject:@"getUpdateForumCollectStatus" forKey:@"act"];
        }
            break;
        case NetType_getUpdateForumSupportStatus://修改论坛点赞状态
        {
            [tempParams setObject:@"getUpdateForumSupportStatus" forKey:@"act"];
        }
            break;
        case NetType_getAddforum://增加论坛帖子
        {
            [tempParams setObject:@"getAddforum" forKey:@"act"];
        }
            break;
        case  NetType_getUpdatesupportnum://修改论坛点赞量
        {
            [tempParams setObject:@"getUpdatesupportnum" forKey:@"act"];
        }
            break;
        case  NetType_getAddforumcomment://增加评论
        {
            [tempParams setObject:@"getAddforumcomment" forKey:@"act"];
        }
            break;
            
           
        
        
        
        
       
            
        default:
            break;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/plain",nil];


    
    
    
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
