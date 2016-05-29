//
//  WBSettingViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/16.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBSettingViewController.h"
#import "Const.h"
#import "WBChangePasswordViewController.h"

#define cellHeight 50
#define groupSpace 5
@interface WBSettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) UILabel *cacheLabel;

@end

@implementation WBSettingViewController

- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = @[@[@"修改密码",@"通知设置"],@[@"意见反馈",@"清理缓存"],@[@"检查新版本",@"关于我们"]];
    }
    return _titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setNavBar];
    [self viewLayout];
    // Do any additional setup after loading the view.
}
- (void)setNavBar{
    [self setNavBarTitleWithText:@"设置" withFontSize:20.f withTextColor:[UIColor whiteColor]];
    self.hasReturnArrow = YES;
}
- (void)viewLayout
{
    self.view.backgroundColor = kBGDefaultColor;
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64  , kWidth  , cellHeight * 6 + 3 * groupSpace ) style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor whiteColor];
    _mainTableView.layer.cornerRadius = 5;
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.rowHeight = cellHeight;
    _mainTableView.scrollEnabled = NO;
    [self.view addSubview:_mainTableView];
    
    
    CGFloat logoutBtnW = kWidth * 4 /5;
    CGFloat logoutBtnH = logoutBtnW * 0.15;
    CGFloat logoutBtnX =( kWidth - logoutBtnW ) * 0.5;
    CGFloat logoutBtnY = CGRectGetMaxY(self.mainTableView.frame)+ 60;
    UIButton *logoutBtn = [[UIButton alloc] initWithFrame:CGRectMake(logoutBtnX, logoutBtnY, logoutBtnW, logoutBtnH)];
    logoutBtn.backgroundColor = [UIColor colorWithHexString:@"#ed8a57"];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    logoutBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [logoutBtn addTarget:self action:@selector(logoutBtn) forControlEvents:UIControlEventTouchUpInside];
    logoutBtn.layer.cornerRadius = logoutBtnH * 0.1;
    [self.view addSubview:logoutBtn];
    

}


#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.titleArr[section] count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.titleArr[indexPath.section][indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    if (indexPath.section == 1 && indexPath.row == 1) {
        _cacheLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, cellHeight)];
        _cacheLabel.text = @"10 M";
        _cacheLabel.textAlignment = NSTextAlignmentRight;
        _cacheLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.accessoryView = _cacheLabel;
    }
    
    return cell;
    
    
}

#pragma mark--UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return groupSpace;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row ) {
            case 0:
            {
                WBChangePasswordViewController *changePwd = [[WBChangePasswordViewController alloc] init];
                [self.navigationController pushViewController:changePwd animated:YES];
            }
                break;
            case 1:
            {
                
            }
                break;
            default:
                break;
        }
        
    }else if (indexPath.section == 1){
        switch (indexPath.row ) {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                
            }
                break;
            default:
                break;
        }

        
    }else if (indexPath.section == 2){
        switch (indexPath.row ) {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                
            }
                break;
            default:
                break;
        }

        
    }
}




#pragma mark---按钮单击事件
- (void)logoutBtn
{
    [self.navigationController.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:NO];
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
