//
//  Core+Alert.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/19.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "Core.h"

@interface Core (Alert)<UIAlertViewDelegate, UIActionSheetDelegate>
- (void)showAlertTitle:(NSString *)title timeCount:(NSInteger)timeCount inView:(UIView *)view;

- (void)showAlertTitle:(NSString *)title message:(NSString*)message buttons:(NSArray<NSString *>*)buttons inVC:(UIViewController *)viewController btnsActionBlock:(btnsActionBlock)btnsActionBlock;
- (void)showActionSheetTitle:(NSString *)title message:(NSString *)message buttons:(NSArray<NSString *> *)buttons cancelButton:(NSString *)cancelButton inVC:(UIViewController *)viewController btnsActionBlock:(btnsActionBlock)btnsActionBlock;
@end
