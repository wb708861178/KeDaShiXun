//
//  UIView+WBLocation.h
//  ViewLocation
//
//  Created by wangbing on 16/3/19.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WBLocation)
@property (assign,nonatomic) CGFloat frameX;
@property (assign,nonatomic) CGFloat frameY;
@property (assign,nonatomic) CGFloat frameW;
@property (assign,nonatomic) CGFloat frameH;

@property (assign,nonatomic) CGFloat boundsX;
@property (assign,nonatomic) CGFloat boundsY;
@property (assign,nonatomic) CGFloat boundsW;
@property (assign,nonatomic) CGFloat boundsH;

@property (assign,nonatomic) CGFloat centerX;
@property (assign,nonatomic) CGFloat centerY;
@end
