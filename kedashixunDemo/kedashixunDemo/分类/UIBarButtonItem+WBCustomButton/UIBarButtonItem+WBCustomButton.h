//
//  UIBarButtonItem+WBCustomButton.h
//  BaiSiBuDeJieDemo
//
//  Created by wangbing on 16/3/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WBCustomButton)

/**
 普通的对于左右两边只有一个按钮的时候
 */
+(NSArray *)barButtonItemWithImageName:(NSString *)imageName withHighlightedImageName:(NSString *)highlightedImageName withTarget:(id)target withAction:(SEL)action WithNegativeSpacerWidth:(CGFloat)negativeSpacerWidth;

/**
 普通的对于左边有一个按钮加文字的时候
 */
- (void)setBarButtonItemWithTitle:(NSString *)title WithTitleColor:(UIColor *)titleColor WithTitleHighlightColor:(UIColor *)titleHighlightColor;

/**
 普通的对于左右两边有多个按钮的时候
 */
+(NSArray *)barButtonItemWithNum:(NSInteger)btnNum WithImageNameArr:(NSArray *)imageNameArr withHighlightedImageNameArr:(NSArray *)highlightedImageNameArr withTarget:(id)target withAction0:(SEL)action0 withAction1:(SEL)action1 withAction2:(SEL)action2  WithNegativeSpacerWidthArr:(NSArray *)negativeSpacerWidthArr;

/**
 *  添加按钮 只有文字
 *
 *  @param title               <#title description#>
 *  @param titleColor          <#titleColor description#>
 *  @param titleHighlightColor <#titleHighlightColor description#>
 *  @param target              <#target description#>
 *  @param action              <#action description#>
 *  @param negativeSpacerWidth <#negativeSpacerWidth description#>
 *
 *  @return <#return value description#>
 */
+(NSArray *)barButtonItemWithTitle:(NSString *)title WithTitleColor:(UIColor *)titleColor WithTitleHighlightColor:(UIColor *)titleHighlightColor withTarget:(id)target withAction:(SEL)action WithNegativeSpacerWidth:(CGFloat)negativeSpacerWidth;
@end


