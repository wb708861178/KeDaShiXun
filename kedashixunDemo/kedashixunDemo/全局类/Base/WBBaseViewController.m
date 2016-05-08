//
//  WBBaseViewController.m
//  FreeShuQiNovel
//
//  Created by wangbing on 16/4/19.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBBaseViewController.h"
#import "UIBarButtonItem+WBCustomButton.h"
#import "RESideMenu.h"
#import "WBMenuViewController.h"
#import "WBDetailTabBarViewController.h"
#import "CATransition+PageChangeAnimation.h"

@interface WBBaseViewController ()

@end

@implementation WBBaseViewController

- (instancetype)initWithViewControllerNavItemStyle:(ViewControllerNavItemStyle)viewControllerNavItemStyle{
    self = [super init];
    if (self) {
        //不让view受navbar的影响
      
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        switch (viewControllerNavItemStyle) {
            case ViewControllerNavItemStyleMain:
            {
               
                self.navigationItem.leftBarButtonItems = [UIBarButtonItem barButtonItemWithImageName:@"navbar_chapter" withHighlightedImageName:nil withTarget:self withAction:@selector(menuBtnAction) WithNegativeSpacerWidth:-10];
    
                
                self.navigationItem.rightBarButtonItems = [UIBarButtonItem barButtonItemWithImageName:@"navbar_chapter" withHighlightedImageName:nil withTarget:self withAction:@selector(searchBtnAction:) WithNegativeSpacerWidth:-10];

            }
                break;
           
            case ViewControllerNavItemStyleForum:
            {
                self.navigationItem.rightBarButtonItems = [UIBarButtonItem barButtonItemWithImageName:@"navbar_chapter" withHighlightedImageName:nil withTarget:self withAction:@selector(returnBookcaseBtnAction)  WithNegativeSpacerWidth:-10];

            }
                break;
                
                
            case ViewControllerNavItemStyleGuidance:
            {

                
                self.navigationItem.leftBarButtonItems = [UIBarButtonItem barButtonItemWithNum:1 WithImageNameArr:@[@"navbar_chapter"] withHighlightedImageNameArr:nil withTarget:self withAction0:@selector(readNavBarReturnbtnAction:) withAction1:nil withAction2:nil WithNegativeSpacerWidthArr:@[@"-10"]];
                
                
                self.navigationItem.rightBarButtonItems = [UIBarButtonItem barButtonItemWithNum:3 WithImageNameArr:@[@"navbar_chapter",@"navbar_chapter",@"navbar_chapter"] withHighlightedImageNameArr:nil withTarget:self withAction0:@selector(readNavBarRightBtn1Action) withAction1:@selector(readNavBarRightBtn2Action) withAction2:@selector(readNavBarRightBtn3Action) WithNegativeSpacerWidthArr:@[@"-10",@"10",@"10"]];
                
                
                
                
               
                
            }
                break;
            case ViewControllerNavItemStylePhoneBook:
            {
                
                
                self.navigationItem.leftBarButtonItems = [UIBarButtonItem barButtonItemWithNum:1 WithImageNameArr:@[@"navbar_chapter"] withHighlightedImageNameArr:nil withTarget:self withAction0:@selector(readNavBarReturnbtnAction:) withAction1:nil withAction2:nil WithNegativeSpacerWidthArr:@[@"-10"]];
                
                
                self.navigationItem.rightBarButtonItems = [UIBarButtonItem barButtonItemWithNum:3 WithImageNameArr:@[@"navbar_chapter",@"navbar_chapter",@"navbar_chapter"] withHighlightedImageNameArr:nil withTarget:self withAction0:@selector(readNavBarRightBtn1Action) withAction1:@selector(readNavBarRightBtn2Action) withAction2:@selector(readNavBarRightBtn3Action) WithNegativeSpacerWidthArr:@[@"-10",@"10",@"10"]];
                
                
                
                
                
                
            }
                break;


                
            default:
                break;
        }
        
    }
    return self;
}

#pragma mark---设置navBar上面title的文字及属性
- (void)setNavBarTitleWithText:(NSString *)title withFontSize:(CGFloat)fontSize withTextColor:(UIColor *)color{
    self.navigationItem.title = title;
    // 设置导航默认标题的颜色及字体大小
    NSDictionary *attributes = @{NSForegroundColorAttributeName : color, NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    self.navigationController.navigationBar.titleTextAttributes = attributes;
}

#pragma mark----navBar按钮单击事件


- (void)menuBtnAction
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (void)searchBtnAction:(UIButton *)sender
{
   
  
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
