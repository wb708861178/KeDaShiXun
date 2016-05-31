//
//  WBLoginViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/20.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBLoginViewController.h"
#import "WBForgetPasswordViewController.h"
#import "WBRegisterViewController.h"

#import "RESideMenu.h"
#import "WBTabBarViewController.h"
#import "WBMenuViewController.h"

#import "WBUserInfo.h"
#import "WBNetworking.h"
#import <MJExtension.h>
#import "WBTool.h"
#import "UIAlertTool.h"
@interface WBLoginViewController ()
@property (nonatomic, strong) RESideMenu *sideMenu;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation WBLoginViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    WBUserInfo *userInfo = [WBUserInfo share];
    if (userInfo.phonenum != nil) {
        self.phoneNumTextField.text = userInfo.phonenum;
        self.passwordTextField.text = userInfo.password;
    }
    
}
- (RESideMenu *)sideMenu
{
    if (!_sideMenu) {
        WBTabBarViewController *tabBarVC = [[WBTabBarViewController alloc] init];
        
        WBMenuViewController *menuVC = [[WBMenuViewController alloc] init];
        _sideMenu = [[RESideMenu alloc] initWithContentViewController:tabBarVC leftMenuViewController:menuVC rightMenuViewController:nil];
        //    sideMenu.panFromEdge = YES;
        //    //距离屏幕中心的偏移X
        _sideMenu.contentViewInPortraitOffsetCenterX = [UIScreen mainScreen].bounds.size.width*0.2;
        _sideMenu.contentViewShadowEnabled = YES;
        _sideMenu.contentViewShadowColor = [UIColor redColor];
        //缩放
        _sideMenu.scaleContentView = NO;
        _sideMenu.scaleMenuView = NO;
        //alpha变化
        _sideMenu.fadeMenuView = NO;
        
        _sideMenu.contentViewScaleValue = 0.8;
    }
    return _sideMenu;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarTitleWithText:@"登录" withFontSize:20 withTextColor:[UIColor whiteColor]];
    self.hideReturnBtn = YES;
   
    // Do any additional setup after loading the view from its nib.
}



#pragma mark---按钮单击事件

- (IBAction)loginBtnAction:(UIButton *)sender {
    
    
    
    
    NSString *deleteSpacePhoneStr = [self.phoneNumTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
     NSString *deleteSpacePwdStr = [self.passwordTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([deleteSpacePhoneStr isEqualToString:@""]) {
        
        [[UIAlertTool alloc] showAlertView:self title:@"提示信息" message:@"账号为空" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:nil cancle:nil];
        return;
    }
    
    if ([deleteSpacePwdStr isEqualToString:@""]) {
        NSLog(@"密码为空");
         [[UIAlertTool alloc] showAlertView:self title:@"提示信息" message:@"密码为空" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:nil cancle:nil];
        return;
    }
    
    if ( ![WBTool isMobileNumber:deleteSpacePhoneStr]&& deleteSpacePhoneStr.length != 11) {
        NSLog(@"输入手机号不正确");
        [[UIAlertTool alloc] showAlertView:self title:@"提示信息" message:@"输入手机号不正确" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{
            self.phoneNumTextField.text = nil;
        } cancle:nil];
        return;
    }
   
    
    [self requestWithLogin];
   
}
- (IBAction)forgetBtnAction:(UIButton *)sender {
    WBForgetPasswordViewController *forgetPasswordVC = [[WBForgetPasswordViewController alloc] initWithNibName:@"WBForgetPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:forgetPasswordVC animated:YES];
}
- (IBAction)registerBtnAction:(UIButton *)sender {
    WBRegisterViewController *registerVC = [[WBRegisterViewController alloc] initWithNibName:@"WBRegisterViewController" bundle:nil];
    [self.navigationController pushViewController:registerVC animated:YES];
}
- (IBAction)qqBtnAction:(UIButton *)sender {
    
    
    
}
- (IBAction)sinaBtnAction:(UIButton *)sender {
    
    
    
    
    
}




#pragma mark---请求网络


- (void)requestWithLogin
{
    NSDictionary *params = @{@"account":self.phoneNumTextField.text,@"password":self.passwordTextField.text};
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getLogin params:params successBlock:^(id returnData) {
        
        switch ([returnData[@"status"] intValue]) {
            case 200:{
                [[WBUserInfo share] saveUserInfoWithUserDict:returnData[@"data"][0]];
                [self.navigationController pushViewController:self.sideMenu animated:YES];
            }
                break;
            case 400:{
                [[UIAlertTool alloc] showAlertView:self title:@"提示信息" message:@"密码不正确" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{
                    self.passwordTextField.text = nil;
                } cancle:nil];
            }
                break;
            default:
                break;
        }
        
        
    } failureBlock:^(NSError *error) {
        NSLog(@"------error = %@",error);
    }];
    

}



#pragma mark---键盘处理

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.phoneNumTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
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
