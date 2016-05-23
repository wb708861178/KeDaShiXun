//
//  WBCustomPictureWall.h
//  图片九宫格
//
//  Created by wangbing on 16/5/12.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectBlock) (NSInteger selectedIndex);
@interface WBCustomPictureWall : UIView
@property (nonatomic, copy) SelectBlock selectBlock;

- (instancetype)initWithFrame:(CGRect)frame withImageNameArr:(NSArray *)imageNameArr withTopSpace:(CGFloat)topSpace withLeftSpace:(CGFloat)leftSpace withHorizontalSpace:(CGFloat)horizontalSpace withVerticalSpace:(CGFloat)verticalSpace;


- (instancetype)initWithFrame:(CGRect)frame withImageUrlArr:(NSArray *)imageUrlArr withTopSpace:(CGFloat)topSpace withLeftSpace:(CGFloat)leftSpace withHorizontalSpace:(CGFloat)horizontalSpace withVerticalSpace:(CGFloat)verticalSpace;


@end
