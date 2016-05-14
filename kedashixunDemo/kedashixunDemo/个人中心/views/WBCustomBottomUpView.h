//
//  WBCustomBottomUpView.h
//  WBCustomBottomUpView
//
//  Created by wangbing on 16/5/13.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <UIKit/UIKit.h>
//selectedIndex从0开始
typedef void (^SelectedIndexBlock)(NSInteger selectedIndex);
@interface WBCustomBottomUpView : UIView
@property (nonatomic, copy) SelectedIndexBlock selectedIndexBlock;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIColor *lineColor;




//先传属性
- (void)setBgColor:(UIColor *)bgColor textColor:(UIColor *)textColor textFont:(UIFont *)textFont lineColor:(UIColor *)lineColor;
//在设置值
- (void)setTextArr:(NSArray *)textArr withBottomViewHeightRatio:(CGFloat)bottomViewHeightRatio;
@end
