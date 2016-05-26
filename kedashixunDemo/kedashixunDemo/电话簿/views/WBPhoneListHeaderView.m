//
//  WBPhoneListHeaderView.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/23.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBPhoneListHeaderView.h"
#import "Const.h"

@interface WBPhoneListHeaderView ()



@end

@implementation WBPhoneListHeaderView





- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = kBtnSelectedColor;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40,(50 - 20) * 0.5 , 200, 20)];
        _titleLabel.textColor = [UIColor whiteColor];
        
        
        [self addSubview:_titleLabel];
        
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 20 - 8 , (50 - 8 ) * 0.5, 8, 8)];
        _arrowImageView.image = [UIImage imageNamed:@"arrow_left"];
      
        
      
        
       
        [self.contentView addSubview:_arrowImageView];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
        
        
    }
    return self;
}


- (void)setPhoneList:(WBPhoneList *)phoneList
{
    _phoneList = phoneList;
    self.titleLabel.text = phoneList.place;
 
   
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
   //修改的是数据源，当header刷新后，属性都是刷新的，但数据源已经改变
    self.phoneList.isOpen = !self.phoneList.isOpen;

  _arrowImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
   

    self.reloadTableView();
}




@end
