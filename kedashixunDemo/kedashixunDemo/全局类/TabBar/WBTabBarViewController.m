//
//  WBDetailTabBarViewController.m
//  FreeShuQiNovel
//
//  Created by wangbing on 16/4/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBTabBarViewController.h"
#import "WBNavViewController.h"
#import "WBMainViewController.h"
#import "WBForumViewController.h"
#import "WBGuidanceViewController.h"
#import "WBPhoneBookViewController.h"
#import "Const.h"

@interface WBTabBarViewController ()

@end

@implementation WBTabBarViewController
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


-(void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   
//    self.tabBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBar.barTintColor = kMainColor;
    
    [self addViewController:[[WBMainViewController alloc] initWithViewControllerNavItemStyle:ViewControllerNavItemStyleMain] withTitle:@"首页" withImageName:@"tabber_normal_1" withSelectImageName:@"tabbar_selected_1"];
    [self addViewController:[[WBForumViewController alloc] initWithViewControllerNavItemStyle:ViewControllerNavItemStyleForum] withTitle:@"论坛" withImageName:@"tabber_normal_2" withSelectImageName:@"tabbar_selected_2"];
    [self addViewController:[[WBGuidanceViewController alloc] initWithViewControllerNavItemStyle:ViewControllerNavItemStyleGuidance] withTitle:@"导航" withImageName:@"tabber_normal_3" withSelectImageName:@"tabbar_selected_3"];
    [self addViewController:[[WBPhoneBookViewController alloc] initWithViewControllerNavItemStyle:ViewControllerNavItemStylePhoneBook] withTitle:@"电话簿" withImageName:@"tabber_normal_4" withSelectImageName:@"tabbar_selected_4"];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addViewController:(UIViewController *)vc withTitle:(NSString *)title withImageName:(NSString *)imageName withSelectImageName:(NSString *)selectImageName
{
    
    vc.tabBarItem = [[UITabBarItem alloc] init];
    vc.tabBarItem.title = title;
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UIImage *normalImage = [UIImage imageNamed:imageName];
    UIImage *selectImage = [UIImage imageNamed:selectImageName];
    
    
    vc.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage =  [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置tabBarItem的属性
    NSDictionary *normalAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:11],NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#dddddd"]};
    NSDictionary *selectAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    [vc.tabBarItem setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:selectAttributes forState:UIControlStateSelected];
    
    WBNavViewController *nav = [[WBNavViewController alloc] initWithRootViewController:vc];
   
    [self addChildViewController:nav];
    
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
