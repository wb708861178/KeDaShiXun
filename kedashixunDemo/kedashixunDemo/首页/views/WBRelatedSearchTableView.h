//
//  WBRelatedSearchTableView.h
//  kedashixunDemo
//
//  Created by wangbing on 16/5/26.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBKedaMessage;
typedef void (^JumpToVCBlock)(WBKedaMessage *kedaMessage);
typedef void (^HiddenKeyBoardBlock)();
@interface WBRelatedSearchTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray  *dataSourceArr;
@property (nonatomic, copy) JumpToVCBlock jumpToVCBlock;
@property (nonatomic, copy) HiddenKeyBoardBlock hiddenKeyBoardBlock;

@end
