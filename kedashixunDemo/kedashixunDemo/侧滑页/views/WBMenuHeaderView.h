//
//  WBMenuHeaderView.h
//  kedashixunDemo
//
//  Created by wangbing on 16/5/8.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JumpToVC)();
@interface WBMenuHeaderView : UIView
@property (nonatomic, copy) JumpToVC jumpToLoginVCBlock;


@end
