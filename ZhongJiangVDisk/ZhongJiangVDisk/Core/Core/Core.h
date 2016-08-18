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
- (UIImage *)image_with_color:(UIColor *)color;
@property (nonatomic, strong)UIColor *riseColor, *fallColor, *backgroundColor, *riseTextColor, *fallTextColor;
@property (nonatomic, strong)UIColor *labelTextColor, *buttonTitleColor, *positionCellTextColor, *detailLightBackColor, *detailBackColor;
@property (nonatomic, strong)UIColor *chartLineColor, *chartYTextColor, *chartXTextColor, *chartLinesColor, *chartBackColor;
@property (nonatomic, strong)UIColor *selectedLineColor, *tabBarSelectTextColor, *tabBarTextColor, *buttonBackColor, *personalTopColor;
@property (nonatomic, strong)UIColor *cellTextColor, *topSegmentColor;
@end
