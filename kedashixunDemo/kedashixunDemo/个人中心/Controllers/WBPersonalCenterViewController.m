//
//  WBPersonalCenterViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/10.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBPersonalCenterViewController.h"
#import "Const.h"
#import "UIBarButtonItem+WBCustomButton.h"
#import "UIColor+HexColor.h"
#import "WBCustomBottomUpView.h"
#import "WBChangeNickNameViewController.h"
#import "WBChangeMottoViewController.h"
#import "WBUserInfo.h"
#import "WBNetworking.h"
#import <UIImageView+WebCache.h>


#pragma mark--拍照
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CoreAnimation.h>
#import <MobileCoreServices/UTCoreTypes.h>
@interface WBPersonalCenterViewController ()<NSURLSessionStreamDelegate,NSURLSessionTaskDelegate,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSMutableArray *userInfoArr;


#pragma mark--拍照
@property (nonatomic, copy) NSString *lastChosenMediaType;
@property (nonatomic, strong) UIImageView *iconImageView ;

@end

@implementation WBPersonalCenterViewController

- (NSMutableArray *)userInfoArr
{
    if (!_userInfoArr) {
        _userInfoArr = [NSMutableArray array];
    }
    return _userInfoArr;
}
- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = @[@"头像",@"昵称",@"性别",@"签名"];
    }
    return _titleArr;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}






- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUserInfoArr];
    
    
    self.view.backgroundColor = kBGDefaultColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setNav];
    
   
    [self viewLayout];
}

- (void)setNav{
    self.navigationItem.leftBarButtonItems = [UIBarButtonItem barButtonItemWithImageName:@"arrow_left" withHighlightedImageName:@"arrow_left" withTarget:self withAction:@selector(returnSideMenuBtnAction:) WithNegativeSpacerWidth:-4];
    [self setNavBarTitleWithText:@"个人中心" withFontSize:20 withTextColor:[UIColor whiteColor]];
}
- (void)initUserInfoArr{
    WBUserInfo *userInfo = [WBUserInfo share];
    [self.userInfoArr addObjectsFromArray:@[userInfo.icon,userInfo.nickname,userInfo.sex,userInfo.motto]];
    for (int i = 100; i < 100 + self.userInfoArr.count; i++) {
        if (i == 100) {
            continue;
        }
        UILabel *tempLable = [self.mainTableView viewWithTag:i];
        if (i == 102) {
            if ([self.userInfoArr[i-100] intValue] == 0) {
                tempLable.text = @"男";
            }else
            {
                tempLable.text = @"女";
            }
        }
        
        tempLable.text = self.userInfoArr[i- 100];
        
    }

}
- (void)viewLayout
{
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 8,kWidth , kHeight - 64) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_mainTableView];
}
#pragma mark-
#pragma mark-UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
 
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, kWidth, 1)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
    [cell.contentView addSubview:lineView];
    
    if (indexPath.row == 0){
        UIImageView *iconImageView = [[UIImageView alloc] init];
//        iconImageView.backgroundColor = [UIColor redColor];
        CGFloat iconImageViewX = cell.contentView.frame.size.width + 45 - 34 ;
        CGFloat iconImageViewY = (44 - 34 ) * 0.5;
        iconImageView.frame = CGRectMake(iconImageViewX, iconImageViewY , 34, 34);
        iconImageView.layer.cornerRadius = 17;
        iconImageView.layer.masksToBounds=  YES;
        self.iconImageView = iconImageView;

        
        if (![[WBUserInfo share].icon isEqualToString:@""]) {
            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[WBUserInfo share].icon]];
            
        }else
        {
            iconImageView.image = [UIImage imageNamed:@"personal_icon"];
        }
//        cell.contentView.backgroundColor = [UIColor cyanColor];
              [cell.contentView addSubview:iconImageView];
        
         }else{
        UILabel *contentLbl = [[UILabel alloc] initWithFrame:CGRectMake( cell.contentView.frame.size.width + 45 - 100, 0, 100, 44)];
             if (indexPath.row == 2) {
                 if ([self.userInfoArr[indexPath.row] intValue] == 0) {
                   contentLbl.text = @"男";
                 }else
                 {
                     contentLbl.text = @"女";
                 }
             }else
             {
                  contentLbl.text = self.userInfoArr[indexPath.row];
             }
       
        contentLbl.font = [UIFont systemFontOfSize:12];
        contentLbl.textColor = [UIColor colorWithHexString:@"#333333"];
        contentLbl.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:contentLbl];
             contentLbl.tag =indexPath.row + 100;
    }
    
    
    
    return cell;
}




