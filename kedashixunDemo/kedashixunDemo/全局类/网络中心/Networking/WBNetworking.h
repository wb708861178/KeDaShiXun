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
   

    NetType_getIsRegiste,//是否注册
    NetType_getRegister,//注册
    NetType_getLogin,//登录
    NetType_getUpdateNickname,//修改昵称
    NetType_getUpdateSex,//修改性别
    NetType_getUpdateMotto,//修改签名
    NetType_getUpdateUserPwd,//修改密码
    
    
    NetType_getKedamessage,//科大时讯
    NetType_getKedamessageCollection,//得到科大时讯收藏
    NetType_getAddKedamcollection,//增加科大时讯收藏
    NetType_getKedamcollectionstatus,//得到科大时讯收藏状态
    NetType_getAddkedamcollectionstatus,//增加科大时讯收藏状态
    NetType_getUpdateKedamCollectionStatus,//修改时讯收藏状态
    
    
    NetType_getForum,//论坛
    NetType_getForumPartIn,//自己发表的论坛
    NetType_getComment,//评论
    NetType_getForumsupportstatus,//得到点赞和收藏状态（空时400插入）
    NetType_getForumaddsupport,//增加用户状态
    NetType_getUpdateForumCollectStatus,//修改论坛收藏状态
    NetType_getUpdateForumSupportStatus,//修改论坛点赞状态
    NetType_getAddforum,//增加论坛帖子
    NetType_getUpdatesupportnum,//修改论坛点赞量
    NetType_getAddforumcomment,//增加评论
    NetType_getFcollection,//论坛收藏
    
    NetType_getPhonelist,//电话簿
    
    
    NetType_getHistory, //历史记录
    NetType_getHistoryDelete,//删除历史记录
    NetType_getSearch, //搜索相关时讯
   NetType_getSearchresult,//点击相关时讯
    NetType_getIsaddhistory,//是否能增加历史记录
    NetType_getAddhistory //增加历史记录

    
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
