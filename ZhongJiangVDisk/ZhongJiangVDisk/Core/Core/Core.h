//
//  Core.h
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/11.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//
#define LCoreCurrent [Core current]

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, VDiskType) {
    VDiskTypeZhongJiang = 0,
    VDiskTypeZhongHui,
    
    
};
typedef void(^btnActionBlock)();
typedef void(^btnsActionBlock)(NSInteger index);
@interface Core : NSObject
+(Core *)current;
@property (nonatomic, assign)BOOL isLogin;
//基准色
@property (nonatomic, strong)UIColor *riseColor, *fallColor, *backgroundColor, *riseTextColor, *fallTextColor;
@property (nonatomic, strong)UIColor *labelTextColor, *buttonTitleColor, *positionCellTextColor, *detailLightBackColor, *detailBackColor;
@property (nonatomic, strong)UIColor *chartLineColor, *chartYTextColor, *chartXTextColor, *chartLinesColor, *chartBackColor;
@property (nonatomic, strong)UIColor *selectedLineColor, *tabBarSelectTextColor, *tabBarTextColor, *buttonBackColor, *personalTopColor;
@property (nonatomic, strong)UIColor *cellTextColor, *topSegmentColor, *textFieldBorderColor, *textFieldBackColor, *textFieldSelectBackColor;
@property (nonatomic, strong)UIColor *buttonBorderColor;

//初始化视图类型
@property (nonatomic, assign)VDiskType VDiskType;
@property (nonatomic, copy)NSString *VDiskTypeString;
@end
