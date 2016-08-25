//
//  InputDealPswdView.h
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/15.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputDealPswdView : UIView
@property (nonatomic, copy)btnsActionBlock btnsActionBlock;
@property (weak, nonatomic) IBOutlet LTextField *textField;
- (void)showInputDealPswdViewAnimated:(BOOL)animated;
- (void)removeInputDealPswdViewAnimated:(BOOL)animated;
@end
