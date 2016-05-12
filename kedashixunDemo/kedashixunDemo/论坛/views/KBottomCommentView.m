//
//  KBottomCommentView.m
//  kedashixunDemo
//
//  Created by KZL on 16/5/12.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "KBottomCommentView.h"

@interface KBottomCommentView ()




@end

@implementation KBottomCommentView

- (void)awakeFromNib{
    
    _commentTF.layer.cornerRadius = _commentTF.frame.size.height/2;
    _commentTF.layer.masksToBounds = YES;
    _commentTF.layer.borderWidth = 1.f;
    _commentTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
