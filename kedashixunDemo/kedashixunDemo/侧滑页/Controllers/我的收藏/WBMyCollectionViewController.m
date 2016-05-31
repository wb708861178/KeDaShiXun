//
//  WBMyCollectionViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/16.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBMyCollectionViewController.h"
#import "WBCustonSegment.h"
#import "Const.h"
#import "WBMainCell1.h"
#import "WBMainCell2.h"
#import "WBMainCell3.h"
#import "KTopicCell.h"
#import "WBNetworking.h"
#import <MJExtension.h>
#import "WBKedaMessage.h"
#import "WBUserInfo.h"
#import "WBMainDetailViewController.h"

@interface WBMyCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@end

@implementation WBMyCollectionViewController
- (NSMutableArray *)dataSourceArr
{
    if (!_dataSourceArr) {
        _dataSourceArr = [NSMutableArray array];
    }
    return _dataSourceArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self setNavBarTitleWithText:@"我的收藏" withFontSize:20.f withTextColor:[UIColor whiteColor]];
    self.hasReturnArrow = YES;
    
    [self viewLayout];
    [self requestWithKedaMessage];
    
}
- (void)viewLayout
{
    WBCustonSegment *custonsegment = [[WBCustonSegment alloc] initWithFrame:CGRectMake(0, 64,kWidth , 60) WithItems:@[@"学校通知",@"科大论坛"] withBgColor:[UIColor whiteColor] WithColor:kTextDefaultColor WithSelectColor:kTextDefaultColor withUnderLayerColor:[UIColor orangeColor] withUnderLayerHeight:4];
    custonsegment.touchItemBlock = ^(BOOL isLeft,NSInteger selectedIndex){
        
       
        if (selectedIndex == 0) {
           
            [self requestWithKedaMessage];
        }else{
            //论坛
            [self forumMessage];
        }
        self.selectedIndex = selectedIndex;
    };
    [self.view addSubview:custonsegment];
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(custonsegment.frame) + 5, kWidth, kHeight - 64 - custonsegment.frame.size.height) style:UITableViewStylePlain];
    
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableView.backgroundColor = kBGDefaultColor;
    [self.view addSubview:_mainTableView];
   

    
    [_mainTableView registerNib:[UINib nibWithNibName:@"WBMainCell1" bundle:nil] forCellReuseIdentifier:@"WBMainCell1"];
    [_mainTableView registerNib:[UINib nibWithNibName:@"WBMainCell2" bundle:nil] forCellReuseIdentifier:@"WBMainCell2"];
    [_mainTableView registerNib:[UINib nibWithNibName:@"WBMainCell3" bundle:nil] forCellReuseIdentifier:@"WBMainCell3"];
    
    
    [_mainTableView registerClass:[KTopicCell class] forCellReuseIdentifier:@"KTopicCell"];
}


- (void)forumMessage{
    
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getFcollection params:@{@"uid":[NSString stringWithFormat:@"%d",[WBUserInfo share].userid]} successBlock:^(id returnData) {
        self.dataSourceArr = [NSMutableArray array];
//        for (NSDictionary *dict in returnData[@"data"]) {
//            KTopicFrameModel *topicFrame = [[KTopicFrameModel alloc] initWithDict:dict];
//            [self.dataSourceArr addObject:topicFrame];
//        }
        [self.mainTableView reloadData];
        
    } failureBlock:^(NSError *error) {
        
    }];
    
}

#pragma mark----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedIndex == 0) {
        WBKedaMessage *kedamessage = self.dataSourceArr[indexPath.row];
        switch (kedamessage.type) {
            case 1:
            {
                 WBMainCell1 *cell1 = [tableView dequeueReusableCellWithIdentifier:@"WBMainCell1" forIndexPath:indexPath];
                 cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                cell1.kedaMessage = kedamessage;
                return cell1;
            }
                break;
            case 2:
            {
                WBMainCell2 *cell2 = [tableView dequeueReusableCellWithIdentifier:@"WBMainCell2" forIndexPath:indexPath];
                cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell2.kedaMessage = kedamessage;
                return cell2;

            }
                break;
            case 3:
            {
                WBMainCell3 *cell3 = [tableView dequeueReusableCellWithIdentifier:@"WBMainCell3" forIndexPath:indexPath];
                cell3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell3.kedaMessage = kedamessage;
                return cell3;
            }
                break;
            default:
                break;
        }
     
    }else if(self.selectedIndex == 1){
        KTopicCell *topicCell = [tableView dequeueReusableCellWithIdentifier:@"KTopicCell" forIndexPath:indexPath];
        topicCell.topicFrameModel = self.dataSourceArr[indexPath.row];
        return topicCell;
    }
        
    return nil;
}

#pragma mark----UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0)
{
    return 1000;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    WBKedaMessage *kedaMessage = self.dataSourceArr[indexPath.row];
    WBMainDetailViewController *mainDetailVC = [[WBMainDetailViewController alloc] init];
    mainDetailVC.kedaMessage = kedaMessage;
    
    [self.navigationController pushViewController:mainDetailVC animated:YES];
   
}



#pragma mark----科大通知收藏请求

- (void)requestWithKedaMessage
{
     NSDictionary *params = @{@"uid":[NSString stringWithFormat:@"%d",[WBUserInfo share].userid]};
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getKedamessageCollection params:params successBlock:^(id returnData) {
        self.dataSourceArr = [WBKedaMessage mj_objectArrayWithKeyValuesArray:returnData[@"data"]];
        [self.mainTableView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];

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
