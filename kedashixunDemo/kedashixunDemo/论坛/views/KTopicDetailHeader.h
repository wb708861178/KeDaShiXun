//
//  KTopicDetailHeader.h
//  kedashixunDemo
//
//  Created by KZL on 16/5/11.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTopicHeaderFrameModel.h"


@interface KTopicDetailHeader : UIView

@property (nonatomic, strong) KTopicHeaderFrameModel *topicHeaderFrameModel;

@property (nonatomic, assign) NSUInteger commentCount;

@property (nonatomic, copy) void(^showImageViewer)();
@end
