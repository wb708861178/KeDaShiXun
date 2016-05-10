//
//  WBCustonSegment.h
//  BaiSiBuDeJieDemo
//
//  Created by wangbing on 16/3/29.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TouchItemBlock)(NSInteger selectedIndex);

@interface WBCustonSegment : UIControl
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) CGFloat perWidth;
@property (nonatomic, strong) CALayer *underLayer;

@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *defaultColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *underLayerColor;

@property (nonatomic, assign) NSInteger selectedIdx;
@property (nonatomic, assign) NSInteger lastIdx;

@property (nonatomic, copy) TouchItemBlock touchItemBlock;


- (instancetype)initWithFrame:(CGRect)frame WithItems:(NSArray *)items WithColor:(UIColor *)color WithSelectColor:(UIColor *)selectedColor;


@end
