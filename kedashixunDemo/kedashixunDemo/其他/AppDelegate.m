//
//  AppDelegate.m
//  kedashixunDemo
//
//  Created by wangbing on 16/5/8.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "AppDelegate.h"
#import "RESideMenu.h"
#import "WBMainViewController.h"
#import "WBMenuViewController.h"
#import "WBTabBarViewController.h"
#import "WBNavViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
   
    WBTabBarViewController *tabBarVC = [[WBTabBarViewController alloc] init];
    
    WBMenuViewController *menuVC = [[WBMenuViewController alloc] init];
   
    
    RESideMenu *sideMenu = [[RESideMenu alloc] initWithContentViewController:tabBarVC leftMenuViewController:menuVC rightMenuViewController:nil];
//    sideMenu.panFromEdge = YES;
//    //距离屏幕中心的偏移X
    sideMenu.contentViewInPortraitOffsetCenterX = [UIScreen mainScreen].bounds.size.width*0.2;
//    sideMenu.contentViewShadowEnabled = YES;
//    sideMenu.contentViewShadowColor = [UIColor redColor];
//    //缩放
//    sideMenu.scaleContentView = NO;
//    sideMenu.scaleMenuView = NO;
//    //alpha变化
//    sideMenu.fadeMenuView = NO;

    sideMenu.contentViewScaleValue = 0.8;
    
    self.window.rootViewController = sideMenu;
    
    [self.window makeKeyAndVisible];
    
    
    
    
    //加载引导页
    
    [self loadGuideView];
   
    
    
    return YES;
}

- (void)loadGuideView
{
//
//    NSDictionary *infoDict =  [NSBundle mainBundle].infoDictionary;
//    NSString *key = @"CFBundleShortVersionString";
//    NSString *currentVersionStr = infoDict[key];
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *versionStr = [defaults objectForKey:@"versionStr"];
//    
//    if (versionStr) {
//        if (![currentVersionStr isEqualToString:versionStr])
//        {
//            [defaults setObject:currentVersionStr forKey:@"versionStr"];
//            WBGuideView *guideView = [WBGuideView guideViewWithNib];
//            guideView.frame = tabBarVC.view.bounds;
//            
//            [tabBarVC.view addSubview:guideView];
//            
//        }
//        
//    }else
//    {
//        
//        [defaults setObject:currentVersionStr forKey:@"versionStr"];
//        
//        WBGuideView *guideView = [WBGuideView guideViewWithNib];
//        guideView.frame = tabBarVC.view.bounds;
//        
//        [tabBarVC.view addSubview:guideView];
//    }
//
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
