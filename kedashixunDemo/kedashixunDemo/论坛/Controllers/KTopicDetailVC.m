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


#define space 10

@interface KTopicDetailVC () <UITableViewDataSource ,UITableViewDelegate>

@property (nonatomic, strong) UITableView *topicDetailTV;
@property (nonatomic, strong) KBottomCommentView *commentView;


@property (nonatomic, strong) NSMutableArray *commentListArr;

@end

@implementation KTopicDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavBarTitleWithText:@"话题详情" withFontSize:20 withTextColor:[UIColor whiteColor]];
    
    self.navigationItem.leftBarButtonItems = [UIBarButtonItem barButtonItemWithImageName:@"arrow_left"  withHighlightedImageName:nil  withTarget:self withAction:@selector(pop) WithNegativeSpacerWidth:-16];
    
    self.view.backgroundColor = kBGDefaultColor;
    
    [self viewLayout];
    
    //----------Test
    
    NSArray *commentList = @[@{@"icon":@"",@"name":@"卡兹克",@"time":@"2016-05-12",@"commentContent":@"家属就到了卡机的考拉姐圣诞节啊看来大家爱看洛杉矶的垃圾时打开垃圾收看了大家爱看了"}];
    
    self.commentListArr = [KCommentModel mj_objectArrayWithKeyValuesArray:commentList];
    
    //-----------
    
    //注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bottomViewFrameShouldChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)viewLayout{
    
    _topicDetailTV = [[UITableView alloc] initWithFrame:CGRectMake(0, space, kWidth, kHeight-44) style:UITableViewStylePlain];
    _topicDetailTV.delegate = self;
    _topicDetailTV.dataSource = self;
    _topicDetailTV.rowHeight = UITableViewAutomaticDimension;
    
    //设置header
    __weak typeof(self) mySelf = self;
    KTopicDetailHeader *topicDetailHeader = [[KTopicDetailHeader alloc] initWithFrame:CGRectMake(0, 64, kWidth, self.topicHeaderFrameModel.headerHeight)];
    topicDetailHeader.topicHeaderFrameModel = self.topicHeaderFrameModel;
    topicDetailHeader.showImageViewer = ^(){
        
        [[GQImageViewer sharedInstance] showView:mySelf];
      
    };
    _topicDetailTV.tableHeaderView = topicDetailHeader;
    [self.view addSubview:_topicDetailTV];
    
    //底部的评论view
    _commentView = [[NSBundle mainBundle] loadNibNamed:@"KBottomCommentView" owner:nil options:nil].firstObject;
    _commentView.frame = CGRectMake(0, kHeight-44, kWidth, 44);
    [_commentView.sendComment addTarget:self action:@selector(sendComment:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commentView];
    
}

#pragma mark --- UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"KCommentCell";
    KCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[NSBundle mainBundle] loadNibNamed:@"KCommentCell" owner:nil options:nil].firstObject;
    }
    
    //设置数据
    //-------------Test
    
    cell.commentModel = self.commentListArr[0];
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
    //空 直接返回
    if (!_commentView.commentTF.text) {
        return;
    }
    
    //评论数据
    
    
    
}

//键盘弹出消失  view的Frame变化
- (void)bottomViewFrameShouldChange:(NSNotification *)notification{
    
    NSDictionary *dict = notification.userInfo;
    CGRect endRect = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat changeY = endRect.origin.y - self.view.frame.size.height;
    
    self.commentView.transform = CGAffineTransformMakeTranslation(0, changeY);
    
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
