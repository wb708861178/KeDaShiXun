//
//  UINavigationBar+NavBar_WBCustomBackgroud.m
//  FreeShuQiNovel
//
//  Created by wangbing on 16/4/27.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "UINavigationBar+NavBar_WBCustomBackgroudImage.h"

@implementation UINavigationBar (NavBar_WBCustomBackgroudImage)
- (void)setBackgroundImage:(UIImage*)image
{
    if(image == nil)
    {
        return ;
    }
    else
    {
       UIImageView * backgroundView = [[UIImageView alloc] initWithImage:image];
        backgroundView.tag = 1;
        backgroundView.frame = CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height);
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:backgroundView];
        [self sendSubviewToBack:backgroundView];
      
    }
}

//可以控制加入的空间在父控件的位置（层次）
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index
{
    [super insertSubview:view atIndex:index];
  
}
@end
