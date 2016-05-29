//
//  WBRelatedSearchTableView.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/26.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBRelatedSearchTableView.h"
#import "WBKedaMessage.h"
#import "Const.h"
#import "WBSearchResultViewController.h"
#define cellHeight 40
@implementation WBRelatedSearchTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

#pragma mark---UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataSourceArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    WBKedaMessage *kedaMessage = self.dataSourceArr[indexPath.row];
    cell.textLabel.text = kedaMessage.title;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
  
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight - 1, self.frame.size.width, 1)];
    cell.layer.cornerRadius = 5;
    
    lineView.backgroundColor = kBGDefaultColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.contentView addSubview:lineView];
    return cell;
}

#pragma mark---UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.hiddenKeyBoardBlock();
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2f];
   
    WBKedaMessage *kedaMessage = self.dataSourceArr[indexPath.row];
    
    
    self.jumpToVCBlock(kedaMessage);
    
    
    
    
}
//取消cell点中状态
- (void)deselect
{
    [self deselectRowAtIndexPath:[self indexPathForSelectedRow] animated:YES];
}



#pragma mark--键盘处理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.hiddenKeyBoardBlock();
}



- (void)tap:(UITapGestureRecognizer *)sender
{
    self.hiddenKeyBoardBlock();
 
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
