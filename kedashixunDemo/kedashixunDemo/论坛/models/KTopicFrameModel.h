//
//  KTopicFrameModel.h
//  kedashixunDemo
//
//  Created by KZL on 16/5/8.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KTopicModel.h"


@interface KTopicFrameModel : NSObject

@property (nonatomic, strong) KTopicModel *topicModel;

@property (nonatomic, readonly) CGRect iconFrame;
@property (nonatomic, readonly) CGRect nameFrame;
@property (nonatomic, readonly) CGRect timeFrame;
@property (nonatomic, readonly) CGRect locationFrame;
@property (nonatomic, readonly) CGRect topicTypeFrame;


@property (nonatomic, readonly) CGRect contentFrame;
@property (nonatomic, strong) NSMutableArray *imagesFrameArr;
@property (nonatomic, readonly) CGRect viewCountFrame;
@property (nonatomic, readonly) CGRect collectFrame;
@property (nonatomic, readonly) CGRect praiseFrame;
@property (nonatomic, readonly) CGRect commentFrame;
@property (nonatomic, readonly) CGFloat cellHeight;


- (instancetype)initWithDict:(NSDictionary *)dict;
@end
