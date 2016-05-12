//
//  WBCustomPictureWall.m
//  图片九宫格
//
//  Created by wangbing on 16/5/12.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBCustomPictureWall.h"

@interface WBCustomPictureWall ()
@property (nonatomic, assign) CGFloat topSpace;
@property (nonatomic, assign) CGFloat leftSpace;
@property (nonatomic, assign) CGFloat horizontalSpace;

@property (nonatomic, assign) CGFloat verticalSpace;

@property (nonatomic, strong) NSArray *imageNameArr;

@end

@implementation WBCustomPictureWall




- (instancetype)initWithFrame:(CGRect)frame withImageNameArr:(NSArray *)imageNameArr withTopSpace:(CGFloat)topSpace withLeftSpace:(CGFloat)leftSpace withHorizontalSpace:(CGFloat)horizontalSpace withVerticalSpace:(CGFloat)verticalSpace
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageNameArr = imageNameArr;
        self.topSpace = topSpace;
        self.leftSpace = leftSpace;
        self.verticalSpace = verticalSpace;
        self.horizontalSpace =horizontalSpace;
        [self viewLayout];
        
        
        
    }
    return self;
}


- (void)viewLayout
{
    
    CGFloat tempImageViewW = (self.frame.size.width - 2 * self.leftSpace - 2 * self.horizontalSpace) / 3;
    
    
    for (int i = 0; i < self.imageNameArr.count; i++) {
        //行索引
        NSInteger lineIdx = i / 3;
        //列索引
        NSInteger rowIdx = i % 3;
        CGFloat tempImageViewX = self.leftSpace + rowIdx *(tempImageViewW + self.horizontalSpace);
        CGFloat tempImageViewY = self.topSpace + lineIdx * (tempImageViewW + self.verticalSpace);
        
        UIImageView *tempImageView = [[UIImageView alloc] init];
        
        
        tempImageView.frame = CGRectMake(tempImageViewX, tempImageViewY, tempImageViewW, tempImageViewW);
       
        UIImage *tempImage = [UIImage imageNamed:self.imageNameArr[i]];
        tempImageView.image = tempImage;
        tempImageView.tag = 100 + i;
        
        [self addSubview:tempImageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [tempImageView addGestureRecognizer:tap];
        tempImageView.userInteractionEnabled = YES;
        
    }
    
    
    //重新设定view的frame
    CGFloat viewHeight = self.topSpace + self.imageNameArr.count / 3.0 * (tempImageViewW + self.verticalSpace) + self.topSpace;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, viewHeight);
   
    
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    NSLog(@"2222222");
    UIImageView *tempImageView = (UIImageView *)tap.view;
    NSInteger selectedIndex = tempImageView.tag - 100;
    self.selectBlock(selectedIndex);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
