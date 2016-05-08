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

@interface WBForumViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) WBCustonSegment *topSegment;
//帖子类型
@property (nonatomic, strong) NSArray *typeArr;


@property (nonatomic, strong) UITableView *topicTV;
@property (nonatomic, strong) NSMutableArray *topicsArr;

@end

@implementation WBForumViewController

- (void)viewDidLoad {
    [super viewDidLoad];

     [self setNavBarTitleWithText:@"科大论坛" withFontSize:20 withTextColor:[UIColor blackColor]];


    [self viewLayout];


}


- (void)viewLayout{
    
    _typeArr = @[@"全部帖子",@"精品帖子",@"我参与的"];
    
    _topSegment = [[WBCustonSegment alloc] initWithFrame:CGRectMake(0, 64, kWidth, 44) WithItems:_typeArr WithColor:[UIColor blackColor] WithSelectColor:[UIColor redColor]];
    
    _topSegment.touchItemBlock = ^(NSInteger selectedIndex){
        
        
        NSLog(@"%zi",selectedIndex);
    };
    [self.view addSubview:_topSegment];

    
    CGFloat maxY = CGRectGetMaxY(_topSegment.frame);
    _topicTV = [[UITableView alloc] initWithFrame:CGRectMake(0, maxY, kWidth, kHeight-maxY-49) style:UITableViewStylePlain];
    _topicTV.delegate = self;
    _topicTV.dataSource = self;
    [self.view addSubview:_topicTV];
    
}

#pragma mark --- UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.topicsArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSLog(@"点击%ld",indexPath.row);
    
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
