//
//  UIView+WBLocation.m
//  ViewLocation
//
//  Created by wangbing on 16/3/19.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "UIView+WBLocation.h"

@implementation UIView (WBLocation)
//***********************frame***********************//
-(CGFloat)frameX{
    return self.frame.origin.x;
}
-(void)setFrameX:(CGFloat)frameX{
    CGRect frame = self.frame;
    frame.origin.x = frameX;
    self.frame = frame;
}

-(CGFloat)frameY{
    return self.frame.origin.y;
}
-(void)setFrameY:(CGFloat)frameY{
    CGRect frame = self.frame;
    frame.origin.y = frameY;
    self.frame = frame;
}

-(CGFloat)frameW{
    return self.frame.size.width;
}
-(void)setFrameW:(CGFloat)frameW{
    CGRect frame = self.frame;
    frame.size.width = frameW;
    self.frame = frame;
}

-(CGFloat)frameH{
    return self.frame.size.height;
}
-(void)setFrameH:(CGFloat)frameH{
    CGRect frame = self.frame;
    frame.size.height = frameH;
    self.frame = frame;
}

//***********************bounds***********************//
-(CGFloat)boundsX{
    return self.bounds.origin.x;
}
-(void)setBoundsX:(CGFloat)boundsX{
    CGRect bounds = self.bounds;
    bounds.origin.x = boundsX;
    self.bounds = bounds;
}

-(CGFloat)boundsY{
    return self.bounds.origin.y;
}
-(void)setBoundsY:(CGFloat)boundsY{
    CGRect bounds = self.bounds;
    bounds.origin.y = boundsY;
    self.bounds = bounds;
}

-(CGFloat)boundsW{
    return self.bounds.size.width;
}
-(void)setBoundsW:(CGFloat)boundsW{
    CGRect bounds = self.bounds;
    bounds.size.width = boundsW;
    self.bounds = bounds;
}

-(CGFloat)boundsH{
    return self.bounds.size.height;
}

-(void)setBoundsH:(CGFloat)boundsH{
    CGRect bounds = self.bounds;
    bounds.size.height = boundsH;
    self.bounds = bounds;
}

//***********************center***********************//
-(CGFloat)centerX{
    return self.center.x;
}
-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

-(CGFloat)centerY{
    return self.center.y;
}
-(void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
@end
