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
#import "WBSchoolCalendarViewController.h"
#import "WBMessageCenterViewController.h"
#import "WBMyCollectionViewController.h"
#import "WBMyPublishViewController.h"
#import "WBSettingViewController.h"




@interface WBMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) WBLoginMenuHeaderView *loginMenuHeaderView;
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
    [self.loginMenuHeaderView updateData];
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
    __weak typeof (self) mySelf = self;
    loginMenuHeaderView.jumpToPersonalCenterVCBlock = ^{
        WBPersonalCenterViewController *personalCenterVC = [[WBPersonalCenterViewController alloc] init];

        [mySelf jumpToNextVC:personalCenterVC];

        [mySelf.sideMenuViewController hideMenuViewController];
        

    };
    self.loginMenuHeaderView = loginMenuHeaderView;
    
    
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
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
//    cell.selectedBackgroundView.backgroundColor = kMainColor;
    
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}




#pragma mark-
#pragma mark-UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2f];

    switch (indexPath.row) {
        case 0:
        {
            WBSchoolCalendarViewController *schoolCalendarVC = [[WBSchoolCalendarViewController alloc] init];
            [self jumpToNextVC:schoolCalendarVC];
           
        }
            break;
        case 1:
        {
            WBMessageCenterViewController *messageCenterVC = [[WBMessageCenterViewController alloc] init];
            [self jumpToNextVC:messageCenterVC];
            
        }
            break;
        case 2:
        {
            WBMyCollectionViewController *myCollectionVC = [[WBMyCollectionViewController alloc] init];
            [self jumpToNextVC:myCollectionVC];
        }
            break;
        case 3:
        {
            WBMyPublishViewController *myPublishVC = [[WBMyPublishViewController alloc] init];
           [self jumpToNextVC:myPublishVC];

        }
            break;
        case 4:
        {
            WBSettingViewController *settingVC = [[WBSettingViewController alloc] init];
               [self jumpToNextVC:settingVC];
        }
            break;
            
        default:
            break;
    }
}


//取消cell点中状态
- (void)deselect
{
    [self.mainTableView deselectRowAtIndexPath:[self.mainTableView indexPathForSelectedRow] animated:YES];
}
#pragma mark-按钮点击事件


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)jumpToNextVC:(UIViewController *)viewController
{
    [self.sideMenuViewController hideMenuViewController];
    WBTabBarViewController *tabBarVC = (WBTabBarViewController *)self.sideMenuViewController.contentViewController;
    [tabBarVC.selectedViewController pushViewController:viewController animated:NO];
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
