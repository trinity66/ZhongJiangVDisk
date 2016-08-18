//
//  Core+Color.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/11.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "Core+Color.h"

@implementation Core (Color)

- (NSDictionary *)zhongJiangColors
{
    return @{
             @"riseColor":[UIColor colorWithRed:0.79 green:0.03 blue:0.08 alpha:1.00],
             @"fallColor":[UIColor colorWithRed:0.06 green:0.51 blue:0.07 alpha:1.00],
             @"backgroundColor":[UIColor whiteColor],
             @"detailBackColor":[UIColor whiteColor],
             @"detailLightBackColor":[UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0],
             
             @"riseTextColor":[UIColor colorWithRed:0.79 green:0.03 blue:0.08 alpha:1.00],
             @"fallTextColor":[UIColor colorWithRed:0.06 green:0.51 blue:0.07 alpha:1.00],
             @"labelTextColor":[UIColor whiteColor],
             @"buttonTitleColor":[UIColor whiteColor],
             @"positionCellTextColor":[UIColor colorWithRed:0.84 green:0.72 blue:0.53 alpha:1.00],
             
             @"chartLineColor":[UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.0],
             @"chartLinesColor":[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0],
             @"chartYTextColor":[UIColor lightGrayColor],
             @"chartXTextColor":[UIColor lightGrayColor],
             @"chartBackColor":[UIColor whiteColor],
             
             @"selectedLineColor":[UIColor colorWithRed:0.84 green:0.72 blue:0.53 alpha:1.00],
             @"tabBarSelectTextColor":[UIColor colorWithRed:0.64 green:0.52 blue:0.38 alpha:1.00],
             @"tabBarTextColor":[UIColor lightGrayColor],
             @"buttonBackColor":[UIColor colorWithRed:0.84 green:0.72 blue:0.53 alpha:1.00],
             @"personalTopColor":[UIColor colorWithRed:0.84 green:0.72 blue:0.53 alpha:1.00],
             
             @"cellTextColor":[UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1.0],
             @"topSegmentColor":[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0],
             @"textFieldBorderColor":[UIColor lightGrayColor],
             @"textFieldBackColor":[UIColor whiteColor],
             @"textFieldSelectBackColor":[UIColor colorWithRed:0.84 green:0.72 blue:0.53 alpha:1.00],
             };
}
- (NSDictionary *)zhongHuiColors
{
    return @{
             @"riseColor":[UIColor colorWithRed:0.79 green:0.03 blue:0.08 alpha:1.00],
             @"fallColor":[UIColor colorWithRed:0.06 green:0.51 blue:0.07 alpha:1.00],
             @"backgroundColor":[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0],
             @"detailBackColor":[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0],
             @"detailLightBackColor":[UIColor blackColor],
             
             @"riseTextColor":[UIColor orangeColor],
             @"fallTextColor":[UIColor colorWithRed:0.41 green:0.69 blue:0.42 alpha:1.00],
             @"labelTextColor":[UIColor whiteColor],
             @"buttonTitleColor":[UIColor whiteColor],
             @"positionCellTextColor":[UIColor whiteColor],
             
             @"chartLineColor":[UIColor whiteColor],
             @"chartLinesColor":[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0],
             @"chartYTextColor":[UIColor orangeColor],
             @"chartXTextColor":[UIColor lightGrayColor],
             @"chartBackColor":[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0],
             
             @"selectedLineColor":[UIColor colorWithRed:0.88 green:0.73 blue:0.50 alpha:1.00],
             @"tabBarSelectTextColor":[UIColor whiteColor],
             @"tabBarTextColor":[UIColor lightGrayColor],
             @"buttonBackColor":[UIColor blackColor],
             @"personalTopColor":[UIColor blackColor],
             
             @"cellTextColor":[UIColor whiteColor],
             @"topSegmentColor":[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0],
             @"textFieldBorderColor":[UIColor blackColor],
             @"textFieldBackColor":[UIColor darkGrayColor],
             @"textFieldSelectBackColor":[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0],
             };
}
- (void)initColors
{
    NSDictionary *dict = [self zhongHuiColors];
    self.riseColor = dict[@"riseColor"];
    self.fallColor = dict[@"fallColor"];
    self.backgroundColor = dict[@"backgroundColor"];
    self.detailBackColor = dict[@"detailBackColor"];
    self.detailLightBackColor = dict[@"detailLightBackColor"];
    
    self.riseTextColor = dict[@"riseTextColor"];
    self.fallTextColor = dict[@"fallTextColor"];
    self.labelTextColor = dict[@"labelTextColor"];
    self.buttonTitleColor = dict[@"buttonTitleColor"];
    self.positionCellTextColor = dict[@"positionCellTextColor"];
    
    self.chartLineColor = dict[@"chartLineColor"];
    self.chartLinesColor = dict[@"chartLinesColor"];
    self.chartYTextColor = dict[@"chartYTextColor"];
    self.chartXTextColor = dict[@"chartXTextColor"];
    self.chartBackColor = dict[@"chartBackColor"];
    
    self.selectedLineColor = dict[@"selectedLineColor"];
    self.tabBarSelectTextColor = dict[@"tabBarSelectTextColor"];
    self.tabBarTextColor = dict[@"tabBarTextColor"];
    self.buttonBackColor = dict[@"buttonBackColor"];
    self.personalTopColor = dict[@"personalTopColor"];
    
    self.cellTextColor = dict[@"cellTextColor"];
    self.topSegmentColor = dict[@"topSegmentColor"];
    self.textFieldBorderColor = dict[@"textFieldBorderColor"];
    self.textFieldBackColor = dict[@"textFieldBackColor"];
    self.textFieldSelectBackColor = dict[@"textFieldSelectBackColor"];
}
@end
