//
//  KTopicFrameModel.m
//  kedashixunDemo
//
//  Created by KZL on 16/5/8.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "KTopicFrameModel.h"

#define space 10


@implementation KTopicFrameModel

- (void)setTopicModel:(KTopicModel *)topicModel{
    
    _topicModel = topicModel;
    
    //计算坐标
    CGFloat iconW = 40,iconH = iconW;
    
    _iconFrame = CGRectMake(space, space, iconW, iconH);
    

    
    
}









@end
