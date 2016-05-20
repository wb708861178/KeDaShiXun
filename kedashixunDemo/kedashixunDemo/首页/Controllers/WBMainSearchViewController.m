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

#define cellHeight 40
@interface WBMainSearchViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@end

@implementation WBMainSearchViewController
- (NSMutableArray *)dataSourceArr
{
    if (!_dataSourceArr) {
        _dataSourceArr = [NSMutableArray arrayWithArray:@[@"我的",@"sds",@"dssds"]] ;
    }
    return _dataSourceArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    [self setNaVBar];
    [self viewLayout];
    
    
    
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
    
    
    self.navigationItem.titleView = searchBar;
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
        cell.imageView.image = [UIImage imageNamed:@"shouye_lishijilu"];
        cell.textLabel.text = self.dataSourceArr[indexPath.row];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight - 1, self.mainTableView.frame.size.width, 1)];
        cell.layer.cornerRadius = 5;
        
        lineView.backgroundColor = kBGDefaultColor;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.contentView addSubview:lineView];
    }
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
}

#pragma mark---按钮单击事件
- (void)cancleBtnAction
{
    [self pop];
}

- (void)trashBinImageViewTap
{
    NSLog(@"垃圾箱");
    [self.dataSourceArr removeAllObjects];
    [self.mainTableView reloadData];
    self.mainTableView.frameH = 0;
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
