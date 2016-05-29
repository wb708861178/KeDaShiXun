//
//  WBForumViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/8.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBForumViewController.h"
#import "Const.h"
#import <MJRefresh.h>
#import "KTopicFrameModel.h"
#import "KTopicCell.h"
#import <MJExtension.h>
#import "KTopicDetailVC.h"
#import "KUISegmentedControl.h"
#import "UIBarButtonItem+WBCustomButton.h"
#import "KPublishVC.h"
#import "WBNetworking.h"
#import "WBUserInfo.h"

@interface WBForumViewController () <UITableViewDataSource,UITableViewDelegate,KUISegmentedControlDelegate>

@property (nonatomic, strong) KUISegmentedControl *topSegment;

@property (nonatomic, strong) UIScrollView *scrollView;
//帖子类型
@property (nonatomic, strong) NSArray *topicTypeArr;
@property (nonatomic, strong) UITableView *allTopicTV;
@property (nonatomic, strong) UITableView *goodTopicTV;
@property (nonatomic, strong) UITableView *joinedTopicTV;

//话题列表数组
@property (nonatomic, strong) NSMutableArray *topicsArr;

//数据数组
@property (nonatomic, strong) NSArray *dataArr;

//默认选中第0个 全部帖子
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) NSMutableArray *commentNumArr;
@end

@implementation WBForumViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavBarTitleWithText:@"科大论坛" withFontSize:18 withTextColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItems = [UIBarButtonItem barButtonItemWithImageName:@"fabu" withHighlightedImageName:nil withTarget:self withAction:@selector(publishTopic) WithNegativeSpacerWidth:-4];
    
    self.view.backgroundColor = kBGDefaultColor;
    
    self.currentIndex = 0;
    
    [self viewLayout];
    
    [self allTopicData];
}


//全部帖子
- (void)allTopicData{
    
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getForum params:nil successBlock:^(id returnData) {
        
        self.topicsArr = [NSMutableArray array];
        for (NSDictionary *dict in returnData[@"data"]) {
            KTopicFrameModel *topicFrame = [[KTopicFrameModel alloc] initWithDict:dict];
            [self.topicsArr addObject:topicFrame];
        }
        
        [self commentCountWithTV:self.allTopicTV];
        
    } failureBlock:^(NSError *error) {
        
    }];
    
}


//精品帖子
- (void)goodTopicData{
    
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getForum params:@{@"uid":[NSString stringWithFormat:@"%d",[WBUserInfo share].userid]} successBlock:^(id returnData) {
        
        self.topicsArr = [NSMutableArray array];
        for (NSDictionary *dict in returnData[@"data"]) {
            KTopicFrameModel *topicFrame = [[KTopicFrameModel alloc] initWithDict:dict];
            [self.topicsArr addObject:topicFrame];
        }
        
        NSMutableArray *array = [self.topicsArr mutableCopy];
        [array sortUsingComparator:^NSComparisonResult(KTopicFrameModel *obj1, KTopicFrameModel *obj2) {
            
            if ([obj1.topicModel.supportnum intValue] < [obj1.topicModel.supportnum intValue]) {
                
                return obj1;
            }else{
                return obj2;
            }
            
        }];
        self.topicsArr = array;
        [self commentCountWithTV:self.goodTopicTV];
        
    } failureBlock:^(NSError *error) {
        
    }];

}

- (void)jionedTopicData{
    
    WBUserInfo *userInfo = [WBUserInfo share];
        [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getForumPartIn params:@{@"userid":[NSString stringWithFormat:@"%d",userInfo.userid]} successBlock:^(id returnData) {
            self.topicsArr = [NSMutableArray array];
            for (NSDictionary *dict in returnData[@"data"]) {
                KTopicFrameModel *topicFrame = [[KTopicFrameModel alloc] initWithDict:dict];
                [self.topicsArr addObject:topicFrame];
            }

            [self commentCountWithTV:self.joinedTopicTV];

        
    } failureBlock:^(NSError *error) {
        
    }];
    
}


