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


@interface WBTabBarViewController ()

@end

@implementation WBTabBarViewController

-(void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   
    
    self.view.backgroundColor = [UIColor cyanColor];
    [self addViewController:[[WBMainViewController alloc] initWithViewControllerNavItemStyle:ViewControllerNavItemStyleMain] withTitle:@"首页" withImageName:@"navbar_back" withSelectImageName:@"navbar_back"];
    [self addViewController:[[WBForumViewController alloc] initWithViewControllerNavItemStyle:ViewControllerNavItemStyleForum] withTitle:@"论坛" withImageName:@"navbar_back" withSelectImageName:@"navbar_back"];
    [self addViewController:[[WBGuidanceViewController alloc] initWithViewControllerNavItemStyle:ViewControllerNavItemStyleGuidance] withTitle:@"导航" withImageName:@"navbar_back" withSelectImageName:@"navbar_back"];
    [self addViewController:[[WBPhoneBookViewController alloc] initWithViewControllerNavItemStyle:ViewControllerNavItemStylePhoneBook] withTitle:@"电话簿" withImageName:@"navbar_back" withSelectImageName:@"navbar_back"];
    
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
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];
    //设置tabBarItem的属性
    NSDictionary *normalAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15],NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    NSDictionary *selectAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
    
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
