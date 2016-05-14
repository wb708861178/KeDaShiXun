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
#import "RESideMenu.h"
#import "WBTabBarViewController.h"
#import "WBMenuHeaderView.h"
#import "WBLoginMenuHeaderView.h"




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
        _imageNameArr = @[@"menu_xiaoli",@"menu_xiaoxi",@"menu_shoucang",@"menu_fatie",@"menu_shezhi"];
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
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"menu_bg"];
    [self.view addSubview:bgImageView];
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 200, kWidth-10, kHeight - 200 ) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.backgroundColor = [UIColor clearColor];
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTableView];
    
//    //没登录
//    WBMenuHeaderView *menuHeaderView =   [[NSBundle mainBundle] loadNibNamed:@"WBMenuHeaderView" owner:nil options:nil].firstObject;
//    menuHeaderView.jumpToLoginVCBlock = ^{
//        NSLog(@"jumpToLoginVC");
//        
//    };
//    menuHeaderView.frame = CGRectMake(0, 0, kWidth,150 );
//        [self.view addSubview:menuHeaderView];
    
    
    
    
    //登录了
    WBLoginMenuHeaderView *loginMenuHeaderView =   [[NSBundle mainBundle] loadNibNamed:@"WBLoginMenuHeaderView" owner:nil options:nil].firstObject;
    loginMenuHeaderView.frame = CGRectMake(0, 0, kWidth,150 );
    [self.view addSubview:loginMenuHeaderView];
    loginMenuHeaderView.jumpToPersonalCenterVCBlock = ^{
        WBPersonalCenterViewController *personalCenterVC = [[WBPersonalCenterViewController alloc] init];
        [self.sideMenuViewController hideMenuViewController];
        WBTabBarViewController *tabBarVC = (WBTabBarViewController *)self.sideMenuViewController.contentViewController;
        [tabBarVC.selectedViewController pushViewController:personalCenterVC animated:NO];
    };
    
    
    //下划线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 149, kWidth, 0.5)];
    lineView.backgroundColor = kBGDefaultColor;
    [self.view addSubview:lineView];
    
    
    
    
    
    
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
    cell.textLabel.textColor = [UIColor whiteColor];

    return cell;
}




#pragma mark-
#pragma mark-UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}





#pragma mark-按钮点击事件


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
