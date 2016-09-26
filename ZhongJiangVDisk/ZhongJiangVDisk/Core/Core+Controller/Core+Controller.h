//
//  Core+Controller.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/25.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "Core.h"
#import "ScanQRCodeController.h"
@interface Core (Controller)
- (UIViewController *)currentTopViewController;
- (void)goRechargeVC;
- (void)goForgetDealPswdVC;
- (void)goRegisterVC;
- (ScanQRCodeController *)goScanQRCodeVC;
- (void)goWebVCWithUrl:(NSString *)url inNavigationController:(UINavigationController *)navigationController;
@end
