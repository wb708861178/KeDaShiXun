//
//  WBMainDetailViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/12.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBMainDetailViewController.h"
#import "Const.h"
#import "WBCustomPictureWall.h"
#import "UIColor+HexColor.h"
#import "WBMainDetailBottomView.h"
#import "UIBarButtonItem+WBCustomButton.h"
#import "UIView+WBLocation.h"
#import "UILabel+ResetContent.h"
#import "WBNetworking.h"
#import "WBUserInfo.h"
#import <MJExtension.h>
#import "WBKedamCollectionStatus.h"


@interface WBMainDetailViewController ()
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) WBKedamCollectionStatus *kedamCollectionStatus;
@property (nonatomic, strong) WBMainDetailBottomView *bottomView ;

@end

@implementation WBMainDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavBarTitleWithText:@"时讯详情" withFontSize:20 withTextColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItems = [UIBarButtonItem barButtonItemWithImageName:@"arrow_left" withHighlightedImageName:@"arrow_left" withTarget:self withAction:@selector(returnMainBtnAction:) WithNegativeSpacerWidth:-5];
    [self viewLayout];
    
    //先得到收藏状态，如果收藏则换图片不可点击,没收藏则可以点击 ，为空时增加状态
    [self requestWithCollectionStatus];
    
    
   
}


#pragma mark--view布局
- (void)viewLayout{
    
    
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 50 - 64)];
    [self.view addSubview:mainScrollView];
    self.mainScrollView = mainScrollView;
    
    
    CGFloat titleLableX = 20;
    CGFloat titleLableW = (kWidth - titleLableX * 2) ;
    NSDictionary *titleLableAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17]};
     CGRect  titleLableTextRect = [self.kedaMessage.title boundingRectWithSize:CGSizeMake(titleLableW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:titleLableAttributes context:nil];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(titleLableX, 20, titleLableW, titleLableTextRect.size.height)];
    titleLable.numberOfLines = 0;
    titleLable.font = [UIFont systemFontOfSize:17];
    titleLable.text = self.kedaMessage.title;
    titleLable.textAlignment = NSTextAlignmentCenter;
    [mainScrollView addSubview:titleLable];
    
    UILabel *dateLable = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLable.frame) +  15, kWidth, 20)];
    dateLable.text = self.kedaMessage.date;
    dateLable.textAlignment = NSTextAlignmentCenter;
    [mainScrollView addSubview:dateLable];
    
    NSArray *imageUrlArr = [self.kedaMessage.images componentsSeparatedByString:@"+"];
    
    WBCustomPictureWall *customPictureWall = [[WBCustomPictureWall alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(dateLable.frame) + 20, kWidth - 40 , 0)withImageUrlArr:imageUrlArr withTopSpace:0 withLeftSpace:0 withHorizontalSpace:2 withVerticalSpace:2];
  
    if (imageUrlArr == nil) {
        customPictureWall.frame = CGRectMake(customPictureWall.frameX, customPictureWall.frameY - 20, customPictureWall.frameW, 0);
      
    }
    
    customPictureWall.selectBlock = ^(NSInteger selectedIndex){
        NSLog(@"%zi",selectedIndex);
    };
    
   
    
    [mainScrollView addSubview:customPictureWall];
    
    
    
    UILabel *contentLable = [UILabel resetContentWithContent:self.kedaMessage.content withFontSize:15 withLineHeight:15 withLineSapce:20 withHeadIndent:15];

    NSDictionary *contentLableAttributes = [contentLable.attributedText attributesAtIndex:0 effectiveRange:nil];
   
    
    
    
   
    CGRect  textRect = [contentLable.text boundingRectWithSize:CGSizeMake(customPictureWall.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:contentLableAttributes context:nil];
    
    
    contentLable.frame = CGRectMake(customPictureWall.frame.origin.x, CGRectGetMaxY(customPictureWall.frame) + 20, customPictureWall.frame.size.width, textRect.size.height);
    contentLable.numberOfLines = 0;
    [mainScrollView addSubview:contentLable];
    
    UILabel *placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(contentLable.frame) - 200, CGRectGetMaxY(contentLable.frame) + 10, 200, 20)];
    
    placeLabel.text = self.kedaMessage.department;
    placeLabel.textAlignment = NSTextAlignmentRight;
    placeLabel.font = [UIFont systemFontOfSize:12];
    
    placeLabel.textColor = [UIColor lightGrayColor];
    [mainScrollView addSubview:placeLabel];
    
    
    
    WBMainDetailBottomView *bottomView = [[NSBundle mainBundle] loadNibNamed:@"WBMainDetailBottomView" owner:nil options:nil].firstObject;
    bottomView.frame = CGRectMake(0, kHeight -50 , kWidth, 50);
    UITapGestureRecognizer *praiseViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(praiseViewTap:)];
    [bottomView.praiseView addGestureRecognizer:praiseViewTap];
    
    UITapGestureRecognizer *shareViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareViewTap:)];
    [bottomView.shareView addGestureRecognizer:shareViewTap];

    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    
   
    //设置mainScroll的内容
    mainScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(placeLabel.frame) + 20 );

    
    
    
    
    
    
    
    
    
    
    
    
}


