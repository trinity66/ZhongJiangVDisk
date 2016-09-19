//
//  BaseTabBarController.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/11.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "BaseTabBarController.h"
#import <AVFoundation/AVFoundation.h>
@interface BaseTabBarController ()

@end
__weak BaseTabBarController *baseTabSelf;
@implementation BaseTabBarController
- (void)awakeFromNib
{
    [super awakeFromNib];
    baseTabSelf = self;
    for (UITabBarItem *item in self.tabBar.items) {
        item.image = [item.image imageWithTintColor:LCoreCurrent.tabBarTextColor];
        item.selectedImage = [item.selectedImage imageWithTintColor:LCoreCurrent.tabBarSelectTextColor];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = LCoreCurrent.tabBarSelectTextColor;
    self.tabBar.backgroundImage = [LCoreCurrent image_with_color:LCoreCurrent.detailBackColor];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
#pragma  mark - 二维码扫描
/**
 *  是否可以打开设置页面
 *
 *  @return
 */
- (BOOL)canOpenSystemSettingView {
    if (IS_VAILABLE_IOS8) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

/**
 *  跳到系统设置页面
 */
- (void)systemSettingView {
    if (IS_VAILABLE_IOS8) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
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
