//
//  WBPhoneBookViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/8.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBPhoneBookViewController.h"
#import "Const.h"
#import "WBPhoneListCell.h"
#import "WBPhoneListHeaderView.h"
#import "WBPhoneList.h"
#import "WBNetworking.h"
#import <MJExtension.h>

@interface WBPhoneBookViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;


@end

@implementation WBPhoneBookViewController

- (NSMutableArray *)dataSourceArr
{
    if (!_dataSourceArr) {
        _dataSourceArr = [NSMutableArray array];
    }
    return _dataSourceArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
      [self setNavBarTitleWithText:@"电话簿" withFontSize:18 withTextColor:[UIColor whiteColor]];
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getPhonelist params:nil successBlock:^(id returnData) {
       NSLog(@"%@",returnData);
        self.dataSourceArr = [WBPhoneList mj_objectArrayWithKeyValuesArray:returnData[@"data"]];
        NSLog(@"%@",self.dataSourceArr);
        [self.mainTableView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    [self viewLayout];
    
}

#pragma mark-
#pragma mark---UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSourceArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBPhoneListCell *phoneListCell = [self.mainTableView dequeueReusableCellWithIdentifier:@"WBPhoneListCell" forIndexPath:indexPath];
    phoneListCell.phoneList = self.dataSourceArr[indexPath.section];
    
    
    return phoneListCell;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   WBPhoneListHeaderView *headerView = [self.mainTableView dequeueReusableHeaderFooterViewWithIdentifier:@"WBPhoneListHeaderView"];
    headerView.phoneList = self.dataSourceArr[section];
    return headerView;
    
    
}


#pragma mark---UITableViewDelegate
#pragma mark-
- (void)viewLayout
{
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64,kWidth ,kHeight - 64 ) style:UITableViewStyleGrouped];
    
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"WBPhoneListCell" bundle:nil] forCellReuseIdentifier:@"WBPhoneListCell"];
    
    
    [self.mainTableView registerClass:[WBPhoneListHeaderView class] forHeaderFooterViewReuseIdentifier:@"WBPhoneListHeaderView"];
   
    
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
