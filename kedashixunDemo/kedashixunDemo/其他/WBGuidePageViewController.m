//
//  WBGuidePageViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBGuidePageViewController.h"
#import "WBGuidePageView.h"

@interface WBGuidePageViewController ()

@end

@implementation WBGuidePageViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    WBGuidePageView *guidePageView = [[WBGuidePageView alloc] initWithFrame:self.view.bounds withImageNameArr:@[@"guide1",@"guide2",@"guide3"]];
    
    guidePageView.jumpMainVCBlock = ^{
        self.jumpMainVCBlock();
    };
    
    [self.view addSubview:guidePageView];
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
