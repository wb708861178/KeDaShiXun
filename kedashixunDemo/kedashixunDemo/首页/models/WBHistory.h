//
//  WBHistory.h
//  kedashixunDemo
//
//  Created by wangbing on 16/5/26.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBDBModel.h"

@interface WBHistory : WBDBModel
@property (nonatomic, assign) int historyid;
@property (nonatomic, assign) int uid;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *status;


@end
