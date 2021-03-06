//
//  WBBaseViewController.m
//  FreeShuQiNovel
//
//  Created by wangbing on 16/4/19.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBBaseViewController.h"
#import "UIBarButtonItem+WBCustomButton.h"
#import "UIViewController+RESideMenu.h"
#import "RESideMenu.h"
#import "Const.h"

@interface WBBaseViewController ()

@end

@implementation WBBaseViewController

- (void)setHasReturnArrow:(BOOL)hasReturnArrow
{
    _hasReturnArrow = hasReturnArrow;
    if (hasReturnArrow) {
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem barButtonItemWithImageName:@"arrow_left" withHighlightedImageName:@"arrow_left" withTarget:self withAction:@selector(returnBtnAction) WithNegativeSpacerWidth:-4];
    }
    
}

- (void)setHideReturnBtn:(BOOL)hideReturnBtn
{
    _hideReturnBtn = hideReturnBtn;
    if (hideReturnBtn) {
         self.navigationItem.hidesBackButton = YES;
    }
   
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    
}

- (instancetype)initWithViewControllerNavItemStyle:(ViewControllerNavItemStyle)viewControllerNavItemStyle{
    self = [super init];
    if (self) {
        //不让view受navbar的影响
      
        
        
        
        switch (viewControllerNavItemStyle) {
            case ViewControllerNavItemStyleMain:
            {
               
//                self.navigationItem.leftBarButtonItems = [UIBarButtonItem barButtonItemWithImageName:@"navbar_menu" withHighlightedImageName:nil withTarget:self withAction:@selector(MainMenuBtnAction:) WithNegativeSpacerWidth:-5];
//    
//                
//                self.navigationItem.rightBarButtonItems = [UIBarButtonItem barButtonItemWithImageName:@"navbar_search" withHighlightedImageName:nil withTarget:self withAction:@selector(mainSearchBtnAction:) WithNegativeSpacerWidth:-5];

            }
                break;
           
            case ViewControllerNavItemStyleForum:
            {
                self.navigationItem.rightBarButtonItems = [UIBarButtonItem barButtonItemWithImageName:@"navbar_back" withHighlightedImageName:nil withTarget:self withAction:@selector(ForumPublishBtnAction:)  WithNegativeSpacerWidth:-10];

            }
                break;
                
                
            case ViewControllerNavItemStyleGuidance:
            {

                
            }
                break;
            case ViewControllerNavItemStylePhoneBook:
            {
                
                
            }
                break;


                
            default:
                break;
        }
        
    }
    return self;
}

#pragma mark---设置navBar上面title的文字及属性
- (void)setNavBarTitleWithText:(NSString *)title withFontSize:(CGFloat)fontSize withTextColor:(UIColor *)color{
    self.navigationItem.title = title;
    // 设置导航默认标题的颜色及字体大小
    NSDictionary *attributes = @{NSForegroundColorAttributeName : color, NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    self.navigationController.navigationBar.titleTextAttributes = attributes;
}

#pragma mark----navBar按钮单击事件


- (void)MainMenuBtnAction:(UIButton *)sender
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (void)mainSearchBtnAction:(UIButton *)sender
{
   NSLog(@"mainSearchBtnAction");
}

- (void)ForumPublishBtnAction:(UIButton *)sender
{
    NSLog(@"ForumPublishBtnAction");
}


- (void)pop{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)returnBtnAction
{
    [self pop];
}

//从隐藏navbar到显示navbar之间的处理
- (void)loadView {
    [super loadView];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    return;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kBGDefaultColor;
    
    // Do any additional setup after loading the view.
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
