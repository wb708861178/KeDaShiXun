//
//  WBLoginMenuHeaderView.h
//  kedashixunDemo
//
//  Created by wangbing on 16/5/12.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^JumpToVC)();
@interface WBLoginMenuHeaderView : UIView
@property (nonatomic, copy) JumpToVC jumpToPersonalCenterVCBlock;

- (void) updateData;
@end