#pragma mark-
#pragma mark-UITableViewDelegate



//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            
            WBCustomBottomUpView *bottomView = [self createWBCustomBottomUpViewWithTextArr:@[@"从相册中选取",@"拍照",@"取消"]];
                    bottomView.selectedIndexBlock = ^(NSInteger selectedIndex){
                switch (selectedIndex) {
                    case 0:
                    {
                        [self selectExistingPictureOrVideo];
                        
                       
                        
                    }
                        break;
                    case 1:
                    {
                        [self shootPictureOrVideo];
                    }
                        break;
                    case 2:
                    {
                       NSLog(@"取消");
                        
                    }
                        break;
                        
                    default:
                        break;
                }
            };

          
            
        }
            break;
        case 1:
        {
            WBChangeNickNameViewController *changeNickNameVC = [[WBChangeNickNameViewController alloc] init];
            changeNickNameVC.passValueBlock = ^(NSString *nickName){
                UILabel *tempLable = [self.mainTableView viewWithTag:101];
               
                tempLable.text = nickName;
            };
            [self.navigationController pushViewController:changeNickNameVC animated:YES];
            
        }
            break;
        case 2:
        {
            
            WBCustomBottomUpView *bottomView = [self createWBCustomBottomUpViewWithTextArr:@[@"男",@"女",@"取消"]];
            bottomView.selectedIndexBlock = ^(NSInteger selectedIndex){
                switch (selectedIndex) {
                    case 0:
                    {
                        
                        UILabel *tempLabel = [self.mainTableView viewWithTag:102];
                        tempLabel.text = @"男";
                        NSString *useridStr = [NSString stringWithFormat:@"%d",[WBUserInfo share].userid];
                        NSDictionary *params = @{@"userid":useridStr ,@"sex":@"0"};
                        [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getUpdateSex params:params successBlock:^(id returnData) {
                            NSLog(@"%@",returnData);
                            if ([returnData[@"status"] intValue] ==200) {
                                 [ [WBUserInfo share] saveUserInfoWithUserDict:returnData[@"data"][0] ];
                            }
                           
                        } failureBlock:^(NSError *error) {
                            
                        }];
                        
                        
                        
                    }
                        break;
                    case 1:
                    {
                        
                        UILabel *tempLabel = [self.mainTableView viewWithTag:102];
                        tempLabel.text = @"女";
                        NSString *useridStr = [NSString stringWithFormat:@"%d",[WBUserInfo share].userid];
                        NSDictionary *params = @{@"userid":useridStr ,@"sex":@"1"};
                        [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getUpdateSex params:params successBlock:^(id returnData) {
                            NSLog(@"%@",returnData);
                            if ([returnData[@"status"] intValue] ==200) {
                                [ [WBUserInfo share] saveUserInfoWithUserDict:returnData[@"data"][0] ];
                            }
                            
                        } failureBlock:^(NSError *error) {
                            
                        }];

                      
                    }
                        break;
                
                        break;
                        
                    default:
                        break;
                }
                
            };
 
        }
            break;
        case 3:
        {
            WBChangeMottoViewController *changeMottoVC = [[WBChangeMottoViewController alloc] init];
            changeMottoVC.passValueBlock = ^(NSString *motto){
                UILabel *tempLable = [self.mainTableView viewWithTag:103];
                
                tempLable.text = motto;
                
            };
            [self.navigationController pushViewController:changeMottoVC animated:YES];
        }
            break;
       
            
        default:
            break;
    }
}



