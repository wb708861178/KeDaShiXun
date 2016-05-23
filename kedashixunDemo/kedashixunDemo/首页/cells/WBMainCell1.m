//
//  WBMainCell1.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/11.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBMainCell1.h"

@interface WBMainCell1 ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *placeLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end


@implementation WBMainCell1

- (void)setKedaMessage:(WBKedaMessage *)kedaMessage
{
    _kedaMessage = kedaMessage;
    self.titleLabel.text = kedaMessage.title;
    self.placeLabel.text = kedaMessage.department;
    self.dateLabel.text = kedaMessage.date;
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
