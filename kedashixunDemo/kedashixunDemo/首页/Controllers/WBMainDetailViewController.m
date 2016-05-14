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


@interface WBMainDetailViewController ()
@property (nonatomic, strong) UIScrollView *mainScrollView;

@end

@implementation WBMainDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavBarTitleWithText:@"时讯详情" withFontSize:20 withTextColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItems = [UIBarButtonItem barButtonItemWithImageName:@"arrow_left" withHighlightedImageName:@"arrow_left" withTarget:self withAction:@selector(returnMainBtnAction:) WithNegativeSpacerWidth:-5];
    [self viewLayout];
   
}


#pragma mark--view布局
- (void)viewLayout{
    
    
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 50 - 64) ];
    [self.view addSubview:mainScrollView];
    self.mainScrollView = mainScrollView;
    
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kWidth, 20)];
    titleLable.text = @"关于各学院已办理学生住宿费退款的通知";
    titleLable.textAlignment = NSTextAlignmentCenter;
    [mainScrollView addSubview:titleLable];
    
    UILabel *dateLable = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLable.frame) +  15, kWidth, 20)];
    dateLable.text = @"2015年10月26日";
    dateLable.textAlignment = NSTextAlignmentCenter;
    [mainScrollView addSubview:dateLable];
    
    
    NSArray *imageNameArr = @[@"shouyeimage2",@"shouyeimage2",@"shouyeimage2",@"shouyeimage2",@"shouyeimage2",@"shouyeimage2",@"shouyeimage2",@"shouyeimage2",@"shouyeimage2",@"shouyeimage2",@"shouyeimage2",@"shouyeimage2"];
    WBCustomPictureWall *customPictureWall = [[WBCustomPictureWall alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(dateLable.frame) + 20, kWidth - 40 , 0) withImageNameArr:imageNameArr withTopSpace:0 withLeftSpace:0 withHorizontalSpace:2 withVerticalSpace:2];
    
    customPictureWall.selectBlock = ^(NSInteger selectedIndex){
        NSLog(@"%zi",selectedIndex);
    };
    
   
    
    [mainScrollView addSubview:customPictureWall];
    
    UILabel *contentLable = [[UILabel alloc] init];
    contentLable.backgroundColor = [UIColor redColor];
    contentLable.font = [UIFont systemFontOfSize:15];
   
    contentLable.text = @"都是谁看见谁看见看大家快圣诞节的撒娇看就看大家看来大家快来打开的即可来得及爱空间的卡上的骄傲是看得见按时打卡上大家爱上暗示扩大时看到奥斯卡的萨克的骄傲开始大胜靠德按时打卡上加大是";
    
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    CGRect  textRect = [contentLable.text boundingRectWithSize:CGSizeMake(customPictureWall.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    
    contentLable.frame = CGRectMake(customPictureWall.frame.origin.x, CGRectGetMaxY(customPictureWall.frame) + 20, customPictureWall.frame.size.width, textRect.size.height);
    contentLable.numberOfLines = 0;
    [mainScrollView addSubview:contentLable];
    
    UILabel *placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(contentLable.frame) - 100, CGRectGetMaxY(contentLable.frame) + 10, 100, 20)];
    
    placeLabel.text = @"学工办";
    placeLabel.textAlignment = NSTextAlignmentRight;
    placeLabel.font = [UIFont systemFontOfSize:12];
    placeLabel.textColor = [UIColor lightGrayColor];
    [mainScrollView addSubview:placeLabel];
    
    NSLog(@"%@",placeLabel);
    
    WBMainDetailBottomView *bottomView = [[NSBundle mainBundle] loadNibNamed:@"WBMainDetailBottomView" owner:nil options:nil].firstObject;
    bottomView.frame = CGRectMake(0, kHeight -50 , kWidth, 50);
    UITapGestureRecognizer *praiseViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(praiseViewTap:)];
    [bottomView.praiseView addGestureRecognizer:praiseViewTap];
    
    UITapGestureRecognizer *shareViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareViewTap:)];
    [bottomView.shareView addGestureRecognizer:shareViewTap];

    [self.view addSubview:bottomView];
  
    
   
    //设置mainScroll的内容
    mainScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(placeLabel.frame) + 20 );

    
    
    
    
    
    
    
    
    
    
}


#pragma mark---按钮单击事件
- (void)returnMainBtnAction:(UIButton *)btn{
    [self pop];
}

- (void)praiseViewTap:(UITapGestureRecognizer *)praiseViewTap{
    NSLog(@"点赞");
}

- (void)shareViewTap:(UITapGestureRecognizer *)shareViewTap{
    NSLog(@"分享");
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