- (WBCustomBottomUpView *)createWBCustomBottomUpViewWithTextArr:(NSArray *)textArr
{
    WBCustomBottomUpView *bottomView = [[WBCustomBottomUpView alloc] initWithFrame:self.view.bounds];
    
    [bottomView setBgColor:[UIColor whiteColor] textColor:[UIColor colorWithHexString:@"#333333"] textFont:[UIFont systemFontOfSize:14] lineColor:[UIColor colorWithHexString:@"#dddddd"]];
    
    [bottomView setTextArr:textArr withBottomViewHeightRatio:0.2];
      [self.view.window  addSubview:bottomView];
    return bottomView;
}

#pragma mark-按钮单击事件
- (void)returnSideMenuBtnAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}






#pragma  mark- 拍照模块
 //从相机上选择
 -(void)shootPictureOrVideo{
         [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
     }
 //从相册中选择
 -(void)selectExistingPictureOrVideo{
         [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
     }
 #pragma 拍照模块
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    
    UIImage *editImage = info[@"UIImagePickerControllerEditedImage"];
    CGSize imagesize = editImage.size;
    self.iconImageView.image = editImage;
    imagesize.height =80;
    imagesize.width =80;
    //对图片大小进行压缩--
    UIImage *imageNew = [self imageWithImage:editImage scaledToSize:imagesize];
    
    
    
    NSData *imageData = UIImagePNGRepresentation(imageNew);
    
    
    
    [self uploadImageData:imageData];
   
    [self performSelector:@selector(requestUserInfo) withObject:imageData afterDelay:1.0];
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
         self.lastChosenMediaType=[info objectForKey:UIImagePickerControllerMediaType];
         if([self.lastChosenMediaType isEqual:(NSString *) kUTTypeImage])
             {
                 UIImage *editImage = info[@"UIImagePickerControllerEditedImage"];
                 CGSize imagesize = editImage.size;
                 self.iconImageView.image = editImage;
                 imagesize.height =80;
                 imagesize.width =80;
                 //对图片大小进行压缩--
                 UIImage *imageNew = [self imageWithImage:editImage scaledToSize:imagesize];
                 
                 
                 
                 NSData *imageData = UIImagePNGRepresentation(imageNew);
                 
                 [self uploadImageData:imageData];
                 
                 
                 
                                }
        if([self.lastChosenMediaType isEqual:(NSString *) kUTTypeMovie])
             {
                     UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示信息!" message:@"系统只支持图片格式" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                     [alert show];
            
                 }
    [picker dismissViewControllerAnimated:YES completion:nil];

     }
 -(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
     [picker dismissViewControllerAnimated:YES completion:nil];
     }
 -(void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
 {
        NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
         if([UIImagePickerController isSourceTypeAvailable:sourceType] &&[mediatypes count]>0){
        
                 UIImagePickerController *picker=[[UIImagePickerController alloc] init];
                 picker.mediaTypes=mediatypes;
                 picker.delegate=self;
                 picker.allowsEditing=YES;
                 picker.sourceType=sourceType;
                 NSString *requiredmediatype=(NSString *)kUTTypeImage;
                 NSArray *arrmediatypes=[NSArray arrayWithObject:requiredmediatype];
                 [picker setMediaTypes:arrmediatypes];
             [self presentViewController:picker animated:YES completion:nil];
             
             }
         else{
                 UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误信息!" message:@"当前设备不支持拍摄功能" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                 [alert show];
             }
     }
// static UIImage *shrinkImage(UIImage *orignal,CGSize size)
// {
//         CGFloat scale=[UIScreen mainScreen].scale;
//         CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
//        CGContextRef context=CGBitmapContextCreate(NULL, size.width *scale,size.height*scale, 8, 0, colorSpace, kCGImageAlphaPremultipliedFirst);
//        CGContextDrawImage(context, CGRectMake(0, 0, size.width*scale, size.height*scale), orignal.CGImage);
//       CGImageRef shrunken=CGBitmapContextCreateImage(context);
//        UIImage *final=[UIImage imageWithCGImage:shrunken];
//         CGContextRelease(context);
//        CGImageRelease(shrunken);
//        return  final;
//   }

 


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

- (void)requestUserInfo
{
     NSDictionary *params = @{@"uid":[NSString stringWithFormat:@"%d",[WBUserInfo share].userid]};
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getUserInfo params:params successBlock:^(id returnData) {
        [[WBUserInfo share] saveUserInfoWithUserDict:returnData[@"data"][0]];
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
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
