//
//  WBMainCell2.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/11.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBMainCell2.h"

#import <UIImageView+WebCache.h>

@interface WBMainCell2 ()
@property (weak, nonatomic) IBOutlet UIImageView *leftImageview;


@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *placeLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation WBMainCell2
- (void)setKedaMessage:(WBKedaMessage *)kedaMessage
{
    _kedaMessage = kedaMessage;
    self.titleLabel.text = kedaMessage.title;
    self.placeLabel.text = kedaMessage.department;
    self.dateLabel.text = kedaMessage.date;
    [self.leftImageview sd_setImageWithURL:[NSURL URLWithString:kedaMessage.images]];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
