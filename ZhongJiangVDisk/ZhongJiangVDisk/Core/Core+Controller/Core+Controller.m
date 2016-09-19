//
//  Core+Controller.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/25.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "Core+Controller.h"

@implementation Core (Controller)
/*
 获取当前正在显示的ViewController
 */
- (UIViewController *)currentTopViewController
{
    UIViewController *result = nil;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [UIApplication sharedApplication].windows;
        for (UIWindow *tmpWindow in windows) {
            if (tmpWindow.windowLevel == UIWindowLevelNormal) {
                window = tmpWindow;
                break;
            }
        }
    }
    UIView *frontView = [window subviews].firstObject;
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    }else
    {
        result = window.rootViewController;
    }
    return result;
}
/*
 去充值
 */
- (void)goRechargeVC
{
    UIViewController *topVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RechargeController *vc = [storyboard instantiateViewControllerWithIdentifier:@"RechargeController"];
    BaseNavigationController *rechargeNvc = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [topVc presentViewController:rechargeNvc animated:YES completion:nil];
}
/*
 去重置交易密码
 */
- (void)goForgetDealPswdVC
{
    BaseTabBarController *topVc = (BaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ForgetDealPswdController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ForgetDealPswdController"];
    BaseNavigationController *homeNav = topVc.viewControllers.firstObject;
    [homeNav pushViewController:vc animated:YES];
}
/*!
 *  扫一扫
 */
- (ScanQRCodeController *)goScanQRCodeVC
{
    BaseTabBarController *root = (BaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    BaseNavigationController *firstNavc = root.viewControllers.firstObject;
    ScanQRCodeController *qrcodeVC = [[ScanQRCodeController alloc] init];
    [qrcodeVC selfAddToParentController:firstNavc];
    return qrcodeVC;
}
/*
 去注册
 */
- (void)goRegisterVC
{
    [self performSelector:@selector(goRegisterVCDelay) withObject:nil afterDelay:0.01];
}
- (void)goRegisterVCDelay
{
    BaseTabBarController *root = (BaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    BaseNavigationController *firstNavc = root.viewControllers.firstObject;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RegisterController *vc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterController"];
    BaseNavigationController *nacv = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [firstNavc presentViewController:nacv animated:NO completion:nil];
}
/*
 去webController
 params:url - 网址链接
 navigationController - rootNavi
 */
- (void)goWebVCWithUrl:(NSString *)url inNavigationController:(UINavigationController *)navigationController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WebController *webVC = [storyboard instantiateViewControllerWithIdentifier:@"WebController"];
    webVC.url = url;
    [navigationController pushViewController:webVC animated:YES];
}

@end