- (void)commentCountWithTV:(UITableView *)tv{
    
    self.commentNumArr = [NSMutableArray array];
    for (int i = 0; i< self.topicsArr.count; i++) {
        KTopicFrameModel *frameModel = self.topicsArr[i];
        [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getComment params:@{@"fid":frameModel.topicModel.topicId} successBlock:^(id returnData) {
            NSString *str;
            if ([returnData[@"data"] count] == 0) {
                
                str = @" 0";
            }
            
            str = [NSString stringWithFormat:@" %ld",[returnData[@"data"] count]];
            [self.commentNumArr addObject:str];
            [tv reloadData];
            
        } failureBlock:^(NSError *error) {
            
        }];

        
    }
}

#pragma mark --- KUISegmentedControlDelegate

- (void)uisegumentSelectionChange:(NSInteger)selection{
    if(selection==0){
        [_scrollView setContentOffset:CGPointMake(0, 0)];
        [self.allTopicTV.mj_header beginRefreshing];
        
    }else if (selection==1) {
        //更改当前数据 类型 并刷新数据
        [_scrollView setContentOffset:CGPointMake(kWidth, 0)];

        [self.goodTopicTV.mj_header beginRefreshing];
    }else if(selection == 2){
        [_scrollView setContentOffset:CGPointMake(kWidth*2, 0)];
        [self.joinedTopicTV.mj_header beginRefreshing];
    }
}

#pragma mark --- UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.commentNumArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"KTopicCell";
    KTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[KTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.topicFrameModel = self.topicsArr[indexPath.row];
    cell.commentCount = [NSString stringWithFormat:@"%@",self.commentNumArr[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KTopicDetailVC *topicDetailVC = [[KTopicDetailVC alloc] init];
    
    topicDetailVC.hidesBottomBarWhenPushed = YES;
    
    //------数据 传递
    topicDetailVC.topicHeaderFrameModel = [[KTopicHeaderFrameModel alloc] initWithTopicModel:[self.topicsArr[indexPath.row] topicModel]];
    
    // -------------
    [self.navigationController pushViewController:topicDetailVC animated:YES];
    

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KTopicFrameModel *topicFrameModel = self.topicsArr[indexPath.row];
    
    return topicFrameModel.cellHeight;

}

#pragma mark ---  发表主题
- (void)publishTopic{
    
    KPublishVC *vc = [[KPublishVC alloc] initWithNibName:@"KPublishVC" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewLayout{
    
    //选择器
    _topicTypeArr = @[@"全部帖子",@"精品帖子",@"我参与的"];
    _topSegment = [[KUISegmentedControl alloc] initWithFrame:CGRectMake(0, 64, kWidth, 44)];
    
    [_topSegment AddSegumentArray:_topicTypeArr];
    _topSegment.delegate = self;
    [self.view addSubview:_topSegment];
    
    //TableView
    CGFloat maxY = CGRectGetMaxY(_topSegment.frame);
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, maxY, kWidth, kHeight-maxY-49)];
    _scrollView.contentSize = CGSizeMake(kWidth*3, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    _scrollView.backgroundColor = [UIColor redColor];
    
    __weak typeof(self) mySelf = self;
    _allTopicTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight-maxY-49) style:UITableViewStylePlain];
    _allTopicTV.delegate = self;
    _allTopicTV.dataSource = self;
    _allTopicTV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_scrollView addSubview:_allTopicTV];
    //添加头部刷新
    _allTopicTV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [mySelf.allTopicTV.mj_header endRefreshing];
        [mySelf allTopicData];
        
    }];
    

    _goodTopicTV = [[UITableView alloc] initWithFrame:CGRectMake(kWidth, 0, kWidth, kHeight-maxY-49) style:UITableViewStylePlain];
    _goodTopicTV.delegate = self;
    _goodTopicTV.dataSource = self;
    _goodTopicTV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_scrollView addSubview:_goodTopicTV];
    //添加头部刷新
    _goodTopicTV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [mySelf.goodTopicTV.mj_header endRefreshing];
        [mySelf goodTopicData];
        
    }];
    

    _joinedTopicTV = [[UITableView alloc] initWithFrame:CGRectMake(2*kWidth, 0, kWidth, kHeight-maxY-49) style:UITableViewStylePlain];
    _joinedTopicTV.delegate = self;
    _joinedTopicTV.dataSource = self;
    _joinedTopicTV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_scrollView addSubview:_joinedTopicTV];
    //添加头部刷新
    _joinedTopicTV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [mySelf.joinedTopicTV.mj_header endRefreshing];
        [mySelf jionedTopicData];
        
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
