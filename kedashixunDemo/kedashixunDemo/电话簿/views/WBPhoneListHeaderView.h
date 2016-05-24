//
//  WBPhoneListHeaderView.h
//  kedashixunDemo
//
//  Created by wangbing on 16/5/24.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBPhoneList.h"

typedef void(^ReloadTableView) ();
@interface WBPhoneListHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong) WBPhoneList *phoneList;
@property (nonatomic, copy) ReloadTableView reloadTableView;

@property (strong, nonatomic)  UILabel *titleLabel;

@property (strong, nonatomic) UIImageView *arrowImageView;
@end
