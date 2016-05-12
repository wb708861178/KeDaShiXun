//
//  KTopicHeaderFrameModel.h
//  kedashixunDemo
//
//  Created by KZL on 16/5/11.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KTopicModel.h"

@interface KTopicHeaderFrameModel : NSObject

@property (nonatomic, strong) KTopicModel *topicModel;


@property (nonatomic, readonly) CGRect iconFrame;
@property (nonatomic, readonly) CGRect nameFrame;
@property (nonatomic, readonly) CGRect timeFrame;

@property (nonatomic, readonly) CGRect contentFrame;
@property (nonatomic, strong) NSMutableArray *imagesFrameArr;

@property (nonatomic, readonly) CGRect locationImgViewFrame;
@property (nonatomic, readonly) CGRect locationlblFrame;

@property (nonatomic, readonly) CGRect viewCountFrame;
@property (nonatomic, readonly) CGRect praiseFrame;
@property (nonatomic, readonly) CGRect commentFrame;

@property (nonatomic, readonly) CGRect commentViewFrame;

@property (nonatomic, readonly) CGFloat headerHeight;


- (instancetype)initWithDict:(NSDictionary *)dict;
@end
