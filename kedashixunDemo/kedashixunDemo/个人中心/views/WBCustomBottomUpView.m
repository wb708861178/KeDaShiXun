//
//  WBCustomBottomUpView.m
//  WBCustomBottomUpView
//
//  Created by wangbing on 16/5/13.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBCustomBottomUpView.h"

@interface WBCustomBottomUpView ()

@property (nonatomic, strong) UIView *shadowView;


@property (strong, nonatomic)  UIView *bottomView;




@property (nonatomic, strong) NSArray *textArr;
@property (nonatomic, assign) CGFloat bottomViewHeightRatio;
@end


@implementation WBCustomBottomUpView




//先传属性
- (void)setBgColor:(UIColor *)bgColor textColor:(UIColor *)textColor textFont:(UIFont *)textFont lineColor:(UIColor *)lineColor
{
    self.bgColor = bgColor;
    self.textColor = textColor;
    self.textFont = textFont;
    self.lineColor = lineColor;
}
//在设置值
- (void)setTextArr:(NSArray *)textArr withBottomViewHeightRatio:(CGFloat)bottomViewHeightRatio
{
    self.textArr = textArr;
    self.bottomViewHeightRatio = bottomViewHeightRatio;
    [self viewLayout];
}




- (void)viewLayout
{
    self.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *shadowViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shadowViewTap)];
    //阴影view防止父类透明度变化时 影响子控件
    _shadowView = [[UIView alloc] initWithFrame:self.bounds];
    _shadowView.backgroundColor = [UIColor blackColor];
    _shadowView.alpha = 0;
    
    [_shadowView addGestureRecognizer:shadowViewTap];
   
    [self addSubview:_shadowView];
    
    
    
    
    CGFloat bottomViewH = self.frame.size.height * self.bottomViewHeightRatio;
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height , self.frame.size.width, bottomViewH)];
        [self addSubview:self.bottomView];
    
    self.bottomView.backgroundColor = [UIColor whiteColor];
    if (self.bgColor) {
        self.bottomView.backgroundColor = self.bgColor;
    }
    [UIView animateWithDuration:0.5 animations:^{
        _shadowView.alpha = 0.5;
        self.bottomView.frame = CGRectMake(0, self.frame.size.height -  bottomViewH, self.frame.size.width, bottomViewH);
       
    }];
    
   
    CGFloat tempViewHeight = bottomViewH / self.textArr.count;
    
    for (int i = 0; i < self.textArr.count; i++) {
        UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, i * tempViewHeight, self.frame.size.width, tempViewHeight)];

        tempView.tag = 100+i;
        [self.bottomView addSubview:tempView];
        
        CGFloat tempLabelH = tempViewHeight * 3 / 4;
        CGFloat tempLabelW = tempView.frame.size.width * 3 / 4;
        CGFloat tempLabelX = (tempView.frame.size.width - tempLabelW ) * 0.5;
        CGFloat tempLabelY = (tempView.frame.size.height - tempLabelH ) * 0.5;
        
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(tempLabelX, tempLabelY, tempLabelW,tempLabelH)];
        
        
    
        tempLabel.textAlignment = NSTextAlignmentCenter;
        tempLabel.text = self.textArr[i];
        
        tempLabel.textColor =[UIColor blackColor];
        if (self.textColor) {
            tempLabel.textColor = self.textColor;
        }
        if (self.textFont) {
            tempLabel.font = self.textFont;
        }
        [tempView addSubview:tempLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, tempView.frame.size.height - 1, tempView.frame.size.width, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        if (self.lineColor) {
            lineView.backgroundColor = self.lineColor;
        }
        [tempView addSubview:lineView];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [tempView addGestureRecognizer:tap];
        
    }
}


- (void)shadowViewTap
{
    [self viewRemove];
}


- (void)tap:(UITapGestureRecognizer *)tap
{
    UIView *aView = tap.view;
        for (int i = 0; i < self.textArr.count; i++) {
        if (aView.tag == i + 100) {
            self.selectedIndexBlock(i);
            [self viewRemove];
        }
    }
    
    
    
    
}


- (void)viewRemove{
    CGFloat bottomViewH = self.frame.size.height * self.bottomViewHeightRatio;
    [UIView animateWithDuration:0.5 animations:^{
        _shadowView.alpha = 0;
        self.bottomView.frame = CGRectMake(0, self.frame.size.height , self.frame.size.width, bottomViewH);
    } completion:^(BOOL finished) {
         [self removeFromSuperview];
    }];

    
   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
