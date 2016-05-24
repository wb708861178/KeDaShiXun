//
//  WBPhoneList.h
//  kedashixunDemo
//
//  Created by wangbing on 16/5/23.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBDBModel.h"

@interface WBPhoneList : WBDBModel
@property (nonatomic, assign) int phoneListid;
@property (nonatomic, copy) NSString *place;
@property (nonatomic, copy) NSString *phonenum;

@end
