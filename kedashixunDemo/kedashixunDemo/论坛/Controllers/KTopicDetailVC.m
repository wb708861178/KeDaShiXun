//
//  KTopicDetailVC.m
//  kedashixunDemo
//
//  Created by KZL on 16/5/10.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "KTopicDetailVC.h"
#import "UIBarButtonItem+WBCustomButton.h"
#import "Const.h"
#import "KTopicDetailHeader.h"

#define space 10

@interface KTopicDetailVC () <UITableViewDataSource ,UITableViewDelegate>

@property (nonatomic, strong) UITableView *topicDetailTV;

@end

@implementation KTopicDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavBarTitleWithText:@"话题详情" withFontSize:20 withTextColor:[UIColor whiteColor]];
    
    self.navigationItem.leftBarButtonItems = [UIBarButtonItem barButtonItemWithImageName:@"arrow_left"  withHighlightedImageName:nil  withTarget:self withAction:@selector(pop) WithNegativeSpacerWidth:-16];
    
    
    [self viewLayout];
        
}

- (void)viewLayout{
    
    _topicDetailTV = [[UITableView alloc] initWithFrame:CGRectMake(space, space, kWidth-2*space, kHeight-64-space) style:UITableViewStylePlain];
    _topicDetailTV.delegate = self;
    _topicDetailTV.dataSource = self;
    [self.view addSubview:_topicDetailTV];
    
}

#pragma mark --- UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
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
