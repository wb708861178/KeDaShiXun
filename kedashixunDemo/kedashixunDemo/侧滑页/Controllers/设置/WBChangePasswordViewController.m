//
//  WBChangePasswordViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/17.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBChangePasswordViewController.h"

#import "Const.h"
@interface WBChangePasswordViewController ()

@end

@implementation WBChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hasReturnArrow = YES;
    [self viewLayout];
    
    
    // Do any additional setup after loading the view.
}
- (void)viewLayout
{
    UIView *oldPwdView = [[UIView alloc] initWithFrame:CGRectMake(0, 84, kWidth, 50)];
    oldPwdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:oldPwdView];
    UILabel *oldPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 120, oldPwdView.frame.size.height)];
    oldPwdLabel.text = @"原登录密码:";
    oldPwdLabel.textAlignment = NSTextAlignmentRight;
    oldPwdLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    oldPwdLabel.font = [UIFont systemFontOfSize:16];
    [oldPwdView addSubview:oldPwdLabel];
    UITextField *oldPwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(oldPwdLabel.frame) + 10, 10, 150, 30)];
    oldPwdTextField.placeholder = @"输入原始密码";
//    oldPwdTextField.backgroundColor = kBGDefaultColor;
    [oldPwdView addSubview:oldPwdTextField];
    
    
    UIView *newPwdView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(oldPwdView.frame)+ 1 , kWidth, oldPwdView.frame.size.height)];
    newPwdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:newPwdView];
    UILabel *newPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 120, oldPwdView.frame.size.height)];
    newPwdLabel.text = @"新登录密码:";
        newPwdLabel.textAlignment = NSTextAlignmentRight;
    newPwdLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    newPwdLabel.font = [UIFont systemFontOfSize:16];
    [newPwdView addSubview:newPwdLabel];
    UITextField *newPwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(oldPwdLabel.frame) + 10, 10, 150, 30)];
    newPwdTextField.placeholder = @"输入新密码";
    //    oldPwdTextField.backgroundColor = kBGDefaultColor;
    [newPwdView addSubview:newPwdTextField];
    
    
    
    UIView *ensurePwdView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(newPwdView.frame) + 1, kWidth, oldPwdView.frame.size.height)];
    ensurePwdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ensurePwdView];
    UILabel *ensurePwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 120, oldPwdView.frame.size.height)];
    ensurePwdLabel.text = @"确认新登录密码:";
        ensurePwdLabel.textAlignment = NSTextAlignmentRight;
    ensurePwdLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    ensurePwdLabel.font = [UIFont systemFontOfSize:16];
    [ensurePwdView addSubview:ensurePwdLabel];
    UITextField *ensurePwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(oldPwdLabel.frame)  + 10, 10, 150, 30)];
    ensurePwdTextField.placeholder = @"再次输入新密码";
    //    oldPwdTextField.backgroundColor = kBGDefaultColor;
    [ensurePwdView addSubview:ensurePwdTextField];
    
    
   
    
    
    
    CGFloat ensureBtnW = kWidth * 4 / 5;
    CGFloat ensureBtnH = ensureBtnW * 0.15;
    CGFloat ensureBtnX =( kWidth - ensureBtnW ) * 0.5;
    CGFloat ensureBtnY = CGRectGetMaxY(ensurePwdView.frame)+ 60;
    UIButton *ensureBtn = [[UIButton alloc] initWithFrame:CGRectMake(ensureBtnX, ensureBtnY, ensureBtnW, ensureBtnH)];
    ensureBtn.backgroundColor = [UIColor colorWithHexString:@"#ed8a57"];
    [ensureBtn setTitle:@"确认" forState:UIControlStateNormal];
    ensureBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [ensureBtn addTarget:self action:@selector(ensureBtn) forControlEvents:UIControlEventTouchUpInside];
    ensureBtn.layer.cornerRadius = ensureBtnH * 0.1;
    [self.view addSubview:ensureBtn];

}





- (void)ensureBtn
{
    NSLog(@"确认");
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