#pragma mark---按钮单击事件
- (void)returnMainBtnAction:(UIButton *)btn{
    [self pop];
}

- (void)praiseViewTap:(UITapGestureRecognizer *)praiseViewTap{
    //改变按钮 的图片和下面view手势可交互
    self.bottomView.praiseImageView.image = [UIImage imageNamed:@"shoucang_selected"];
    self.bottomView.praiseLabel.text = @"已收藏";
    self.bottomView.praiseView.userInteractionEnabled = NO;
    //改变收藏状态
     NSDictionary *updateStatusParams = @{@"uid":[NSString stringWithFormat:@"%d",[WBUserInfo share].userid],@"kid":[NSString stringWithFormat:@"%d",self.kedaMessage.kedamessageid],@"collectionstatus":@"1"};
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getUpdateKedamCollectionStatus params:updateStatusParams successBlock:^(id returnData) {
        NSLog(@"%@",returnData);
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    //增加时讯收藏记录
    NSDictionary *params = @{@"kedamid":[NSString stringWithFormat:@"%d",self.kedaMessage.kedamessageid],@"uid":[NSString stringWithFormat:@"%d",[WBUserInfo share].userid]};
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getAddKedamcollection params:params successBlock:^(id returnData) {
        NSLog(@"%@",returnData);
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)shareViewTap:(UITapGestureRecognizer *)shareViewTap{
    NSLog(@"分享");
}




#pragma mark---请求数据
 - (void)requestWithCollectionStatus
{
    //得到收藏状态 如果为空，则需要加入状态
    NSDictionary *params = @{@"uid":[NSString stringWithFormat:@"%d",[WBUserInfo share].userid],@"kid":[NSString stringWithFormat:@"%d",self.kedaMessage.kedamessageid]};
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getKedamcollectionstatus params:params successBlock:^(id returnData) {
        if ([returnData[@"status"] intValue] == 200) {
            self.kedamCollectionStatus = [WBKedamCollectionStatus mj_objectWithKeyValues:returnData[@"data"][0]];
            if ([self.kedamCollectionStatus.collectionstatus intValue] == 1) {
                
                self.bottomView.praiseImageView.backgroundColor = [UIColor redColor];
                self.bottomView.praiseLabel.text = @"已收藏";
                self.bottomView.praiseView.userInteractionEnabled = NO;
            }

        }
        
        
        
        
        
        
        //为空时是400状态
        if ([returnData[@"status"] intValue] == 400) {
             NSDictionary *addStatusParams = @{@"uid":[NSString stringWithFormat:@"%d",[WBUserInfo share].userid],@"kid":[NSString stringWithFormat:@"%d",self.kedaMessage.kedamessageid],@"collectionstatus":@"0"};
            NSLog(@"======%@",addStatusParams);

            [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getAddkedamcollectionstatus params:addStatusParams successBlock:^(id returnData) {
                NSLog(@"%@",returnData);
            } failureBlock:^(NSError *error) {
                NSLog(@"%@",error);
            }];
            
            
            
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark--UITableViewDelegate
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
