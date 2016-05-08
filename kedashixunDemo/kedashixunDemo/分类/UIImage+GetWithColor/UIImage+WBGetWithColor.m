//
//  UIImage+WBGetWithColor.m
//  FreeShuQiNovel
//
//  Created by wangbing on 16/5/2.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "UIImage+WBGetWithColor.h"

@implementation UIImage (WBGetWithColor)
+ (instancetype)imageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
