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
#import "WBMainCell1.h"
#import "WBMainCell2.h"
#import "WBMainCell3.h"
#import "WBMainDetailViewController.h"


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
    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        switch (indexPath.row) {
        case 0:
        {
            WBMainCell1 *cell1 = [tableView dequeueReusableCellWithIdentifier:@"WBMainCell1" forIndexPath:indexPath];
            return cell1;
        }
            break;
        case 1:
        {
            WBMainCell2 *cell2 = [tableView dequeueReusableCellWithIdentifier:@"WBMainCell2" forIndexPath:indexPath];
            
            return cell2;
        }
            break;
        case 2:
        {
            WBMainCell3 *cell3 = [tableView dequeueReusableCellWithIdentifier:@"WBMainCell3" forIndexPath:indexPath];
            
            return cell3;
        }
            break;
            
        default:
                return nil;
            break;
    }
    
   
}
#pragma mark---UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            return 65;
        }
            break;
        case 1:
        {
            return 90;
        }
            break;
        case 2:
        {
            return 125;
        }
            break;
            
        default:
            break;
    }
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBMainDetailViewController *mainDetailVC = [[WBMainDetailViewController alloc] init];
    [self.navigationController pushViewController:mainDetailVC animated:YES];
}


#pragma mark-
#pragma mark--------view布局
-(void)viewLayout{
    
    
    
    UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    bannerImageView.image = [UIImage imageNamed:@"shouye_banner_1"];
    [customHeaderView addSubview:bannerImageView];
    
    mainTableView.tableHeaderView = customHeaderView;

    
    [mainTableView registerNib:[UINib nibWithNibName:@"WBMainCell1" bundle:nil] forCellReuseIdentifier:@"WBMainCell1"];
    [mainTableView registerNib:[UINib nibWithNibName:@"WBMainCell2" bundle:nil] forCellReuseIdentifier:@"WBMainCell2"];
    [mainTableView registerNib:[UINib nibWithNibName:@"WBMainCell3" bundle:nil] forCellReuseIdentifier:@"WBMainCell3"];
    
    

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
