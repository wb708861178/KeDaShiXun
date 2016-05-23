//
//  WBChangeMottoViewController.h
//  kedashixunDemo
//
//  Created by wangbing on 16/5/16.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "WBBaseViewController.h"
typedef void (^PassValueBlock)(NSString *motto);
@interface WBChangeMottoViewController : WBBaseViewController
@property (nonatomic, copy) PassValueBlock passValueBlock;
@end
