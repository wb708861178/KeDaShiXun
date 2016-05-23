//
//  WBGuidePageView.h
//  kedashixunDemo
//
//  Created by wangbing on 16/5/21.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^JumpMainVCBlock) ();
@interface WBGuidePageView : UIView
@property (nonatomic, copy) JumpMainVCBlock jumpMainVCBlock;
- (instancetype)initWithFrame:(CGRect)frame withImageNameArr:(NSArray *)imageNameArr;
@end
