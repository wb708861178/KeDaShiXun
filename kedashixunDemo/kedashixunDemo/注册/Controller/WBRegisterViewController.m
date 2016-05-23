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
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumTextField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (error) {
            NSLog(@"得不到验证码");
//            [self initAlertControllerWithMessage:@"手机号不对" withObjectFlag:1];
            
        }else{
            NSLog(@"得到验证码");
            [self initTimer];
        }
        
    }];
    
    

}

- (IBAction)registerBtnAction:(UIButton *)sender {
    
    [SMSSDK commitVerificationCode:self.vertifyCodeTextField.text phoneNumber:self.phoneNumTextField.text zone:@"86" result:^(NSError *error) {
        
        if (error) {
            NSLog(@"验证码不对");
//             [self initAlertControllerWithMessage:@"验证码不对" withObjectFlag:2];
            
            WBWriteUserInfoViewController *writeUserInfoVC = [[WBWriteUserInfoViewController alloc] initWithNibName:@"WBWriteUserInfoViewController" bundle:nil];
            [self.navigationController pushViewController:writeUserInfoVC animated:YES];
            writeUserInfoVC.passPhoneNum = self.phoneNumTextField.text;
            
        }else{
            NSLog(@"验证码是对的");
            WBWriteUserInfoViewController *writeUserInfoVC = [[WBWriteUserInfoViewController alloc] initWithNibName:@"WBWriteUserInfoViewController" bundle:nil];
            [self.navigationController pushViewController:writeUserInfoVC animated:YES];
             writeUserInfoVC.passPhoneNum = self.phoneNumTextField.text;
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



#pragma mark---弹出框

//验证码错误则弹出提示框
- (void)initAlertControllerWithMessage:(NSString *)message withObjectFlag:(NSInteger)flag
{
    UIAlertAction *alertActionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    UIAlertAction *alertActionEnsure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (flag == 1) {
            self.phoneNumTextField.text = nil;
        }
        if (flag == 2) {
            self.vertifyCodeTextField.text = nil;
        }
        
    }];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:alertActionCancle];
    [alertController addAction:alertActionEnsure];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
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
