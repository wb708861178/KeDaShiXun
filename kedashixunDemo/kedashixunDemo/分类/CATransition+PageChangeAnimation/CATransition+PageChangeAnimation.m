//
//  CATransition+PageChangeAnimation.m
//  页面动画转换
//
//  Created by wangbing on 16/4/21.
//  Copyright © 2016年 xk666. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CATransition+PageChangeAnimation.h"
/**
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
 CurlDown,                   //下翻页
 CurlUp,                     //上翻页
 FlipFromLeft,               //左翻转
 FlipFromRight,              //右翻转
 
 } AnimationType;

 
 subtype:
 kCATransitionFromLeft;
 kCATransitionFromBottom;
 kCATransitionFromRight;
 kCATransitionFromTop;
 */
@implementation CATransition (PageChangeAnimation)
+ (void)transitionWithAnimationType:(AnimationType)animationType WithSubtype:(NSString *)subtype ForView:(UIView *) view
{
    switch (animationType) {
        case Fade:
            [self transitionWithType:kCATransitionFade WithSubtype:subtype ForView:view];
            break;
            
        case Push:
            [self transitionWithType:kCATransitionPush WithSubtype:subtype ForView:view];
            break;
            
        case Reveal:
            [self transitionWithType:kCATransitionReveal WithSubtype:subtype ForView:view];
            break;
            
        case MoveIn:
            [self transitionWithType:kCATransitionMoveIn WithSubtype:subtype ForView:view];
            break;
            
        case Cube:
            [self transitionWithType:@"cube" WithSubtype:subtype ForView:view];
            break;
            
        case SuckEffect:
            [self transitionWithType:@"suckEffect" WithSubtype:subtype ForView:view];
            break;
            
        case OglFlip:
            [self transitionWithType:@"oglFlip" WithSubtype:subtype ForView:view];
            break;
            
        case RippleEffect:
            [self transitionWithType:@"rippleEffect" WithSubtype:subtype ForView:view];
            break;
            
        case PageCurl:
            [self transitionWithType:@"pageCurl" WithSubtype:subtype ForView:view];
            break;
            
        case PageUnCurl:
            [self transitionWithType:@"pageUnCurl" WithSubtype:subtype ForView:view];
            break;
            
        case CameraIrisHollowOpen:
            [self transitionWithType:@"cameraIrisHollowOpen" WithSubtype:subtype ForView:view];
            break;
            
        case CameraIrisHollowClose:
            [self transitionWithType:@"cameraIrisHollowClose" WithSubtype:subtype ForView:view];
            break;
            
        case CurlDown:
            [self animationWithView:view WithAnimationTransition:UIViewAnimationTransitionCurlDown];
            break;
            
        case CurlUp:
            [self animationWithView:view WithAnimationTransition:UIViewAnimationTransitionCurlUp];
            break;
            
        case FlipFromLeft:
            [self animationWithView:view WithAnimationTransition:UIViewAnimationTransitionFlipFromLeft];
            break;
            
        case FlipFromRight:
            [self animationWithView:view WithAnimationTransition:UIViewAnimationTransitionFlipFromRight];
            break;
            
        default:
            break;
    }

}


#pragma CATransition动画实现

+ (void) transitionWithType:(NSString *)type WithSubtype:(NSString *)subtype ForView:(UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 0.7;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}
#pragma UIView实现动画
+ (void) animationWithView:(UIView *)view WithAnimationTransition: (UIViewAnimationTransition)transition
{
    [UIView animateWithDuration:0.7 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}

@end
