//
//  AppDelegate.h
//  kedashixunDemo
//
//  Created by wangbing on 16/5/8.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import <UIKit/UIKit.h>





#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) BMKMapManager *mapManager;


@end

