//
//  Core.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/11.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "Core.h"
#import "MBProgressHUD.h"
@implementation Core
+(Core *)shareCore
{
    static Core *core = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        core = [[Core alloc] init];
    });
    return core;
}
- (void)goRechargeVC
{
    UIViewController *topVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RechargeController *vc = [storyboard instantiateViewControllerWithIdentifier:@"RechargeController"];
    BaseNavigationController *rechargeNvc = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [topVc presentViewController:rechargeNvc animated:YES completion:nil];
}
- (void)goForgetDealPswdVC
{
    BaseTabBarController *topVc = (BaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ForgetDealPswdController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ForgetDealPswdController"];
    BaseNavigationController *homeNav = topVc.viewControllers.firstObject;
    [homeNav pushViewController:vc animated:YES];
}
- (void)showAlertTitle:(NSString *)title timeCount:(NSInteger)timeCount inView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.color = [UIColor colorWithRed:1.00 green:0.87 blue:0.39 alpha:0.2];
    hud.label.text = title;
    hud.label.font = [UIFont systemFontOfSize:13];
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:timeCount];
}
@end
