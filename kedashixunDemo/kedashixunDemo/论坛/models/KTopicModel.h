//
//  KTopicModel.h
//  kedashixunDemo
//
//  Created by KZL on 16/5/8.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTopicModel : NSObject


@property (nonatomic, copy) NSString *topicId;
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *topicType;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSArray *imagesUrlArr;
@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *supportnum;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
