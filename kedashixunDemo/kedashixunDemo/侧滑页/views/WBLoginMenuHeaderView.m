//
//  WBLoginMenuHeaderView.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/12.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBLoginMenuHeaderView.h"

@implementation WBLoginMenuHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)jumpToPersonalCenterVCBtnAction:(UIButton *)sender {
    self.jumpToPersonalCenterVCBlock();
}


@end
