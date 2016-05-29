//
//  WBSearchResultViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/26.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBSearchResultViewController.h"
#import "UIBarButtonItem+WBCustomButton.h"
#import "Const.h"
#import "WBMainCell1.h"
#import "WBMainCell2.h"
#import "WBMainCell3.h"
#import "WBKedaMessage.h"
#import "WBNetworking.h"
#import <MJExtension.h>
#import "WBMainDetailViewController.h"


@interface WBSearchResultViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@end

@implementation WBSearchResultViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    [self setNaVBar];
    [self viewLayout];
    
    [self requestData];
    NSLog(@"%@",self.searchText);
    
   
}
#pragma mark---navbar布局

- (void)setNaVBar
{
    self.hasReturnArrow = YES;
    [self setNavBarTitleWithText:@"搜索结果" withFontSize:20 withTextColor:[UIColor whiteColor]];
    
 
}


#pragma mark--view布局
- (void)viewLayout
{
    
    
  
 
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidth    , kHeight - 64 ) style:UITableViewStylePlain];
    _mainTableView.backgroundColor = [UIColor whiteColor];
   
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTableView];
    
    [_mainTableView registerNib:[UINib nibWithNibName:@"WBMainCell1" bundle:nil] forCellReuseIdentifier:@"WBMainCell1"];
    [_mainTableView registerNib:[UINib nibWithNibName:@"WBMainCell2" bundle:nil] forCellReuseIdentifier:@"WBMainCell2"];
    [_mainTableView registerNib:[UINib nibWithNibName:@"WBMainCell3" bundle:nil] forCellReuseIdentifier:@"WBMainCell3"];
    
    
}

#pragma mark--请求数据

- (void)requestData
{
     NSString *newStr = [self.searchText stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (![newStr isEqualToString:@""]) {
        NSString *likeStr = [NSString stringWithFormat:@"%%%@%%",newStr];
        NSLog(@"%@",likeStr);
        
        NSDictionary *params = @{@"searchtext":likeStr};
        [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getSearch params:params successBlock:^(id returnData) {
            
            self.dataSourceArr = [WBKedaMessage mj_objectArrayWithKeyValuesArray:returnData[@"data"]];
            
            [self.mainTableView reloadData];
        } failureBlock:^(NSError *error) {
            NSLog(@"%@",error);
        }];

    }
   }


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
    
    WBMainDetailViewController *mainDetailVC = [[WBMainDetailViewController alloc] init];
    mainDetailVC.kedaMessage = self.dataSourceArr[indexPath.row];
    [self.navigationController pushViewController:mainDetailVC animated:YES];
    
    
}
#pragma mark---取消cell点中状态
//取消cell点中状态
- (void)deselect
{
    [self.mainTableView deselectRowAtIndexPath:[self.mainTableView indexPathForSelectedRow] animated:YES];
}
#pragma mark---按钮单击事件











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
