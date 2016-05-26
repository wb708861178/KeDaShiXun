//
//  KTopicModel.m
//  kedashixunDemo
//
//  Created by KZL on 16/5/8.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "KTopicModel.h"



@implementation KTopicModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        
        self.topicId = dict[@"forumid"];
        self.iconName = dict[@"icon"];
        self.name = dict[@"nickname"];
        self.time = dict[@"date"];
        self.location = dict[@"place"];
        self.content = dict[@"content"];
        self.viewCount = dict[@"looknum"];
        self.supportnum = dict[@"supportnum"];
        self.imagesUrlArr = [dict[@"images"] componentsSeparatedByString:@","];
    }
    
    return self;
}
@end
