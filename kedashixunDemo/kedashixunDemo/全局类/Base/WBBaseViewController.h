//
//  WBBaseViewController.h
//  FreeShuQiNovel
//
//  Created by wangbing on 16/4/19.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <UIKit/UIKit.h>





typedef NS_ENUM(NSInteger, ViewControllerNavItemStyle) {
    
    ViewControllerNavItemStyleMain = 0 ,//加载主界面
        ViewControllerNavItemStyleForum = 1,
    //加载详情里面的右边的
     ViewControllerNavItemStyleGuidance = 2,
    ViewControllerNavItemStylePhoneBook = 3
    
    
    
    
   
};

@interface WBBaseViewController : UIViewController

- (instancetype)initWithViewControllerNavItemStyle:(ViewControllerNavItemStyle)viewControllerNavItemStyle;
/**
    设置navBar上面title的文字及属性
 */
- (void)setNavBarTitleWithText:(NSString *)title withFontSize:(CGFloat)fontSize withTextColor:(UIColor *)color;
@end
