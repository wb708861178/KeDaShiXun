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
#import "WBMainCell2.h"
#import "KTopicCell.h"

@interface WBMyCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation WBMyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setNavBarTitleWithText:@"我的收藏" withFontSize:20.f withTextColor:[UIColor whiteColor]];
    self.hasReturnArrow = YES;
    
    [self viewLayout];
    
}
- (void)viewLayout
{
    WBCustonSegment *custonsegment = [[WBCustonSegment alloc] initWithFrame:CGRectMake(0, 64,kWidth , 60) WithItems:@[@"学校通知",@"科大论坛"] withBgColor:[UIColor whiteColor] WithColor:kTextDefaultColor WithSelectColor:kTextDefaultColor withUnderLayerColor:[UIColor orangeColor] withUnderLayerHeight:4];
    custonsegment.touchItemBlock = ^(BOOL isLeft,NSInteger selectedIndex){
        NSLog(@"isLeft=%zi,%zi",isLeft,selectedIndex);
        self.selectedIndex = selectedIndex;
        [_mainTableView reloadData];
    };
    [self.view addSubview:custonsegment];
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(custonsegment.frame) + 5, kWidth, kHeight - 64 - custonsegment.frame.size.height) style:UITableViewStylePlain];
    
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.backgroundColor = kBGDefaultColor;
    [self.view addSubview:_mainTableView];
     [_mainTableView registerNib:[UINib nibWithNibName:@"WBMainCell2" bundle:nil] forCellReuseIdentifier:@"WBMainCell2"];
    [_mainTableView registerClass:[KTopicCell class] forCellReuseIdentifier:@"KTopicCell"];
}


#pragma mark----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedIndex == 0) {
        WBMainCell2 *cell2 = [tableView dequeueReusableCellWithIdentifier:@"WBMainCell2" forIndexPath:indexPath];
        
        CGFloat arrowX = kWidth - 10 - 7.5;
        CGFloat arrowY = (cell2.frame.size.height - 14) * 0.5;
        UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(arrowX, arrowY, 7.5, 14)];
        arrow.image = [UIImage imageNamed:@"arrow_right"];
        [cell2.contentView addSubview:arrow];
        
        
        return cell2;
    }else if(self.selectedIndex == 1){
        KTopicCell *topicCell = [tableView dequeueReusableCellWithIdentifier:@"KTopicCell" forIndexPath:indexPath];
        return topicCell;
    }
        
    return nil;
}

#pragma mark----UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 90;
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
