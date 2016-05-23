//
//  WBCustonSegment.h
//  BaiSiBuDeJieDemo
//
//  Created by wangbing on 16/3/29.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TouchItemBlock)(BOOL isLeft,NSInteger selectedIndex);

@interface WBCustonSegment : UIControl
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) CGFloat perWidth;
@property (nonatomic, strong) CALayer *underLayer;


@property (nonatomic, strong) UIColor *defaultColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *underLayerColor;

@property (nonatomic, assign) NSInteger selectedIdx;
@property (nonatomic, assign) NSInteger lastIdx;

//下面线的高度
@property (nonatomic, assign) CGFloat underLayerHeight;

@property (nonatomic, copy) TouchItemBlock touchItemBlock;


- (instancetype)initWithFrame:(CGRect)frame WithItems:(NSArray *)items withBgColor:(UIColor *)bgColor WithColor:(UIColor *)color WithSelectColor:(UIColor *)selectedColor withUnderLayerColor:(UIColor *)underLayerColor withUnderLayerHeight:(CGFloat)underLayerHeight;


@end
