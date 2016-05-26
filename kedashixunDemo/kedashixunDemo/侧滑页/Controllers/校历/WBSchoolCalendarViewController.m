//
//  WBSchoolCalendarViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/16.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBSchoolCalendarViewController.h"
#import "UIBarButtonItem+WBCustomButton.h"
#import "Const.h"
#import "BQLCalendar.h"
@interface WBSchoolCalendarViewController ()

@end

@implementation WBSchoolCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setNavBarTitleWithText:@"科大校历" withFontSize:20.f withTextColor:[UIColor whiteColor]];
    self.hasReturnArrow = YES;
    
    [self viewLayout];
    
    // Do any additional setup after loading the view.
}
- (void)viewLayout
{
    
    //获取当前时间
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月"];
    NSString *dateTime = [formatter stringFromDate:now];
    
    
    UILabel *topLabel = [[UILabel alloc ]initWithFrame:CGRectMake(0, 66, kWidth, 40)];
    topLabel.backgroundColor = kMainColor;
    topLabel.textColor = [UIColor whiteColor];
    topLabel.text = dateTime;
    topLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:topLabel];
    
    
    
   
    NSCalendar *myCalendar = [NSCalendar currentCalendar];
    
    
    NSUInteger unitFlags =  NSCalendarUnitDay ;
    
    NSDateComponents *dateComponent = [myCalendar components:unitFlags fromDate:now];
    NSInteger day = [dateComponent day];
    
    BQLCalendar *calendar = [[BQLCalendar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topLabel.frame), kWidth  , kWidth * 0.8)];
    
    [self.view addSubview:calendar];
    NSString *currentDay = [NSString stringWithFormat:@"%ld",day];
    [calendar initSign:@[currentDay] Touch:^(NSString *date) {
        
        NSLog(@"点击了日期:%@",date);
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
