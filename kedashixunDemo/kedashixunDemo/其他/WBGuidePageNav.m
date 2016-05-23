//
//  WBGuidePageNav.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBGuidePageNav.h"
#import "WBTool.h"
#import "WBGuidePageViewController.h"
#import "WBLoginViewController.h"
#import "Const.h"




@interface WBGuidePageNav ()


@end

@implementation WBGuidePageNav

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.navigationBar.barTintColor = kMainColor;
        
         WBLoginViewController *loginVC = [[WBLoginViewController alloc] initWithNibName:@"WBLoginViewController" bundle:nil];
        if ([WBTool isVersionUpdate]) {
            
            WBGuidePageViewController *guidePageVC = [[WBGuidePageViewController alloc] init];
            guidePageVC.automaticallyAdjustsScrollViewInsets = NO;
            
            
           
            __weak typeof(guidePageVC) myGuidePageVC = guidePageVC;
            //VC起别名不行  下面为空
//            __weak typeof(loginVC) myLoginVC = loginVC;
            __weak typeof (self) mySelf = self;
            guidePageVC.jumpMainVCBlock = ^{
                [myGuidePageVC.navigationController pushViewController:loginVC animated:YES];
            };
            mySelf.viewControllers = @[guidePageVC];
           
        }else
        {
            self.viewControllers = @[loginVC];
        }

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
    

    
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
