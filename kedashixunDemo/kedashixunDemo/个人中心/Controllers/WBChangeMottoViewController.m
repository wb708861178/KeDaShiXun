//
//  WBChangeMottoViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/16.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBChangeMottoViewController.h"
#import "UIBarButtonItem+WBCustomButton.h"
#import "Const.h"
#import "WBUserInfo.h"
#import "WBNetworking.h"
@interface WBChangeMottoViewController ()
@property (nonatomic, strong) UITextField *mottoTextField;
@end

@implementation WBChangeMottoViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mottoTextField becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.mottoTextField resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBGDefaultColor;
    self.navigationItem.leftBarButtonItems = [UIBarButtonItem barButtonItemWithImageName:@"arrow_left" withHighlightedImageName:@"arrow_left" withTarget:self withAction:@selector(returnPersonalCenter) WithNegativeSpacerWidth:-4];
    self.navigationItem.rightBarButtonItems = [UIBarButtonItem barButtonItemWithTitle:@"保存" WithTitleColor:[UIColor whiteColor] WithTitleHighlightColor:[UIColor whiteColor] withTarget:self withAction:@selector(saveAction) WithNegativeSpacerWidth:-4] ;
    [self setNavBarTitleWithText:@"修改签名" withFontSize:20.f withTextColor:[UIColor whiteColor]];
    
    [self viewLayout];
    // Do any additional setup after loading the view.
}
- (void)viewLayout{
    UIView *nickNameView = [[UIView alloc] initWithFrame:CGRectMake(0, 74, kWidth, 40)];
    nickNameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nickNameView];
    
    _mottoTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, 300, nickNameView.frame.size.height)];
    _mottoTextField.text = [WBUserInfo share].motto;
    _mottoTextField.font = [UIFont systemFontOfSize:14.f];
    _mottoTextField.textColor = [UIColor colorWithHexString:@"#333333"];
    [nickNameView addSubview:_mottoTextField];
    
}
- (void)saveAction
{
    NSLog(@"保存");
     [self pop];
    self.passValueBlock(self.mottoTextField.text);
   
    NSDictionary *params = @{@"userid":[NSString stringWithFormat:@"%d",[WBUserInfo share].userid],@"motto":self.mottoTextField.text};
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getUpdateMotto params:params successBlock:^(id returnData) {
       
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
