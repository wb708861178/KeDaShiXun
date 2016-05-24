//
//  WBPhoneListHeaderView.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/23.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBPhoneListHeaderView.h"

@interface WBPhoneListHeaderView ()
@property (strong, nonatomic)  UILabel *titleLabel;

@property (strong, nonatomic) UIImageView *arrowImageView;


@end

@implementation WBPhoneListHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,(self.frame.size.height - 20) * 0.5 , 200, 20)];
        [self addSubview:_titleLabel];
        
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 10 - 10 , (self.frame.size.height - 15 ) * 0.5, 10, 15)];
        _arrowImageView.image = [UIImage imageNamed:@"arrow"];
        
        [self addSubview:_arrowImageView];
        
        
    }
    return self;
}


- (void)setPhoneList:(WBPhoneList *)phoneList
{
    _phoneList = phoneList;
    self.titleLabel.text = phoneList.place;
}

- (void)tapHeadAction:(UITapGestureRecognizer *)sender {
}




@end
