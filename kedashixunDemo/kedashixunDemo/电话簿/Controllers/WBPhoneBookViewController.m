//
//  WBPhoneBookViewController.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/8.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBPhoneBookViewController.h"
#import "Const.h"
#import "WBPhoneListCell.h"
#import "WBPhoneListHeaderView.h"
#import "WBPhoneList.h"
#import "WBNetworking.h"
#import <MJExtension.h>

@interface WBPhoneBookViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, strong)  WBPhoneListHeaderView *headerView;

@property (nonatomic, strong) UIWebView *phoneCallWebView;


@end

@implementation WBPhoneBookViewController

- (NSMutableArray *)dataSourceArr
{
    if (!_dataSourceArr) {
        _dataSourceArr = [NSMutableArray array];
    }
    return _dataSourceArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
      [self setNavBarTitleWithText:@"电话簿" withFontSize:18 withTextColor:[UIColor whiteColor]];
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getPhonelist params:nil successBlock:^(id returnData) {
       NSLog(@"%@",returnData);
        self.dataSourceArr = [WBPhoneList mj_objectArrayWithKeyValuesArray:returnData[@"data"]];
        NSLog(@"%@",self.dataSourceArr);
        
      
        [self.mainTableView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    [self viewLayout];
    
}

#pragma mark-
#pragma mark---UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSourceArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBPhoneListCell *phoneListCell = [self.mainTableView dequeueReusableCellWithIdentifier:@"WBPhoneListCell" forIndexPath:indexPath];
    phoneListCell.phoneList = self.dataSourceArr[indexPath.section];
    //作用：决定了子视图的显示范围。具体的说，就是当取值为YES时，剪裁超出父视图范围的子视图部分；当取值为NO时，不剪裁子视图。默认值为NO。
    
    phoneListCell.clipsToBounds = YES;
    
    return phoneListCell;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _headerView = [self.mainTableView dequeueReusableHeaderFooterViewWithIdentifier:@"WBPhoneListHeaderView"];
    _headerView.phoneList = self.dataSourceArr[section];
    if (_headerView.phoneList.isOpen) {
        _headerView.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        
    }else
    {
        _headerView.arrowImageView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }
    
    _headerView.tag = section + 100;
    __weak typeof(self) mySelf = self;
    _headerView.reloadTableView = ^(){
        
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
        [mySelf.mainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
        
       
    };
    return _headerView;
    
    
}


#pragma mark---UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _headerView = [tableView viewWithTag:indexPath.section+100];
    if(_headerView.phoneList.isOpen==YES)
    {
        return 60;
    }
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBPhoneList *phoneList = self.dataSourceArr[indexPath.section];
    
    [self openPhoneCallViewWithphoneNumber:phoneList.phonenum];
    
//    NSString *phoneStr = [NSString stringWithFormat:@"tel://%@",phoneList.phonenum];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneStr]];
//    NSLog(@"%zi",indexPath.section);
}

#pragma mark-
- (void)viewLayout
{
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64,kWidth ,kHeight - 64 ) style:UITableViewStyleGrouped];
    
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"WBPhoneListCell" bundle:nil] forCellReuseIdentifier:@"WBPhoneListCell"];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.mainTableView registerClass:[WBPhoneListHeaderView class] forHeaderFooterViewReuseIdentifier:@"WBPhoneListHeaderView"];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark---打电话
//打开拨打电话
- (void)openPhoneCallViewWithphoneNumber:(NSString *)phoneNum
{
    if (_phoneCallWebView == nil) {
        _phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    NSString *newPhoneString = [self dealWithPhoneNumber:phoneNum];
    if ([self isMobileNumber:newPhoneString]) {
        
        NSURL* dialUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", newPhoneString]];
        if ([[UIApplication sharedApplication] canOpenURL:dialUrl])
        {
            if (_phoneCallWebView) {
                [_phoneCallWebView loadRequest:[NSURLRequest requestWithURL:dialUrl]];
            }
            else{
                [[UIApplication sharedApplication] openURL:dialUrl];
            }
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"设备不支持" delegate:nil cancelButtonTitle:@"确定 " otherButtonTitles:nil, nil];
            [alert show];
            alert = nil;
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您选择的号码不合法" delegate:nil cancelButtonTitle:@"确定 " otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
    }
}

- (NSString *)dealWithPhoneNumber:(NSString *)phone
{
    NSString *newPhone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return newPhone;
}

- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextestphs evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return YES; //暂时不做检查
    }
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
