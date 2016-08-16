//
//  Core.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/11.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "Core.h"

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
@end
