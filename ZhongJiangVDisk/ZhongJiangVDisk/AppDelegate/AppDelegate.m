//
//  AppDelegate.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/11.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
{
    ScanQRCodeController *qrcodeVC;
    NSTimer *timer;
}
@end
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    LCoreCurrent.VDiskType = VDiskTypeZhongHui;//VDiskTypeZhongJiang//VDiskTypeYinHe//
//    [self loadHomeTopDatas];
    if (!timer) {
      timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(loadHomeTopDatas) userInfo:nil repeats:YES];
        [timer fire];
    }
    if (!LCoreCurrent.isLogin) {
    [self performSelector:@selector(goRegister) withObject:nil afterDelay:0.01];
    }else
    {
        
        LCoreCurrent.isLogin = NO;
    }
    //    [self registerPgy];//bee4d9bffbc6cd5e5aa43e468fadc972
    return YES;
}

//- (void)registerPgy
//{
//    [[PgyManager sharedPgyManager] setEnableFeedback:NO];
//    //启动基本SDK
//    [[PgyManager sharedPgyManager] startManagerWithAppId:@"bee4d9bffbc6cd5e5aa43e468fadc972"];
//    //启动更新检查SDK
//    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:@"bee4d9bffbc6cd5e5aa43e468fadc972"];
//    [[PgyUpdateManager sharedPgyManager] checkUpdate];
//
//}


/*
 加载数据
 */
- (void)loadHomeTopDatas
{
    [LCoreCurrent requestWithURL:@"http://mhq.sh.1251421153.clb.myqcloud.com/HQ/AllGoods" resultBlock:^(BOOL success, id result, NSError *error, NSURLResponse *response) {
        if (result && [result isKindOfClass:[NSDictionary class]]) {
            [LCoreCurrent saveHomeTopData:result];
//            [(AppDelegate *)[UIApplication sharedApplication].delegate loadHomeTopDatas];
        }
    }];
}
- (void)scanQRCodeWithURL:(NSString *)url
{
#warning 扫描二维码之后的处理
    [LCoreCurrent goRegisterVC];
    [qrcodeVC selfRemoveFromSuperview];
    qrcodeVC = nil;
}
//模拟机测试时的通道
- (void)goRegister
{
    [LCoreCurrent goRegisterVC];
//    qrcodeVC = [LCoreCurrent goScanQRCodeVC];
//    __block AppDelegate *weakSelf = self;
//    qrcodeVC.didReceiveBlock = ^(NSString *rst) {
//        [weakSelf scanQRCodeWithURL:rst];
//    };
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [timer invalidate];
    timer = nil;
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
