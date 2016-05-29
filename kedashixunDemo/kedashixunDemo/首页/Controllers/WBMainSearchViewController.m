//
//  WBMainSearchViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/17.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBMainSearchViewController.h"
#import "UIBarButtonItem+WBCustomButton.h"
#import "WBCustomSearchBar.h"
#import "Const.h"
#import "UIView+WBLocation.h"
#import "WBNetworking.h"
#import <MJExtension.h>
#import "WBUserInfo.h"
#import "WBHistory.h"
#import "WBRelatedSearchTableView.h"
#import "WBKedaMessage.h"
#import "WBMainDetailViewController.h"
#import "WBSearchResultViewController.h"

#define cellHeight 40
@interface WBMainSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, strong) WBCustomSearchBar *searchBar;
@property (nonatomic, strong) WBRelatedSearchTableView *relatedSearchTableView;

@end

@implementation WBMainSearchViewController

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
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchBarTextChange:) name:UITextFieldTextDidChangeNotification object:nil];
    self.searchBar.text = nil;
    if (self.relatedSearchTableView) {
        [self.relatedSearchTableView removeFromSuperview];
    }
    [self.searchBar becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    [self setNaVBar];
    [self viewLayout];
    
    [self requestDataWithHistory];
    
    
}
#pragma mark---navbar布局

- (void)setNaVBar
{
    self.navigationItem.rightBarButtonItems = [UIBarButtonItem barButtonItemWithTitle:@"取消" WithTitleColor:[UIColor whiteColor] WithTitleHighlightColor:[UIColor whiteColor] withTarget:self withAction:@selector(cancleBtnAction) WithNegativeSpacerWidth:-4] ;
    self.navigationItem.hidesBackButton = YES;
    //自定义searchBar,title 会根据左右的item 来自动调整自己的位置
    
        CGFloat searchBarW = (kWidth - 50 - 16) * 4.5 / 5.0;
    WBCustomSearchBar *searchBar = [[WBCustomSearchBar alloc] initWithFrame:CGRectMake(0, 0, searchBarW , 30) withSearchImageName:@"navbar_search_green"];
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.layer.cornerRadius = 15;
    
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    
    self.searchBar = searchBar;
   
   
}


#pragma mark--view布局
- (void)viewLayout
{
    self.view.backgroundColor = kBGDefaultColor;
    //设置 搜索历史lable  和 垃圾箱
    CGFloat topViewH = 50;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kWidth,topViewH )];
//    topView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:topView];
    
    UILabel *historyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,0, 100, topViewH)];
    historyLabel.text = @"搜索历史";
    historyLabel.font = [UIFont systemFontOfSize:14];
    historyLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    [topView addSubview:historyLabel];
    
    CGFloat trashBinImageViewX = kWidth - 20 - 15;
    CGFloat trashBinImageViewY = (topViewH - 15) * 0.5;
    UIImageView *trashBinImageView = [[UIImageView alloc] initWithFrame:CGRectMake(trashBinImageViewX, trashBinImageViewY, 15, 15)];
    trashBinImageView.image = [UIImage imageNamed:@"shouye_lajixiag"];
    [topView addSubview:trashBinImageView];
    //给垃圾箱加手势
    trashBinImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *trashBinImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(trashBinImageViewTap)];
    [trashBinImageView addGestureRecognizer:trashBinImageViewTap];
    
    
    
    
    
    CGFloat mainTableViewX = 10;
    CGFloat mainTableViewW = kWidth - mainTableViewX * 2;
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(mainTableViewX, CGRectGetMaxY(topView.frame), mainTableViewW, self.dataSourceArr.count * cellHeight ) style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor whiteColor];
    _mainTableView.layer.cornerRadius = 5;
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTableView];
                                                               
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
}

#pragma mark--请求搜索历史数据
- (void)requestDataWithHistory
{
    NSString *uidStr = [NSString stringWithFormat:@"%d",[WBUserInfo share].userid];
    NSDictionary *params = @{@"uid":uidStr};
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getHistory params:params successBlock:^(id returnData) {
        
        NSMutableArray *tempArrM = [WBHistory mj_objectArrayWithKeyValuesArray:returnData[@"data"]];
        //<__NSArrayM: 0x7fd20e22a870> was mutated while being enumerated.' ： 遍历的时候修改数组会出错
        NSArray *forinArr = [NSArray arrayWithArray:tempArrM];
        for (WBHistory *tempHistory in forinArr) {
            if ([tempHistory.status intValue] == 0) {
                [tempArrM removeObject:tempHistory];
            }
        }
        self.dataSourceArr = [tempArrM mutableCopy];
        
        
        _mainTableView.frame =  CGRectMake(_mainTableView.frameX   , _mainTableView.frameY, _mainTableView.frameW, self.dataSourceArr.count * cellHeight  ) ;
        
        [self.mainTableView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    

}

#pragma mark---UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataSourceArr.count;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
       
    }
    cell.imageView.image = [UIImage imageNamed:@"shouye_lishijilu"];
    WBHistory *history = self.dataSourceArr[indexPath.row];
    cell.textLabel.text = history.content;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight - 1, self.mainTableView.frame.size.width, 1)];
    cell.layer.cornerRadius = 5;
    
    lineView.backgroundColor = kBGDefaultColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.contentView addSubview:lineView];
    return cell;
}

