//
//  WBCustomNavView.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/11.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBCustomNavView.h"

@implementation WBCustomNavView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.bgView.alpha = 0.5;
}

- (IBAction)menuBtnAction:(UIButton *)sender {
    self.jumpToMenuVCBlock();
}


- (IBAction)searchBtnAction:(UIButton *)sender {
    self.jumpToSearchVCBlock();
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


@end
