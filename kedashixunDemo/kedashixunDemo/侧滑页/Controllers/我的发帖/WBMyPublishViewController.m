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
#import "WBUserInfo.h"
#import "WBNetworking.h"
#import "KTopicDetailVC.h"


@interface WBMyPublishViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *topicsArr;

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
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 74, kWidth, kHeight - 64 - 10) style:UITableViewStylePlain];
    
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.backgroundColor = kBGDefaultColor;
    [self.view addSubview:_mainTableView];

    [_mainTableView registerClass:[KTopicCell class] forCellReuseIdentifier:@"KTopicCell"];

    [self joinedData];
}


- (void)joinedData{
    
    WBUserInfo *userInfo = [WBUserInfo share];
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getForumPartIn params:@{@"userid":[NSString stringWithFormat:@"%d",userInfo.userid]} successBlock:^(id returnData) {
        self.topicsArr = [NSMutableArray array];
        for (NSDictionary *dict in returnData[@"data"]) {
            KTopicFrameModel *topicFrame = [[KTopicFrameModel alloc] initWithDict:dict];
            [self.topicsArr addObject:topicFrame];
        }
        
        [self.mainTableView reloadData];
        
        
    } failureBlock:^(NSError *error) {
        
    }];

}

#pragma mark----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.topicsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KTopicCell *topicCell = [tableView dequeueReusableCellWithIdentifier:@"KTopicCell" forIndexPath:indexPath];
    topicCell.topicFrameModel = self.topicsArr[indexPath.row];
    return topicCell;
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KTopicFrameModel *topicFrame = self.topicsArr[indexPath.row];
    return topicFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KTopicDetailVC *topicDetail = [[KTopicDetailVC alloc] init];
    topicDetail.topicHeaderFrameModel = [[KTopicHeaderFrameModel alloc] initWithTopicModel:[self.topicsArr[indexPath.row] topicModel]];
    
    [self.navigationController pushViewController:topicDetail animated:YES];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
