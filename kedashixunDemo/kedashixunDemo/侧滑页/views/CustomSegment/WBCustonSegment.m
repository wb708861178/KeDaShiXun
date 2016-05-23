//
//  WBCustonSegment.m
//  BaiSiBuDeJieDemo
//
//  Created by wangbing on 16/3/29.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBCustonSegment.h"
#import "UIView+WBLocation.h"

@interface WBCustonSegment ()


@end

@implementation WBCustonSegment

- (CALayer *)underLayer
{
    if (!_underLayer) {
        _underLayer = [CALayer layer];
        _underLayer.backgroundColor = _underLayerColor.CGColor;
        if (_underLayerColor) {
             _underLayer.backgroundColor = _underLayerColor.CGColor;
        }
       
    }
     return _underLayer;
}

- (instancetype)initWithFrame:(CGRect)frame WithItems:(NSArray *)items withBgColor:(UIColor *)bgColor WithColor:(UIColor *)color WithSelectColor:(UIColor *)selectedColor withUnderLayerColor:(UIColor *)underLayerColor withUnderLayerHeight:(CGFloat)underLayerHeight
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.items = items;
        self.backgroundColor = bgColor;
        self.perWidth = self.frameW / items.count;
        self.defaultColor = color;
        self.selectedColor = selectedColor;
        
        
        self.underLayerColor = underLayerColor;
        self.underLayerHeight = underLayerHeight;
        //当选择后出发set方法属性就加不上去了
        self.selectedIdx = 0;
        self.lastIdx = 0;
        
    }
    return self;
}

- (void)setSelectedIdx:(NSInteger)selectedIdx
{
    _selectedIdx = selectedIdx;
    self.underLayer.frame = CGRectMake(selectedIdx * self.perWidth, self.frameH - _underLayerHeight , self.perWidth,  _underLayerHeight);
    [self.layer addSublayer:self.underLayer];
    [self setNeedsDisplay];
   
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    self.selectedIdx = point.x / self.perWidth;
    if (self.selectedIdx > self.lastIdx) {
        self.touchItemBlock(YES,self.selectedIdx);
    }
    if (self.selectedIdx < self.lastIdx) {
        self.touchItemBlock(NO,self.selectedIdx);
    }
     self.lastIdx = self.selectedIdx;
    
}


- (void)drawRect:(CGRect)rect {
    [self.items enumerateObjectsUsingBlock:^(NSString *   _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat rectH = (self.frameH - self.underLayerHeight ) * 0.5;
        CGFloat rectY = (self.frameH - self.underLayerHeight - rectH) * 0.5;
        
        CGRect rect = CGRectMake(self.perWidth * idx, rectY, self.perWidth, rectH);
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary *attributes = @{NSForegroundColorAttributeName : idx == self.selectedIdx?self.selectedColor:self.defaultColor, NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName : [UIFont systemFontOfSize:20]};
        [obj drawInRect:rect withAttributes:attributes];
    }];
 }


@end
