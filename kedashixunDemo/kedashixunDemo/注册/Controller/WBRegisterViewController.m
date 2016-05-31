//
//  WBRegisterViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/20.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBRegisterViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "WBWriteUserInfoViewController.h"
#import "UIAlertTool.h"
#import "WBTool.h"

static int count = 60;
@interface WBRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;

@property (weak, nonatomic) IBOutlet UITextField *vertifyCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getVertifyCodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;


@property (nonatomic, strong) NSTimer *timer;

@end

@implementation WBRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hasReturnArrow = YES;
     [self setNavBarTitleWithText:@"注册" withFontSize:20 withTextColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark--按钮单击事件
- (IBAction)getVertifyBtnAction:(UIButton *)sender {
   NSString *newPhone = [WBTool deleteSapceWithString:self.phoneNumTextField.text];
    
    if ([newPhone isEqualToString:@""]) {
        [[UIAlertTool alloc] showAlertView:self title:@"提示信息" message:@"手机号为空" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:nil cancle:nil];
        return;
    }
    if (newPhone.length != 11) {
        [[UIAlertTool alloc] showAlertView:self title:@"提示信息" message:@"手机号为11位" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{
            
        } cancle:nil];
        return;

    }
    
    
    if (newPhone.length == 11&&(![WBTool isMobileNumber:newPhone])  ) {
       [[UIAlertTool alloc] showAlertView:self title:@"提示信息" message:@"手机号错误" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{
          
       } cancle:nil];
        return;
    }
    
    
    
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:newPhone zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (error) {
            NSLog(@"得不到验证码");
            [[UIAlertTool alloc] showAlertView:self title:@"提示信息" message:@"手机号错误" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:nil cancle:nil];
            return ;
        }else{
            
            [self initTimer];
        }
        
    }];
    
    

}

- (IBAction)registerBtnAction:(UIButton *)sender {
   
    
    
    
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
            NSLog(@"验证码是对的");
            WBWriteUserInfoViewController *writeUserInfoVC = [[WBWriteUserInfoViewController alloc] initWithNibName:@"WBWriteUserInfoViewController" bundle:nil];
            [self.navigationController pushViewController:writeUserInfoVC animated:YES];
             writeUserInfoVC.passPhoneNum = [WBTool deleteSapceWithString:self.phoneNumTextField.text];
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
