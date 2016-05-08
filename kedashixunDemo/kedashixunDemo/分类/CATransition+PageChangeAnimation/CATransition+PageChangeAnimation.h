//
//  CATransition+PageChangeAnimation.h
//  页面动画转换
//
//  Created by wangbing on 16/4/21.
//  Copyright © 2016年 xk666. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
typedef enum : NSUInteger {
    Fade = 1,                   //淡化
    Push,                       //push
    Reveal,                     //揭开
    MoveIn,                     //覆盖
    Cube,                       //3D立方体
    SuckEffect,                 //吮吸
    OglFlip,                    //翻转
    RippleEffect,               //波纹
    PageCurl,                   //翻页
    PageUnCurl,                 //反翻页
    CameraIrisHollowOpen,       //开镜头
    CameraIrisHollowClose,      //关镜头

    
    
    //下面4个不用传Subtype
    CurlDown,                   //下翻页
    CurlUp,                     //上翻页
    FlipFromLeft,               //左翻转
    FlipFromRight,              //右翻转
    
//Subtype: kCATransitionFromLeft; kCATransitionFromBottom;kCATransitionFromRight; kCATransitionFromTop;
    
} AnimationType;
@interface CATransition (PageChangeAnimation)
+ (void)transitionWithAnimationType:(AnimationType)animationType WithSubtype:(NSString *)subtype ForView:(UIView *) view;



@end
