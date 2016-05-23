//
//  WBMyPublishViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/16.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBMyPublishViewController.h"
#import "KTopicCell.h"
#import "Const.h"

@interface WBMyPublishViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation WBMyPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setNavBarTitleWithText:@"我的发帖" withFontSize:20.f withTextColor:[UIColor whiteColor]];
    self.hasReturnArrow = YES;
    [self viewLayout];
}

- (void)viewLayout
{
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 74, kWidth - 10, kHeight - 64 - 10) style:UITableViewStylePlain];
    
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.backgroundColor = kBGDefaultColor;
    [self.view addSubview:_mainTableView];

    [_mainTableView registerClass:[KTopicCell class] forCellReuseIdentifier:@"KTopicCell"];
}
#pragma mark----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
            KTopicCell *topicCell = [tableView dequeueReusableCellWithIdentifier:@"KTopicCell" forIndexPath:indexPath];
        return topicCell;
  
    
    return nil;
}

#pragma mark----UITableViewDelegate


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