#pragma mark---UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2f];
     [self.searchBar resignFirstResponder];
    WBHistory *history = self.dataSourceArr[indexPath.row];
    
    
           WBSearchResultViewController *searchResultVC = [[WBSearchResultViewController alloc ]init];
       searchResultVC.searchText = history.content;
    
        [self.navigationController pushViewController:searchResultVC animated:YES];
        
    self.searchBar.text = nil;
        

    
    
    
}

#pragma mark---按钮单击事件
- (void)cancleBtnAction
{
    [self.searchBar resignFirstResponder];
    [self pop];
}

- (void)trashBinImageViewTap
{
   
    NSString *uidStr = [NSString stringWithFormat:@"%d",[WBUserInfo share].userid];
    NSDictionary *params = @{@"uid":uidStr};
    
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getHistoryDelete params:params successBlock:^(id returnData) {
        NSLog(@"---------------%@",returnData);
        [self.dataSourceArr removeAllObjects];
        [self.mainTableView reloadData];
        self.mainTableView.frameH = 0;
    } failureBlock:^(NSError *error) {
        NSLog(@"------%@",error);
    }];
   
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark---取消cell点中状态
//取消cell点中状态
- (void)deselect
{
    [self.mainTableView deselectRowAtIndexPath:[self.mainTableView indexPathForSelectedRow] animated:YES];
}




#pragma mark---实现通知方法 ，显示出搜寻结果tableView

- (void)searchBarTextChange:(NSNotification *)notification
{
    WBCustomSearchBar *searchBar = notification.object;
   NSString *newStr = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([newStr isEqualToString:@""]) {
        if (self.relatedSearchTableView) {
            [self.relatedSearchTableView removeFromSuperview];
            self.relatedSearchTableView = nil;
            return;
        }
        
    }
    
    if (![newStr isEqualToString:@""]) {
        
        NSString *likeStr = [NSString stringWithFormat:@"%%%@%%",newStr];
        
        NSDictionary *params = @{@"searchtext":likeStr};
        [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getSearch params:params successBlock:^(id returnData) {
            if (!self.relatedSearchTableView) {
                WBRelatedSearchTableView *relatedSearchTableView = [[WBRelatedSearchTableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64) style:UITableViewStylePlain];
                 self.relatedSearchTableView = relatedSearchTableView;
                __weak typeof(self) mySelf = self;
                relatedSearchTableView.hiddenKeyBoardBlock = ^{
                    [self.searchBar resignFirstResponder];
                };
                relatedSearchTableView.jumpToVCBlock = ^(WBKedaMessage *kedaMessage){
                    WBMainDetailViewController *mainDetailVC = [[WBMainDetailViewController alloc] init];
                    mainDetailVC.kedaMessage = kedaMessage;
                    [mySelf.navigationController pushViewController:mainDetailVC animated:YES];
                };
                [self.view addSubview:relatedSearchTableView];
            }
            
           
                self.relatedSearchTableView.dataSourceArr = [WBKedaMessage mj_objectArrayWithKeyValuesArray:returnData[@"data"]];
                    [self.relatedSearchTableView reloadData];

            
            
            
           
            
           
        } failureBlock:^(NSError *error) {
            NSLog(@"%@",error);
        }];
 
    }
    
    
   
}
#pragma mark---dealloc
- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}



#pragma mark---UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    
    [self.searchBar resignFirstResponder];
    
    
    
    
    
     NSString *newStr = [self.searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    
    if (![newStr isEqualToString:@""]) {
        //调到搜索结果
        WBSearchResultViewController *searchResultVC = [[WBSearchResultViewController alloc ]init];
        searchResultVC.searchText = textField.text;
        
        [self.navigationController pushViewController:searchResultVC animated:YES];
        
        //判断是否能加入历史记录（历史记录有没有,有就不插入了）
        NSDictionary *isAddParams = @{@"content":textField.text};
        
        [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getIsaddhistory params:isAddParams successBlock:^(id returnData) {
//            NSLog(@"=======%@",returnData);
            if ([returnData[@"status"] intValue] == 400) {
                //上传数据
                NSDictionary *params  = @{@"uid":[NSString stringWithFormat:@"%d",[WBUserInfo share].userid],@"content":textField.text,@"status":@"1"};
                [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getAddhistory params:params successBlock:^(id returnData) {
//                    NSLog(@"%@",returnData);
                    if ([returnData[@"status"] intValue] == 200) {
                        WBHistory *history = [WBHistory mj_objectWithKeyValues:returnData[@"data"]];
                        if (history) {
                            [self.dataSourceArr insertObject:history atIndex:0];
                        }
                        
                        if (self.dataSourceArr.count > 15) {
                            [self.dataSourceArr removeLastObject];
                        }
                        _mainTableView.frame =  CGRectMake(_mainTableView.frameX   , _mainTableView.frameY, _mainTableView.frameW, self.dataSourceArr.count * cellHeight  ) ;
                        [self.mainTableView reloadData];
                        
                    }
                    
                } failureBlock:^(NSError *error) {
                    NSLog(@"%@",error);
                }];
 
                
                
                
                
                
                
            }
        } failureBlock:^(NSError *error) {
            
        }];
        
        
        
        
    }
    
    
    return YES;
}



#pragma mark----键盘显示处理
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.searchBar resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
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
