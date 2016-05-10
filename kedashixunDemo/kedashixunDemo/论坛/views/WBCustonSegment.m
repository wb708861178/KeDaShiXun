//
//  WBCustonSegment.m
//  BaiSiBuDeJieDemo
//
//  Created by wangbing on 16/3/29.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBCustonSegment.h"

#define frameW frame.size.width
#define frameH frame.size.height

@interface WBCustonSegment ()


@end

@implementation WBCustonSegment

- (CALayer *)underLayer
{
    if (!_underLayer) {
        _underLayer = [CALayer layer];
        _underLayer.backgroundColor = [UIColor redColor].CGColor;
        if (_underLayerColor) {
             _underLayer.backgroundColor = _underLayerColor.CGColor;
        }
       
    }
     return _underLayer;
}

- (instancetype)initWithFrame:(CGRect)frame WithItems:(NSArray *)items WithColor:(UIColor *)color WithSelectColor:(UIColor *)selectedColor
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.items = items;
        self.perWidth = self.frameW / items.count;
        self.defaultColor = color;
        self.selectedColor = selectedColor;
        self.selectedIdx = 0;
        self.lastIdx = 0;
    }
    return self;
}

- (void)setSelectedIdx:(NSInteger)selectedIdx
{
    _selectedIdx = selectedIdx;
    self.underLayer.frame = CGRectMake(selectedIdx * self.perWidth, self.frameH - 2 , self.perWidth,  2);
    [self.layer addSublayer:self.underLayer];
    [self setNeedsDisplay];
   
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    self.selectedIdx = point.x / self.perWidth;
//    if (self.selectedIdx > self.lastIdx) {
//        self.touchItemBlock();
//    }
//    if (self.selectedIdx < self.lastIdx) {
//        self.touchItemBlock(NO);
//    }
    
    if (self.selectedIdx != self.lastIdx) {
        
        self.touchItemBlock(self.selectedIdx);
        self.lastIdx = self.selectedIdx;

    }
    
}


- (void)drawRect:(CGRect)rect {
    [self.items enumerateObjectsUsingBlock:^(NSString *   _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect = CGRectMake(self.perWidth * idx, 0, self.perWidth, self.frameH);
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary *attributes = @{NSForegroundColorAttributeName : idx == self.selectedIdx?self.selectedColor:self.defaultColor, NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName : [UIFont systemFontOfSize:18]};
        [obj drawInRect:rect withAttributes:attributes];
    }];
 }


@end
