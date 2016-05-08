//
//  UIBarButtonItem+WBCustomButton.m
//  BaiSiBuDeJieDemo
//
//  Created by wangbing on 16/3/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "UIBarButtonItem+WBCustomButton.h"

@implementation UIBarButtonItem (WBCustomButton)

//返回一个items数组

+(NSArray *)barButtonItemWithImageName:(NSString *)imageName withHighlightedImageName:(NSString *)highlightedImageName withTarget:(id)target withAction:(SEL)action WithNegativeSpacerWidth:(CGFloat)negativeSpacerWidth
{
    //UIBarButtonItem 的customView加view时会自动放在中心
    UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    if (imageName) {
//        tempButton.backgroundColor = [UIColor blackColor];
        [tempButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (highlightedImageName) {
         [tempButton setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    }
    
    [tempButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
   
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:tempButton];
   
    
    
    //设置left 和right 离左右的距离 negativeSpacer.width设为-20则刚好到边上
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = negativeSpacerWidth;
    
    return [NSArray arrayWithObjects:negativeSpacer,barBtnItem, nil];
    
}

- (void)setBarButtonItemWithTitle:(NSString *)title WithTitleColor:(UIColor *)titleColor WithTitleHighlightColor:(UIColor *)titleHighlightColor

{
    UIButton *tempButton = self.customView;
    [tempButton setTitle:title forState:UIControlStateNormal];
    [tempButton setTitleColor:titleColor forState:UIControlStateNormal];
    [tempButton setTitleColor:titleHighlightColor forState:UIControlStateHighlighted];
    
}



+(NSArray *)barButtonItemWithNum:(NSInteger)btnNum WithImageNameArr:(NSArray *)imageNameArr withHighlightedImageNameArr:(NSArray *)highlightedImageNameArr withTarget:(id)target withAction0:(SEL)action0 withAction1:(SEL)action1 withAction2:(SEL)action2  WithNegativeSpacerWidthArr:(NSArray *)negativeSpacerWidthArr
{
    switch (btnNum) {
        case 1:
        {
            //UIBarButtonItem 的customView加view时会自动放在中心
            UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
            if (imageNameArr) {
                //        tempButton.backgroundColor = [UIColor blackColor];
                [tempButton setImage:[UIImage imageNamed:imageNameArr[0]] forState:UIControlStateNormal];
            }
            if (highlightedImageNameArr) {
                [tempButton setImage:[UIImage imageNamed:highlightedImageNameArr[0]] forState:UIControlStateHighlighted];
            }
            
            
            [tempButton addTarget:target action:action0 forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:tempButton];
                        //设置left 和right 离左右的距离 negativeSpacer.width设为-20则刚好到边上
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            negativeSpacer.width = [negativeSpacerWidthArr.firstObject floatValue];
            
            return [NSArray arrayWithObjects:negativeSpacer,barBtnItem, nil];
        }
            break;
        case 2:
        {
           
            UIButton *tempButton0 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
            UIButton *tempButton1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
            [tempButton0 addTarget:target action:action0 forControlEvents:UIControlEventTouchUpInside];
            [tempButton1 addTarget:target action:action1 forControlEvents:UIControlEventTouchUpInside];

            if (imageNameArr) {
                //        tempButton.backgroundColor = [UIColor blackColor];
                [tempButton0 setImage:[UIImage imageNamed:imageNameArr[0]] forState:UIControlStateNormal];
                [tempButton1 setImage:[UIImage imageNamed:imageNameArr[1]] forState:UIControlStateNormal];
                
            }
            if (highlightedImageNameArr) {
                [tempButton0 setImage:[UIImage imageNamed:highlightedImageNameArr[0]] forState:UIControlStateHighlighted];
                [tempButton1 setImage:[UIImage imageNamed:highlightedImageNameArr[1]] forState:UIControlStateHighlighted];
               
            }
            
            
            UIBarButtonItem *barBtnItem0 = [[UIBarButtonItem alloc] initWithCustomView:tempButton0];
            UIBarButtonItem *barBtnItem1 = [[UIBarButtonItem alloc] initWithCustomView:tempButton1];
           
            
            UIBarButtonItem *negativeSpacer0 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            negativeSpacer0.width = [negativeSpacerWidthArr.firstObject floatValue];
            
            UIBarButtonItem *negativeSpacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            negativeSpacer1.width = [negativeSpacerWidthArr[1] floatValue];
           
            
            
            
            
            return [NSArray arrayWithObjects:negativeSpacer0,barBtnItem0,negativeSpacer1,barBtnItem1, nil];
            
            
        }
            break;
        case 3:
        {
            UIButton *tempButton0 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
            UIButton *tempButton1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
            UIButton *tempButton2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
             [tempButton0 addTarget:target action:action0 forControlEvents:UIControlEventTouchUpInside];
             [tempButton1 addTarget:target action:action1 forControlEvents:UIControlEventTouchUpInside];
             [tempButton2 addTarget:target action:action2 forControlEvents:UIControlEventTouchUpInside];
            if (imageNameArr) {
                //        tempButton.backgroundColor = [UIColor blackColor];
                [tempButton0 setImage:[UIImage imageNamed:imageNameArr[0]] forState:UIControlStateNormal];
                 [tempButton1 setImage:[UIImage imageNamed:imageNameArr[1]] forState:UIControlStateNormal];
                 [tempButton2 setImage:[UIImage imageNamed:imageNameArr[2]] forState:UIControlStateNormal];
            }
            if (highlightedImageNameArr) {
                [tempButton0 setImage:[UIImage imageNamed:highlightedImageNameArr[0]] forState:UIControlStateHighlighted];
                 [tempButton1 setImage:[UIImage imageNamed:highlightedImageNameArr[1]] forState:UIControlStateHighlighted];
                 [tempButton2 setImage:[UIImage imageNamed:highlightedImageNameArr[2]] forState:UIControlStateHighlighted];
            }
            
            

            
            UIBarButtonItem *barBtnItem0 = [[UIBarButtonItem alloc] initWithCustomView:tempButton0];
            UIBarButtonItem *barBtnItem1 = [[UIBarButtonItem alloc] initWithCustomView:tempButton1];
            UIBarButtonItem *barBtnItem2 = [[UIBarButtonItem alloc] initWithCustomView:tempButton2];
            
            UIBarButtonItem *negativeSpacer0 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            negativeSpacer0.width = [negativeSpacerWidthArr.firstObject floatValue];
            
            UIBarButtonItem *negativeSpacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            negativeSpacer1.width = [negativeSpacerWidthArr[1] floatValue];
            UIBarButtonItem *negativeSpacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            negativeSpacer2.width = [negativeSpacerWidthArr[2] floatValue];
            
            
            
            
            return [NSArray arrayWithObjects:negativeSpacer0,barBtnItem0,negativeSpacer1,barBtnItem1,negativeSpacer2,barBtnItem2, nil];
        }
            break;

            
        default: return nil;
            break;
    }
}




@end
