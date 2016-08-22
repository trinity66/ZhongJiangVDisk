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
    static int i = 0;
    for (UITabBarItem *item in self.tabBar.items) {
        item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        i +=1;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = [Core shareCore].tabBarSelectTextColor;
    self.tabBar.backgroundImage = [[Core shareCore] image_with_color:[Core shareCore].detailBackColor];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![Core shareCore].isLogin) {
        [self intoQRCodeVC];
    }
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
/*!
 *  扫一扫
 */
- (void)intoQRCodeVC {
    // 判断是否可以获取相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if(authStatus == AVAuthorizationStatusDenied){
            NSString *title = @"相机权限受限", *content = @"请在iPhone的\"设置->隐私->相机\"选项中,允许本应用访问您的相机.";
            if (IS_VAILABLE_IOS8) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if ([self canOpenSystemSettingView]) {
                        [self systemSettingView];
                    }
                }]];
                [self presentViewController:alert animated:YES completion:nil];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"相机权限受限" message:@"请在iPhone的\"设置->隐私->相机\"选项中,允许\"商富业务员\"访问您的相机." delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
                [alert show];
            }
            
            return;
        }
        ScanQRCodeController *qrcodeVC = [[ScanQRCodeController alloc] init];
        qrcodeVC.view.alpha = 0;
        [qrcodeVC setDidReceiveBlock:^(NSString *rst) {
            NSLog(@"------------%@", rst);
            [baseTabSelf scanQRCodeWithURL:rst];
            
        }];
        [self addChildViewController:qrcodeVC];
        [self.view addSubview:qrcodeVC.view];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            qrcodeVC.view.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    } else {
        [[Core shareCore] showAlertTitle:@"获取相机失败,请查看手机相机是否可用" timeCount:2.5 inView:self.view];
    }
}
- (void)scanQRCodeWithURL:(NSString *)url
{
#warning 扫描二维码之后的处理
    [[Core shareCore] goRegisterVC];
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
