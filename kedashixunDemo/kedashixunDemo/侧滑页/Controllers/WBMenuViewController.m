//
//  WBMenuViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/8.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBMenuViewController.h"
#import "Const.h"
#import "WBPersonalCenterViewController.h"


@interface WBMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *imageNameArr;


@end

@implementation WBMenuViewController
#pragma mark-
#pragma mark----懒加载
- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = @[@"校历",@"消息中心",@"我的收藏",@"我的发帖",@"设置"];
    }
    return _titleArr;
}

- (NSArray *)imageNameArr
{
    if (!_imageNameArr) {
        _imageNameArr = @[@"tabbar_books@3x",@"tabbar_books@3x",@"tabbar_books@3x",@"tabbar_books@3x",@"tabbar_books@3x"];
    }
    return _imageNameArr;
}





#pragma mark-
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self viewLayout];
    
    
    
    
}
#pragma mark-
#pragma mark----view布局
- (void)viewLayout
{
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, kScreenHeight - 200 ) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_mainTableView];
   
}

#pragma mark-
#pragma mark-UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [UIImage imageNamed:self.imageNameArr[indexPath.row]];
    cell.textLabel.text = self.titleArr[indexPath.row];

    return cell;
}




#pragma mark-
#pragma mark-UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}





#pragma mark-按钮点击事件

- (IBAction)jumpToPersonalCenterBtnAction:(id)sender {
    WBPersonalCenterViewController *personalCenterVC = [[WBPersonalCenterViewController alloc] init];
    
    [self.parentViewController.navigationController pushViewController:personalCenterVC animated:YES];
    
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
