//
//  WBLoginMenuHeaderView.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/12.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBLoginMenuHeaderView.h"
#import "WBUserInfo.h"
#import <UIImageView+WebCache.h>

@interface WBLoginMenuHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *mottoLabel;


@end
@implementation WBLoginMenuHeaderView


- (void) updateData
{
    self.nickLabel.text = [WBUserInfo share].nickname;
    self.mottoLabel.text = [WBUserInfo share].motto;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[WBUserInfo share].icon]];
}



- (void)awakeFromNib
{
    [super awakeFromNib];
    self.nickLabel.text = [WBUserInfo share].nickname;
    self.mottoLabel.text = [WBUserInfo share].motto;
    
}
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
