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
#import "WBCustomBottomUpView.h"
#import "WBChangeNickNameViewController.h"
#import "WBChangeMottoViewController.h"

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



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBGDefaultColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.leftBarButtonItems = [UIBarButtonItem barButtonItemWithImageName:@"arrow_left" withHighlightedImageName:@"arrow_left" withTarget:self withAction:@selector(returnSideMenuBtnAction:) WithNegativeSpacerWidth:-4];
    [self setNavBarTitleWithText:@"个人中心" withFontSize:20 withTextColor:[UIColor whiteColor]];
    [self viewLayout];
}

- (void)viewLayout
{
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 8,kWidth , kHeight - 64) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, kWidth, 1)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
    [cell.contentView addSubview:lineView];
    
    if (indexPath.row == 0){
        UIImageView *iconImageView = [[UIImageView alloc] init];
//        iconImageView.backgroundColor = [UIColor redColor];
        CGFloat iconImageViewX = cell.contentView.frame.size.width + 45 - 34 ;
        CGFloat iconImageViewY = (44 - 34 ) * 0.5;
        iconImageView.frame = CGRectMake(iconImageViewX, iconImageViewY , 34, 34);
        iconImageView.image = [UIImage imageNamed:@"personal_icon"];
//        cell.contentView.backgroundColor = [UIColor cyanColor];
        [cell.contentView addSubview:iconImageView];
        
         }else{
        UILabel *contentLbl = [[UILabel alloc] initWithFrame:CGRectMake( cell.contentView.frame.size.width + 45 - 100, 0, 100, 44)];
        contentLbl.text = self.titleArr[indexPath.row];
        contentLbl.font = [UIFont systemFontOfSize:12];
        contentLbl.textColor = [UIColor colorWithHexString:@"#333333"];
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
            
            WBCustomBottomUpView *bottomView = [self createWBCustomBottomUpViewWithTextArr:@[@"从相册中选取",@"拍照",@"取消"]];
                    bottomView.selectedIndexBlock = ^(NSInteger selectedIndex){
                switch (selectedIndex) {
                    case 0:
                    {
                        NSLog(@"相册");
                    }
                        break;
                    case 1:
                    {
                         NSLog(@"拍照");
                    }
                        break;
                    case 2:
                    {
                       NSLog(@"取消");
                        
                    }
                        break;
                        
                    default:
                        break;
                }
            };

          
            
        }
            break;
        case 1:
        {
            WBChangeNickNameViewController *changeNickNameVC = [[WBChangeNickNameViewController alloc] init];
            [self.navigationController pushViewController:changeNickNameVC animated:YES];
            
        }
            break;
        case 2:
        {
            
            WBCustomBottomUpView *bottomView = [self createWBCustomBottomUpViewWithTextArr:@[@"男",@"女",@"取消"]];
            bottomView.selectedIndexBlock = ^(NSInteger selectedIndex){
                switch (selectedIndex) {
                    case 0:
                    {
                        NSLog(@"男");
                    }
                        break;
                    case 1:
                    {
                        NSLog(@"女");
                    }
                        break;
                    case 2:
                    {
                        NSLog(@"取消");
                        
                    }
                        break;
                        
                    default:
                        break;
                }
            };
 
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            WBChangeMottoViewController *changeMottoVC = [[WBChangeMottoViewController alloc] init];
            [self.navigationController pushViewController:changeMottoVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}



- (WBCustomBottomUpView *)createWBCustomBottomUpViewWithTextArr:(NSArray *)textArr
{
    WBCustomBottomUpView *bottomView = [[WBCustomBottomUpView alloc] initWithFrame:self.view.bounds];
    
    [bottomView setBgColor:[UIColor whiteColor] textColor:[UIColor colorWithHexString:@"#333333"] textFont:[UIFont systemFontOfSize:14] lineColor:[UIColor colorWithHexString:@"#dddddd"]];
    
    [bottomView setTextArr:textArr withBottomViewHeightRatio:0.2];
      [self.view.window  addSubview:bottomView];
    return bottomView;
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
