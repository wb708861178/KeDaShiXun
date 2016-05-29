//
//  WBCustomSearchBar.m
//  WBCustomSearchBar
//
//  Created by wangbing on 16/5/17.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBCustomSearchBar.h"

@implementation WBCustomSearchBar
- (instancetype)initWithFrame:(CGRect)frame withSearchImageName:(NSString *)searchImageName
{
    self = [super initWithFrame:frame];
    if (self) {

       
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @" 请输入查询条件";

        
        // 通过init初始化的控件大多都没有尺寸
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:searchImageName];
        // contentMode：default is UIViewContentModeScaleToFill，要设置为UIViewContentModeCenter：使图片居中，防止图片填充整个imageView
        searchIcon.contentMode = UIViewContentModeRight;
        searchIcon.frame = CGRectMake(searchIcon.frame.origin.x, searchIcon.frame.origin.y, 30, 30);
        
        
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        
       
        
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
