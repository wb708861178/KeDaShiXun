//
//  KPublishTopicVC.m
//  kedashixunDemo
//
//  Created by KZL on 16/5/13.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "KPublishTopicVC.h"
#import "UIBarButtonItem+WBCustomButton.h"


@interface KPublishTopicVC ()

@end

@implementation KPublishTopicVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavBarTitleWithText:@"发布主题" withFontSize:20 withTextColor:[UIColor whiteColor]];
    
    self.navigationItem.leftBarButtonItems = [UIBarButtonItem barButtonItemWithImageName:@"arrow_left"  withHighlightedImageName:nil  withTarget:self withAction:@selector(pop) WithNegativeSpacerWidth:-16];

 
    self.navigationItem.rightBarButtonItems = [UIBarButtonItem barButtonItemWithTitle:@"发帖" WithTitleColor:[UIColor whiteColor] WithTitleHighlightColor:[UIColor whiteColor] withTarget:self withAction:@selector(publishTopic) WithNegativeSpacerWidth:-4];

}




#pragma mark --- 发布帖子

- (void)publishTopic{
    
    
    
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
