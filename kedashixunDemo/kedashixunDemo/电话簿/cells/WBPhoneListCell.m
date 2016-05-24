//
//  WBPhoneListCell.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/23.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBPhoneListCell.h"

@interface WBPhoneListCell ()
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;


@end

@implementation WBPhoneListCell

- (void)setPhoneList:(WBPhoneList *)phoneList
{
    _phoneList = phoneList;
    self.placeLabel.text = phoneList.place;
    self.phoneNumLabel.text = phoneList.phonenum;
    
}

- (void)awakeFromNib {
    // Initialization code
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
