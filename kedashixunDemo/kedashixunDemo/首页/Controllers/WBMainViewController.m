//
//  WBMainViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/8.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBMainViewController.h"
#import "WBCustomNavView.h"
#import "Const.h"
#import "RESideMenu.h"


@interface WBMainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) WBCustomNavView *customNavView;
@property (nonatomic, strong) UITableView *mainTableView;


@end

@implementation WBMainViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarTitleWithText:@"科大时讯" withFontSize:18 withTextColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    
       [self viewLayout];
    
    
}

#pragma mark-
#pragma mark---UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}
#pragma mark---UITableViewDelegate






#pragma mark-
#pragma mark--------view布局
-(void)viewLayout{
    
    
    
    UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    
    [self.view addSubview:mainTableView];
    self.mainTableView = mainTableView;
    
    WBCustomNavView *customNavView = [[NSBundle mainBundle] loadNibNamed:@"WBCustomNavView" owner:nil options:nil].firstObject;
    customNavView.frame = CGRectMake(0, 0, kWidth, 64);
    
    customNavView.jumpToMenuVCBlock = ^{
        [self.sideMenuViewController presentLeftMenuViewController];
    };
    customNavView.jumpToSearchVCBlock = ^{
        NSLog(@"searchVC");
    };
    self.customNavView = customNavView;
    [self.view addSubview:customNavView];
    
    
    UIView *customHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 230)];
    
    UIImageView *bannerImageView = [[UIImageView alloc] initWithFrame:customHeaderView.bounds];
    bannerImageView.image = [UIImage imageNamed:@"banner_1"];
    [customHeaderView addSubview:bannerImageView];
    
    mainTableView.tableHeaderView = customHeaderView;

    

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
