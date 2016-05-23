//
//  WBKedaMessage.h
//  kedashixunDemo
//
//  Created by wangbing on 16/5/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBDBModel.h"

@interface WBKedaMessage : WBDBModel
@property (nonatomic, assign) int kedamessageid;
@property (nonatomic, assign) int type;
@property (nonatomic, copy) NSString *images;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *department;
@property (nonatomic, copy) NSString *content;



@end
