//
//  Core+Controller.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/25.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "Core.h"

@interface Core (Controller)
- (void)goRechargeVC;
- (void)goForgetDealPswdVC;
- (void)goRegisterVC;
- (void)showAlertTitle:(NSString *)title timeCount:(NSInteger)timeCount inView:(UIView *)view;
- (void)goWebVCWithUrl:(NSString *)url inNavigationController:(UINavigationController *)navigationController;
@end