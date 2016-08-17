//
//  Core.h
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/11.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^btnActionBlock)();
typedef void(^btnsActionBlock)(NSInteger index);
@interface Core : NSObject
+(Core *)shareCore;
- (void)goRechargeVC;
- (void)goForgetDealPswdVC;
- (void)showAlertTitle:(NSString *)title timeCount:(NSInteger)timeCount inView:(UIView *)view;

@property (nonatomic, strong)UIColor *blackColor, *lightGrayColor, *riseColor, *fallColor, *lightMainColor, *darkMainColor;
@end
