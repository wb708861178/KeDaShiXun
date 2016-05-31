//
//  WBForgetPasswordViewController.h
//  kedashixunDemo
//
//  Created by wangbing on 16/5/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBBaseViewController.h"

@interface WBForgetPasswordViewController : WBBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;

@property (weak, nonatomic) IBOutlet UITextField *vertifyCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getVertifyCodeBtn;

@property (weak, nonatomic) IBOutlet UITextField *resetPwdTextField;

@end
