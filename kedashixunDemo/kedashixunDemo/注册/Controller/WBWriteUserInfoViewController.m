//
//  WBWriteUserInfoViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBWriteUserInfoViewController.h"
#import "Const.h"
#import "WBNetworking.h"
#import "WBUserInfo.h"
#import <MJExtension.h>

@interface WBWriteUserInfoViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (weak, nonatomic) IBOutlet UIButton *userIcon;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;

@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *manBtn;
@property (weak, nonatomic) IBOutlet UIButton *womanBtn;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (nonatomic, strong) UIImagePickerController *imagePicker;


@property (nonatomic, copy) NSString *sex;



@end

@implementation WBWriteUserInfoViewController

//用initWithNibName加载vc  是不走 init方法的
- (instancetype)init
{
    self = [super init];
    if (self) {
                self.sex = @"0";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sex = @"0";
    

    self.manBtn.layer.borderWidth = 1.0;
    self.manBtn.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
    
    self.womanBtn.layer.borderWidth = 1.0;
    self.womanBtn.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
   
    self.hideReturnBtn = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark--按钮单击事件
- (IBAction)iconBtnAction:(UIButton *)sender {
     [self initImagePicker];
  }



- (IBAction)manBtnAction:(UIButton *)sender {
    self.manBtn.backgroundColor = kBtnDefaultColor;
    self.womanBtn.backgroundColor = [UIColor whiteColor];
    self.sex = @"0";
    
}
- (IBAction)womanBtnAction:(id)sender {
    self.womanBtn.backgroundColor = kBtnDefaultColor;
    self.manBtn.backgroundColor = [UIColor whiteColor];
    self.sex = @"1";
    
    
}
- (IBAction)commitBtnAction:(id)sender {

    
    NSDictionary *params = @{
                             @"account":self.passPhoneNum,
                             @"password":self.passwordTextfield.text,
                             @"icon":@"",
                             @"sex": self.sex,
                             @"nickname":self.nickNameTextField.text,
                             @"phonenum":self.passPhoneNum
                             };
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getRegister params:params successBlock:^(id returnData) {
          NSLog(@"NetType_getRegister=======%@",returnData);
        
        [[WBUserInfo share] saveUserInfoWithUserDict:returnData[@"data"]];
      
        [self.navigationController popToRootViewControllerAnimated:YES];

    } failureBlock:^(NSError *error) {
           NSLog(@"error = %@",error);
    }];
        
   
}


#pragma mark----相册
- (void)initImagePicker
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    self.imagePicker = imagePicker;
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
    

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"%@",info);
    UIImage *editImage = info[@"UIImagePickerControllerEditedImage"];
    [self.userIcon setBackgroundImage:editImage forState:UIControlStateNormal];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
    
    
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
