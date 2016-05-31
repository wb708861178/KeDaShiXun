//
//  WBForgetPasswordViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBForgetPasswordViewController.h"
#import "WBTool.h"
#import "UIAlertTool.h"
#import <SMS_SDK/SMSSDK.h>
#import "WBNetworking.h"
#import "WBUserInfo.h"
static int count = 60;
@interface WBForgetPasswordViewController ()
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation WBForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hasReturnArrow = YES;
    [self setNavBarTitleWithText:@"忘记密码" withFontSize:20 withTextColor:[UIColor whiteColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark---按钮单击事件
- (IBAction)getVertifyCodeBtnAction:(UIButton *)sender {
    
    if ([self isNotPhoneNum]) {
        return;
    }
    
    NSDictionary *isRegisterParams = @{@"account":[WBTool deleteSapceWithString:self.phoneNumTextField.text]};
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getIsRegiste params:isRegisterParams successBlock:^(id returnData) {
        NSLog(@"====%@",returnData);
        switch ([returnData[@"status"] intValue]) {
            case 200:
            {
                [[WBUserInfo share] saveUserInfoWithUserDict:returnData[@"data"][0]];
                [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:[WBTool deleteSapceWithString:self.phoneNumTextField.text] zone:@"86" customIdentifier:nil result:^(NSError *error) {
                    if (error) {
                        NSLog(@"得不到验证码");
                        [[UIAlertTool alloc] showAlertView:self title:@"提示信息" message:@"手机号错误" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:nil cancle:nil];
                        return ;
                    }else{
                        
                        [self initTimer];
                    }
                    
                }];

                
                
            }
                break;
            case 204:
            {
                [[UIAlertTool alloc] showAlertView:self title:@"提示信息" message:@"此账户没有注册" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:nil cancle:nil];
            }
                break;
                
            default:
                break;
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
    
    
   
}

- (IBAction)loginBtnAction:(UIButton *)sender {
    if ([self isNotPhoneNum]) {
        return;
    }
    
    
    NSString *newCode = [WBTool deleteSapceWithString:self.vertifyCodeTextField.text];
    
    if ([newCode isEqualToString:@""]) {
        [[UIAlertTool alloc] showAlertView:self title:@"提示信息" message:@"验证码不能为空" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:nil cancle:nil];
        return;
    }
    
    
    [SMSSDK commitVerificationCode:newCode phoneNumber:[WBTool deleteSapceWithString:self.phoneNumTextField.text] zone:@"86" result:^(NSError *error) {
        
        if (error) {
            NSLog(@"验证码不对");
            [[UIAlertTool alloc]showAlertView:self title:@"提示信息" message:@"验证码不对" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:nil cancle:nil];
            
        }else{
            
            NSString *deleteSpaceNewPwd = [WBTool deleteSapceWithString:self.resetPwdTextField.text];
            NSDictionary *updatePwdParams = @{@"userid":[NSString stringWithFormat:@"%d",[WBUserInfo share].userid],@"pwd":deleteSpaceNewPwd};
            [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getUpdateUserPwd params:updatePwdParams successBlock:^(id returnData) {
                NSLog(@"%@",returnData);
            } failureBlock:^(NSError *error) {
                NSLog(@"%@",error);
            }];
            
            
           
        }
        
    }];

}


#pragma mark--定时器

-(void)initTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(decreaseCount) userInfo:nil repeats:YES];
    
}


//定时器方法
- (void)decreaseCount
{
    [self.getVertifyCodeBtn setTitle:[NSString stringWithFormat:@"%zi秒再次发送",count - 1] forState:UIControlStateNormal];
    self.getVertifyCodeBtn.userInteractionEnabled = NO;
    count --;
    if (count == 0) {
        [self.timer invalidate];
        self.timer = nil;
        count = 60;
        [self.getVertifyCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        self.getVertifyCodeBtn.userInteractionEnabled = YES;
    }
    
}




- (BOOL)isNotPhoneNum
{
    NSString *newPhone = [WBTool deleteSapceWithString:self.phoneNumTextField.text];
    
    if ([newPhone isEqualToString:@""]) {
        [[UIAlertTool alloc] showAlertView:self title:@"提示信息" message:@"手机号为空" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:nil cancle:nil];
        return YES;
    }
    if (newPhone.length != 11) {
        [[UIAlertTool alloc] showAlertView:self title:@"提示信息" message:@"手机号为11位" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{
            
        } cancle:nil];
        return YES;
        
    }
    
    
    if (newPhone.length == 11&&(![WBTool isMobileNumber:newPhone])  ) {
        [[UIAlertTool alloc] showAlertView:self title:@"提示信息" message:@"手机号错误" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{
            
        } cancle:nil];
        return YES;
    }
    return NO;

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
