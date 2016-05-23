//
//  WBChangeNickNameViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/16.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBChangeNickNameViewController.h"
#import "UIBarButtonItem+WBCustomButton.h"
#import "Const.h"
#import "WBUserInfo.h"
#import "WBNetworking.h"

@interface WBChangeNickNameViewController ()
@property (nonatomic, strong) UITextField *nickNameTextField;

@end

@implementation WBChangeNickNameViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.nickNameTextField becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.nickNameTextField resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBGDefaultColor;
    self.navigationItem.leftBarButtonItems = [UIBarButtonItem barButtonItemWithImageName:@"arrow_left" withHighlightedImageName:@"arrow_left" withTarget:self withAction:@selector(returnPersonalCenter) WithNegativeSpacerWidth:-4];
    self.navigationItem.rightBarButtonItems = [UIBarButtonItem barButtonItemWithTitle:@"保存" WithTitleColor:[UIColor whiteColor] WithTitleHighlightColor:[UIColor whiteColor] withTarget:self withAction:@selector(saveAction) WithNegativeSpacerWidth:-4] ;
    [self setNavBarTitleWithText:@"修改昵称" withFontSize:20.f withTextColor:[UIColor whiteColor]];
    
    [self viewLayout];
    // Do any additional setup after loading the view.
}

- (void)viewLayout{
    UIView *nickNameView = [[UIView alloc] initWithFrame:CGRectMake(0, 74, kWidth, 40)];
    nickNameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nickNameView];
    
    _nickNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, 100, nickNameView.frame.size.height)];
    _nickNameTextField.text = [WBUserInfo share].nickname;
    _nickNameTextField.font = [UIFont systemFontOfSize:14.f];
    _nickNameTextField.textColor = [UIColor colorWithHexString:@"#333333"];
    [nickNameView addSubview:_nickNameTextField];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)saveAction
{
    [self pop];
    self.passValueBlock(self.nickNameTextField.text);
    NSDictionary *params = @{@"userid":[NSString stringWithFormat:@"%d",[WBUserInfo share].userid],@"nickname":self.nickNameTextField.text};
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getUpdateNickname params:params successBlock:^(id returnData) {
        NSLog(@"%@",returnData);
        if ([returnData[@"status"] intValue] == 200) {
            [[WBUserInfo share] saveUserInfoWithUserDict:returnData[@"data"][0]];
        }
    } failureBlock:^(NSError *error) {
        
    }];
}

- (void)returnPersonalCenter
{
    [self pop];
    
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
