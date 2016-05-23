//
//  WBNetworking.h
//  AFN简单封装
//
//  Created by wangbing on 16/2/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
  PostNetworkRequest,
  GetNetworkRequest

} NetworkRequestMethod;

typedef enum {
   

    NetType_getRegister,//注册
    NetType_getLogin,//登录
    NetType_getUpdateNickname,//修改昵称
    NetType_getUpdateSex,//修改性别
    NetType_getUpdateMotto,//修改签名
    NetType_getKedamessage,//科大时讯
    NetType_getForum,//论坛
    NetType_getComment//评论
    


    
}NetworkRequestStyle;


typedef void (^SuccessBlock)(id returnData);
typedef void (^FailureBlock)(NSError *error);

@interface WBNetworking : NSObject



+ (void)networkRequstWithNetworkRequestMethod:(NetworkRequestMethod)networkRequestMethod
                         networkRequestStyle:(NetworkRequestStyle)networkRequestStyle
                                      params:(NSDictionary *)params
                                successBlock:(SuccessBlock)successBlock
                                failureBlock:(FailureBlock)failureBlock;










@end
