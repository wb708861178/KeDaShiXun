//
//  WBCustomNavView.h
//  kedashixunDemo
//
//  Created by wangbing on 16/5/11.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JumpVCBlock) ();

@interface WBCustomNavView : UIView
@property (nonatomic, copy) JumpVCBlock jumpToMenuVCBlock;
@property (nonatomic, copy) JumpVCBlock jumpToSearchVCBlock;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
