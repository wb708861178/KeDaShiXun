//
//  WBMainCell3.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/11.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBMainCell3.h"
#import <UIImageView+WebCache.h>

@interface WBMainCell3 ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;


@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *placeLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation WBMainCell3
- (void)setKedaMessage:(WBKedaMessage *)kedaMessage
{
    _kedaMessage = kedaMessage;
    self.titleLabel.text = kedaMessage.title;
    self.placeLabel.text = kedaMessage.department;
    self.dateLabel.text = kedaMessage.date;
    
    NSArray *imageUrlArr = [kedaMessage.images componentsSeparatedByString:@"+"];
    [self.imageView1 sd_setImageWithURL:imageUrlArr[0]];
    [self.imageView2 sd_setImageWithURL:imageUrlArr[1]];
    [self.imageView3 sd_setImageWithURL:imageUrlArr[2]];
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
