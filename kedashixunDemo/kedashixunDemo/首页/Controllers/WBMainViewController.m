//
//  WBMainViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/8.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBMainViewController.h"
#import "WBCustomNavView.h"
#import "Const.h"
#import "RESideMenu.h"
#import "WBMainCell1.h"
#import "WBMainCell2.h"
#import "WBMainCell3.h"
#import "WBMainDetailViewController.h"
#import "WBMainSearchViewController.h"

#import "WBKedaMessage.h"
#import <MJExtension.h>
#import "WBNetworking.h"


@interface WBMainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) WBCustomNavView *customNavView;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;


@end

@implementation WBMainViewController
- (NSMutableArray *)dataSourceArr
{
    if (!_dataSourceArr) {
        _dataSourceArr = [NSMutableArray array];
        
    }
    return _dataSourceArr;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarTitleWithText:@"科大时讯" withFontSize:18 withTextColor:[UIColor whiteColor]];
    
    
       [self viewLayout];
    
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getKedamessage params:nil successBlock:^(id returnData) {
        NSMutableArray *tempArrM = [WBKedaMessage mj_objectArrayWithKeyValuesArray:returnData[@"data"]];
        self.dataSourceArr = [[[tempArrM reverseObjectEnumerator] allObjects] mutableCopy];
        [self.mainTableView reloadData];
    } failureBlock:^(NSError *error) {
          NSLog(@"%@",error);
    }];
    

    
    
}

#pragma mark-
#pragma mark---UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBKedaMessage *kedaMessage = self.dataSourceArr[indexPath.row];
    
   
        switch (kedaMessage.type) {
        case 1:
        {
           
            WBMainCell1 *cell1 = [tableView dequeueReusableCellWithIdentifier:@"WBMainCell1" forIndexPath:indexPath];
            cell1.kedaMessage = self.dataSourceArr[indexPath.row];
            return cell1;
        }
            break;
        case 2:
        {
            WBMainCell2 *cell2 = [tableView dequeueReusableCellWithIdentifier:@"WBMainCell2" forIndexPath:indexPath];
            cell2.kedaMessage = self.dataSourceArr[indexPath.row];
            return cell2;
        }
            break;
        case 3:
        {
            WBMainCell3 *cell3 = [tableView dequeueReusableCellWithIdentifier:@"WBMainCell3" forIndexPath:indexPath];
            cell3.kedaMessage = self.dataSourceArr[indexPath.row];
            return cell3;
            
        }
            break;
            
        default:
                return nil;
            break;
    }
    
   
}
#pragma mark---UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0)
{
   
    return 1000;

}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2f];
    WBKedaMessage *kedaMessage = self.dataSourceArr[indexPath.row];
    
    WBMainDetailViewController *mainDetailVC = [[WBMainDetailViewController alloc] init];
    mainDetailVC.kedaMessage = kedaMessage;
    [self.navigationController pushViewController:mainDetailVC animated:YES];
}


#pragma mark-
#pragma mark--------view布局
-(void)viewLayout{
    
    
    
    UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kWidth, kHeight - 49) style:UITableViewStylePlain];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:mainTableView];
    self.mainTableView = mainTableView;
    
    WBCustomNavView *customNavView = [[NSBundle mainBundle] loadNibNamed:@"WBCustomNavView" owner:nil options:nil].firstObject;
    customNavView.frame = CGRectMake(0, 0, kWidth, 64);
    
    customNavView.jumpToMenuVCBlock = ^{
        [self.sideMenuViewController presentLeftMenuViewController];
    };
    customNavView.jumpToSearchVCBlock = ^{
        WBMainSearchViewController *mainSearchVC = [[WBMainSearchViewController alloc] init];
        [self.navigationController pushViewController:mainSearchVC animated:YES];
    };
    self.customNavView = customNavView;
    
    [self.view addSubview:customNavView];
    
    
    UIView *customHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 230)];
    
    UIImageView *bannerImageView = [[UIImageView alloc] initWithFrame:customHeaderView.bounds];
    bannerImageView.image = [UIImage imageNamed:@"shouye_banner_1"];
    [customHeaderView addSubview:bannerImageView];
    
    mainTableView.tableHeaderView = customHeaderView;

    
    [mainTableView registerNib:[UINib nibWithNibName:@"WBMainCell1" bundle:nil] forCellReuseIdentifier:@"WBMainCell1"];
    [mainTableView registerNib:[UINib nibWithNibName:@"WBMainCell2" bundle:nil] forCellReuseIdentifier:@"WBMainCell2"];
    [mainTableView registerNib:[UINib nibWithNibName:@"WBMainCell3" bundle:nil] forCellReuseIdentifier:@"WBMainCell3"];
    
    
    [self.view bringSubviewToFront:customNavView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//取消cell点中状态
- (void)deselect
{
    [self.mainTableView deselectRowAtIndexPath:[self.mainTableView indexPathForSelectedRow] animated:YES];
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
