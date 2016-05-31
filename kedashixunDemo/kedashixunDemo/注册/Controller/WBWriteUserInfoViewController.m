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

@interface WBWriteUserInfoViewController ()<NSURLSessionStreamDelegate,NSURLSessionTaskDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>


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
   
    self.hasReturnArrow = YES;
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
    
    
    
    
    UIImage *editImage = info[@"UIImagePickerControllerEditedImage"];
    CGSize imagesize = editImage.size;
    [self.userIcon setBackgroundImage:editImage forState:UIControlStateNormal];
    imagesize.height =80;
    imagesize.width =80;
    //对图片大小进行压缩--
    UIImage *imageNew = [self imageWithImage:editImage scaledToSize:imagesize];
    
    
    
    NSData *imageData = UIImagePNGRepresentation(imageNew);
    
    [self uploadImageData:imageData];
    
    NSDictionary *params = @{@"uid":[NSString stringWithFormat:@"%d",[WBUserInfo share].userid]};
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getUserInfo params:params successBlock:^(id returnData) {
        NSLog(@"%@",returnData);
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
   
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
    
    
}
- (void)uploadImageData:(NSData *)data{
    NSString *bodyStr = [NSString stringWithFormat:@"uid=%@",[NSString stringWithFormat:@"%d",[WBUserInfo share].userid]];
    
    NSString *Str = @"http://115.28.87.147/phpfile/kedashixun/upload.php?";
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Str,bodyStr]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    NSLog(@"-----%ld",data.length);
    
    NSMutableData *bodyData = [NSMutableData data];
    
    [bodyData appendData:data];
    
    [request setHTTPBody:bodyData];
    
    
    NSString *strLength = [NSString stringWithFormat:@"%ld", (long)data.length];
    [request setValue:strLength forHTTPHeaderField:@"Content-Length"];
    
    NSString *strContentType = [NSString stringWithFormat:@"image/png; boundary=%@", @"homeSchoolChain"];
    [request setValue:strContentType forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:bodyData];
    //
    [uploadTask resume];
    
    
}
//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
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
