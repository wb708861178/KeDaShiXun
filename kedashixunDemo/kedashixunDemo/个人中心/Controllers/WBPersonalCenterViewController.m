//
//  WBPersonalCenterViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/10.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBPersonalCenterViewController.h"
#import "Const.h"
#import "UIBarButtonItem+WBCustomButton.h"
#import "UIColor+HexColor.h"

@interface WBPersonalCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSArray *titleArr;



@end

@implementation WBPersonalCenterViewController
- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = @[@"头像",@"昵称",@"性别",@"手机号码",@"签名"];
    }
    return _titleArr;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.leftBarButtonItems = [UIBarButtonItem barButtonItemWithImageName:@"arrow_left" withHighlightedImageName:nil withTarget:self withAction:@selector(returnSideMenuBtnAction:) WithNegativeSpacerWidth:- 10];
    [self setNavBarTitleWithText:@"个人中心" withFontSize:20 withTextColor:[UIColor whiteColor]];
    [self viewLayout];
}

- (void)viewLayout
{
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64,kWidth , kHeight - 64) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];
}
#pragma mark-
#pragma mark-UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    cell.textLabel.text = self.titleArr[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    if (indexPath.row == 0){
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.backgroundColor = [UIColor redColor];
        CGFloat iconImageViewX = cell.contentView.frame.size.width + 45 - 40 ;
        CGFloat iconImageViewY = (44 - 40 ) * 0.5;
        iconImageView.frame = CGRectMake(iconImageViewX, iconImageViewY , 40, 40);
        cell.contentView.backgroundColor = [UIColor cyanColor];
        [cell.contentView addSubview:iconImageView];
        NSLog(@"--------%@",cell.contentView);
        
        
    }else{
        UILabel *contentLbl = [[UILabel alloc] initWithFrame:CGRectMake( cell.contentView.frame.size.width + 45 - 100, 0, 100, 44)];
        contentLbl.text = self.titleArr[indexPath.row];
        contentLbl.font = [UIFont systemFontOfSize:12];
        contentLbl.textColor = [UIColor lightGrayColor];
        contentLbl.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:contentLbl];
        
    }
    
    
    
    return cell;
}




#pragma mark-
#pragma mark-UITableViewDelegate



//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
            
        default:
            break;
    }
}



#pragma mark-按钮单击事件
- (void)returnSideMenuBtnAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
