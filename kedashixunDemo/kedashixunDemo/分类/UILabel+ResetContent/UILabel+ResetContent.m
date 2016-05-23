//
//  UILabel+ResetContent.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/23.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "UILabel+ResetContent.h"

@implementation UILabel (ResetContent)
+ (instancetype)resetContentWithContent:(NSString *)content withFontSize:(CGFloat)fontSize   withLineHeight:(CGFloat)lineHeight withLineSapce:(CGFloat)lineSpace withHeadIndent:(CGFloat)headIndent
{
    UILabel *tempLabel = [[UILabel alloc] init];
    tempLabel.text = content;
    
    NSMutableAttributedString *attributedString = [[ NSMutableAttributedString alloc ] initWithString:tempLabel.text ];
    NSMutableDictionary *attributes = [@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} mutableCopy];
    [attributedString addAttributes:attributes range:NSMakeRange ( 0 , [tempLabel.text length ])];
    
   
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc ] init];
    
    paragraphStyle. alignment = NSTextAlignmentLeft ;
    
    paragraphStyle. maximumLineHeight = lineHeight ;  //最大的行高
    
    paragraphStyle. lineSpacing = lineSpace ;  //行自定义行高度
    
    [paragraphStyle setFirstLineHeadIndent:tempLabel.frame.size.width + headIndent ]; //首行缩进 headIndent个像素
    
    
    
    
    [attributedString addAttribute : NSParagraphStyleAttributeName value :paragraphStyle range:NSMakeRange ( 0 , [tempLabel.text length ])];
    
    tempLabel.attributedText = attributedString;
    
    [tempLabel sizeToFit ];
    return tempLabel;
}
@end
