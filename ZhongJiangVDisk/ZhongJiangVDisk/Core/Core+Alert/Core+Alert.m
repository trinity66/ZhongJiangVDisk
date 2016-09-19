//
//  Core+Alert.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/19.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "Core+Alert.h"

@implementation Core (Alert)
/*
 提示信息展示--HUD风格
 */
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
/*
  提示信息展示--系统Alert风格
 */
- (void)showAlertTitle:(NSString *)title message:(NSString*)message buttons:(NSArray<NSString *>*)buttons inVC:(UIViewController *)viewController btnsActionBlock:(btnsActionBlock)btnsActionBlock
{
    self.alertBtnsBlock = btnsActionBlock;
    if (IS_VAILABLE_IOS8) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        for (int index = 0; index < buttons.count; index ++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:buttons[index] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (self.alertBtnsBlock) {
                    self.alertBtnsBlock(index);
                }
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:action];
        }
        [alertController presentViewController:viewController animated:YES completion:nil];
    }else
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        for (NSString *buttonTitle in buttons) {
            [alert addButtonWithTitle:buttonTitle];
        }
        [alert show];
    }
}
/*
 alertView delegate
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.alertBtnsBlock) {
        self.alertBtnsBlock(buttonIndex);
    }
}
/*
信息展示--系统ActionSheet风格
 */
- (void)showActionSheetTitle:(NSString *)title message:(NSString *)message buttons:(NSArray<NSString *> *)buttons cancelButton:(NSString *)cancelButton inVC:(UIViewController *)viewController btnsActionBlock:(btnsActionBlock)btnsActionBlock
{
    self.alertBtnsBlock = btnsActionBlock;
    if (IS_VAILABLE_IOS8) {
        UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        for (int index = 0; index < buttons.count; index ++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:buttons[index] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (self.alertBtnsBlock) {
                    self.alertBtnsBlock(index);
                }
                [actionSheetController dismissViewControllerAnimated:YES completion:nil];
            }];
            [actionSheetController addAction:action];
        }
        if (cancelButton && cancelButton.length > 0) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButton style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [actionSheetController dismissViewControllerAnimated:YES completion:nil];
            }];
            [actionSheetController addAction:cancelAction];
        }
        [actionSheetController presentViewController:viewController animated:YES completion:nil];
    }else
    {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancelButton destructiveButtonTitle:nil otherButtonTitles:nil, nil];
        for (NSString *buttonTitle in buttons) {
            [actionSheet addButtonWithTitle:buttonTitle];
        }
        [actionSheet showInView:viewController.view];
        
    }
}
/*
 actionSheet delegate
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.alertBtnsBlock) {
        self.alertBtnsBlock(buttonIndex);
    }
}


@end
