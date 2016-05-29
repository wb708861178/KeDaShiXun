//
//  KTopicDetailVC.m
//  kedashixunDemo
//
//  Created by KZL on 16/5/10.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "KTopicDetailVC.h"
#import "UIBarButtonItem+WBCustomButton.h"
#import "Const.h"
#import "KTopicDetailHeader.h"
#import "KCommentCell.h"
#import <MJExtension.h>
#import "KBottomCommentView.h"
#import "GQImageViewer.h"
#import <MJRefresh.h>
#import "WBNetworking.h"


#define space 10

@interface KTopicDetailVC () <UITableViewDataSource ,UITableViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *topicDetailTV;
@property (nonatomic, strong) KBottomCommentView *commentView;
@property (nonatomic, strong) NSMutableArray *commentListArr;
@property (nonatomic, strong) KTopicDetailHeader *topicDetailHeader;

@end

@implementation KTopicDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavBarTitleWithText:@"话题详情" withFontSize:20 withTextColor:[UIColor whiteColor]];
    
    self.navigationItem.leftBarButtonItems = [UIBarButtonItem barButtonItemWithImageName:@"arrow_left"  withHighlightedImageName:nil  withTarget:self withAction:@selector(pop) WithNegativeSpacerWidth:-16];
    
    self.view.backgroundColor = kBGDefaultColor;
    
    [self viewLayout];
    
    
    [self commemtData];
    
    //注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bottomViewFrameShouldChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    //添加键盘回退手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(UIKeyBoardShouldReturn:)];
    
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}

- (void)commemtData{
    
    [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getComment params:@{@"fid":self.topicHeaderFrameModel.topicModel.topicId} successBlock:^(id returnData) {
        self.commentListArr = [KCommentModel mj_objectArrayWithKeyValuesArray:returnData[@"data"]];
        
        [self.topicDetailTV reloadData];
        _topicDetailHeader.commentCount = (int)self.commentListArr.count;
    } failureBlock:^(NSError *error) {
        
    }];
}

#pragma mark --- 添加键盘回退手势

- (void)UIKeyBoardShouldReturn:(UITapGestureRecognizer *)tap{
    
    
    [_commentView.commentTF resignFirstResponder];
}

#pragma mark ---  是否拦截手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    //点击不在commentview上 键盘回退
    if (!CGRectContainsPoint(_commentView.frame, [touch locationInView:self.view])) {
        
        [_commentView.commentTF resignFirstResponder];

    }
    
    return YES;
}


- (void)viewLayout{
    
    _topicDetailTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight-49-64) style:UITableViewStylePlain];
    _topicDetailTV.delegate = self;
    _topicDetailTV.dataSource = self;
    _topicDetailTV.rowHeight = UITableViewAutomaticDimension;
    
    //设置header
    __weak typeof(self) mySelf = self;
    _topicDetailHeader = [[KTopicDetailHeader alloc] initWithFrame:CGRectMake(0, 64, kWidth, self.topicHeaderFrameModel.headerHeight)];
    _topicDetailHeader.topicHeaderFrameModel = self.topicHeaderFrameModel;
    _topicDetailHeader.showImageViewer = ^(){
        
        [[GQImageViewer sharedInstance] showView:mySelf];
      
    };
    _topicDetailTV.tableHeaderView = _topicDetailHeader;
    [self.view addSubview:_topicDetailTV];
    
    //底部的评论view
    _commentView = [[NSBundle mainBundle] loadNibNamed:@"KBottomCommentView" owner:nil options:nil].firstObject;
    _commentView.frame = CGRectMake(0, kHeight-44, kWidth, 44);
    [_commentView.sendComment addTarget:self action:@selector(sendComment:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commentView];
    
}

#pragma mark --- UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.commentListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"KCommentCell";
    KCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[NSBundle mainBundle] loadNibNamed:@"KCommentCell" owner:nil options:nil].firstObject;
    }
    
    //设置数据
    //-------------Test
    
    cell.commentModel = self.commentListArr[indexPath.row];
    //-----------
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//发送评论
- (void)sendComment:(id)sender{
    
    [_commentView.commentTF resignFirstResponder];
    //空 直接返回
    if (!_commentView.commentTF.text) {
        return;
    }
    
    //评论数据
//-----------Test
    KCommentModel *commentModel = [KCommentModel mj_objectWithKeyValues:@{@"icon":@"",@"nickname":@"卡兹克",@"date":@"2016-05-12",@"content":_commentView.commentTF.text}];
    [self.commentListArr insertObject:commentModel atIndex:0];
    [self.topicDetailTV reloadData];
    
//-----------
    self.topicDetailHeader.commentCount = self.commentListArr.count;
    [self.topicDetailTV scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.commentListArr.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    //然后清空输入内容
    _commentView.commentTF.text = @"";
    
}

//键盘弹出消失  view的Frame变化
- (void)bottomViewFrameShouldChange:(NSNotification *)notification{
    
    NSDictionary *dict = notification.userInfo;
    CGRect endRect = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat changeY = endRect.origin.y - self.view.frame.size.height;
    self.view.transform = CGAffineTransformMakeTranslation(0, changeY);

}

- (void)dealloc{
    
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    
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
