//
//  UIAlertTool.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/30.
//  Copyright © 2016年 wangbing. All rights reserved.
//
#define IAIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#import "UIAlertTool.h"
typedef void (^confirm)();
typedef void (^cancle)();
@interface UIAlertTool(){
    
    confirm confirmParam;
    cancle  cancleParam;
}
@end
@implementation UIAlertTool
-(void)showAlertView:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle confirm:(void (^)())confirm cancle:(void (^)())cancle
{
    confirmParam=confirm;
    cancleParam=cancle;
    if (IAIOS8) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        // Create the actions.
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if (cancleParam) {
                cancle();
                
            }
           
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (confirmParam) {
                confirm();

            }
        }];
        // Add the actions.
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    else{
        UIAlertView *TitleAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:otherButtonTitle otherButtonTitles:cancelButtonTitle,nil];
        [TitleAlert show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        if (confirmParam) {
            confirmParam();
            
        }
    }
    else{
        if (cancleParam) {
            cancleParam();
            
        }
    }
}

@end
