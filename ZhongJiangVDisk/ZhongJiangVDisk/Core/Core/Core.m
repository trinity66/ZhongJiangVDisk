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
+(Core *)current
{
    static Core *core = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        core = [[Core alloc] init];
    });
    return core;
}
- (void)setIsLogin:(BOOL)isLogin
{
    if (isLogin) {
        [LConfigCurrent set_object_for_key:@"isLogin" value:@"1"];
    }else
    {
        [LConfigCurrent set_object_for_key:@"isLogin" value:@"0"];
    }
}
- (BOOL)isLogin
{
    NSInteger l = [[LConfigCurrent object_value_with_key:@"isLogin"] integerValue];
    if (l) {
        return YES;
    }else
    {
        return NO;
    }
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
- (void)goRegisterVC
{
    UIViewController *topVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RegisterController *vc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterController"];
    BaseNavigationController *rechargeNvc = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [topVc presentViewController:rechargeNvc animated:NO completion:nil];
}

- (void)showAlertTitle:(NSString *)title timeCount:(NSInteger)timeCount inView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.color = [UIColor colorWithRed:1.00 green:0.97 blue:0.86 alpha:1.00];
    hud.bezelView.layer.borderWidth = 1;
    hud.bezelView.layer.borderColor = hud.bezelView.color.CGColor;
    hud.label.text = title;
    hud.label.numberOfLines = 0;
    hud.contentColor = LCoreCurrent.selectedLineColor;
    hud.label.font = [UIFont systemFontOfSize:kCellLabelFont-2];
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:timeCount];
}
- (UIImage *)image_with_color:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
-(void)setVDiskType:(VDiskType)VDiskType
{
    _VDiskType = VDiskType;
    if (_VDiskType == VDiskTypeZhongJiang) {
        [self initColorsWithModelkey:@"VDiskTypeZhongJiang"];
    }
    if (_VDiskType == VDiskTypeZhongHui) {
        [self initColorsWithModelkey:@"VDiskTypeZhongHui"];
    }
}
@end
