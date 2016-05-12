//
//  WBForumViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/8.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBForumViewController.h"
#import "WBCustonSegment.h"
#import "Const.h"
#import <MJRefresh.h>
#import "KTopicFrameModel.h"
#import "KTopicCell.h"
#import <MJExtension.h>
#import "KTopicDetailVC.h"

@interface WBForumViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) WBCustonSegment *topSegment;
//帖子类型
@property (nonatomic, strong) NSArray *topicTypeArr;
@property (nonatomic, strong) UITableView *topicTV;
//话题列表数组
@property (nonatomic, strong) NSMutableArray *topicsArr;

//数据数组
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation WBForumViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavBarTitleWithText:@"科大论坛" withFontSize:18 withTextColor:[UIColor whiteColor]];
    
    self.view.backgroundColor = kBGDefaultColor;
    
    [self viewLayout];
    

    
//-------------------------Test
    _dataArr = @[@{@"iconName":@"",@"name":@"寇忠龙",@"time":@"2016-05-10",@"location":@"河南科技大学开元校区",@"content":@"P2P模式文件的群殴就到期我觉得去我家都快来群文件打开链接请我看了大家去看了文件的情况了解的考虑去叫我来的",@"viewCount":@"100",@"imagesUrlArr":@[@"http://easyread.ph.126.net/m01ZnaivFu8yR-lVjO62vg==/7917012585080905357.jpg",@"http://easyread.ph.126.net/m01ZnaivFu8yR-lVjO62vg==/7917012585080905357.jpg",@"http://easyread.ph.126.net/m01ZnaivFu8yR-lVjO62vg==/7917012585080905357.jpg",@"http://easyread.ph.126.net/m01ZnaivFu8yR-lVjO62vg==/7917012585080905357.jpg",@"http://easyread.ph.126.net/m01ZnaivFu8yR-lVjO62vg==/7917012585080905357.jpg",@"http://easyread.ph.126.net/m01ZnaivFu8yR-lVjO62vg==/7917012585080905357.jpg"]}];
    
    KTopicFrameModel *topicFrameModel = [[KTopicFrameModel alloc] initWithDict:_dataArr.firstObject];
    
    [self.topicsArr addObject:topicFrameModel];
}


- (void)viewLayout{
    
    _topicTypeArr = @[@"全部帖子",@"精品帖子",@"我参与的"];
    
    _topSegment = [[WBCustonSegment alloc] initWithFrame:CGRectMake(0, 64, kWidth, 44) WithItems:_topicTypeArr WithColor:[UIColor blackColor] WithSelectColor:[UIColor redColor]];
    
    // 切换数据
    _topSegment.touchItemBlock = ^(NSInteger selectedIndex){
        
        
        NSLog(@"%zi",selectedIndex);
    };
    [self.view addSubview:_topSegment];

    
    CGFloat maxY = CGRectGetMaxY(_topSegment.frame);
    __weak typeof(self) mySelf = self;
    _topicTV = [[UITableView alloc] initWithFrame:CGRectMake(0, maxY, kWidth, kHeight-maxY-49) style:UITableViewStylePlain];
    _topicTV.delegate = self;
    _topicTV.dataSource = self;
    _topicTV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_topicTV];
    //添加头部刷新
    _topicTV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        [mySelf.topicTV.mj_header endRefreshing];
        
    }];
    
    _topicTV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       
        [mySelf.topicTV.mj_footer endRefreshing];
        
    }];
    
}

#pragma mark --- UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"KTopicCell";
    KTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[KTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.topicFrameModel = self.topicsArr.firstObject;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KTopicDetailVC *topicDetailVC = [[KTopicDetailVC alloc] init];
    
    topicDetailVC.hidesBottomBarWhenPushed = YES;
    
    //------数据 传递
    topicDetailVC.topicHeaderFrameModel = [[KTopicHeaderFrameModel alloc] initWithDict:_dataArr.firstObject];
    
    // -------------
    [self.navigationController pushViewController:topicDetailVC animated:YES];
    

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KTopicFrameModel *topicFrameModel = self.topicsArr[0];
    
    return topicFrameModel.cellHeight;

}



- (NSMutableArray *)topicsArr{
    
    if (!_topicsArr) {
        
        _topicsArr = [NSMutableArray array];
    }
    return _topicsArr;
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
