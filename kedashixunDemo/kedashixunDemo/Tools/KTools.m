//
//  KTools.m
//  kedashixunDemo
//
//  Created by KZL on 16/5/12.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "KTools.h"

@implementation KTools


+ (NSString *)currentDate{
    
    NSDate *currentDate = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    
    return [formatter stringFromDate:currentDate];
}

@end
