//
//  UILabel+ResetContent.h
//  kedashixunDemo
//
//  Created by wangbing on 16/5/23.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ResetContent)

+ (instancetype)resetContentWithContent:(NSString *)content withFontSize:(CGFloat)fontSize   withLineHeight:(CGFloat)lineHeight withLineSapce:(CGFloat)lineSpace withHeadIndent:(CGFloat)headIndent;


@end
