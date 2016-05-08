//
//  WBDetailTabBarViewController.m
//  FreeShuQiNovel
//
//  Created by wangbing on 16/4/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBDetailTabBarViewController.h"
#import "WBRankingListViewController.h"
#import "WBClassifyViewController.h"
#import "WBSearchViewController.h"
#import "WBNavViewController.h"

@interface WBDetailTabBarViewController ()

@end

@implementation WBDetailTabBarViewController
/**
 navBar是在viewController 初始化之后加进来的  隐藏必须在中
 */
-(void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   
    
    self.view.backgroundColor = [UIColor cyanColor];
    [self addViewController:[[WBRankingListViewController alloc] initWithViewControllerNavItemStyle:ViewControllerNavItemStyleDetail] withTitle:@"排行榜" withImageName:@"navbar_chapter" withSelectImageName:@"navbar_chapter"];
    [self addViewController:[[WBClassifyViewController alloc] initWithViewControllerNavItemStyle:ViewControllerNavItemStyleDetail] withTitle:@"分类" withImageName:@"navbar_chapter" withSelectImageName:@"navbar_chapter"];
    [self addViewController:[[WBSearchViewController alloc] initWithViewControllerNavItemStyle:ViewControllerNavItemStyleDetail] withTitle:@"搜索" withImageName:@"navbar_chapter" withSelectImageName:@"navbar_chapter"];
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
