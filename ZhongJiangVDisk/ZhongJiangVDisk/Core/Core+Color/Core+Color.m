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
- (void)initColorsWithModelkey:(NSString *)key
{
    
    NSDictionary *dict = [self colorsDictionary][key];
    self.riseColor = [self colorWithArray:dict[@"riseColor"]];
    self.fallColor = [self colorWithArray:dict[@"fallColor"]];
    self.backgroundColor = [self colorWithArray:dict[@"backgroundColor"]];
    self.detailBackColor = [self colorWithArray:dict[@"detailBackColor"]];
    self.detailLightBackColor = [self colorWithArray:dict[@"detailLightBackColor"]];
    
    self.riseTextColor = [self colorWithArray:dict[@"riseTextColor"]];
    self.fallTextColor = [self colorWithArray:dict[@"fallTextColor"]];
    self.labelTextColor = [self colorWithArray:dict[@"labelTextColor"]];
    self.buttonTitleColor = [self colorWithArray:dict[@"buttonTitleColor"]];
    self.positionCellTextColor = [self colorWithArray:dict[@"positionCellTextColor"]];
    
    self.chartLineColor = [self colorWithArray:dict[@"chartLineColor"]];
    self.chartLinesColor = [self colorWithArray:dict[@"chartLinesColor"]];
    self.chartYTextColor = [self colorWithArray:dict[@"chartYTextColor"]];
    self.chartXTextColor = [self colorWithArray:dict[@"chartXTextColor"]];
    self.chartBackColor = [self colorWithArray:dict[@"chartBackColor"]];
    
    self.selectedLineColor = [self colorWithArray:dict[@"selectedLineColor"]];
    self.tabBarSelectTextColor = [self colorWithArray:dict[@"tabBarSelectTextColor"]];
    self.tabBarTextColor = [self colorWithArray:dict[@"tabBarTextColor"]];
    self.buttonBackColor = [self colorWithArray:dict[@"buttonBackColor"]];
    self.personalTopColor = [self colorWithArray:dict[@"personalTopColor"]];
    
    self.cellTextColor = [self colorWithArray:dict[@"cellTextColor"]];
    self.topSegmentColor = [self colorWithArray:dict[@"topSegmentColor"]];
    self.textFieldBorderColor = [self colorWithArray:dict[@"textFieldBorderColor"]];
    self.textFieldBackColor = [self colorWithArray:dict[@"textFieldBackColor"]];
    self.textFieldSelectBackColor = [self colorWithArray:dict[@"textFieldSelectBackColor"]];
}
- (UIColor *)colorWithArray:(NSArray *)array
{
    CGFloat R = [array[0] floatValue];
    CGFloat G = [array[1] floatValue];
    CGFloat B = [array[2] floatValue];
    CGFloat alpha = [array[3] floatValue];
    return [UIColor colorWithRed:R green:G blue:B alpha:alpha];
}
- (NSDictionary *)colorsDictionary
{
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"VDiskTypes" ofType:@"json"]];
    NSError* err = nil;
    NSDictionary *dictionary = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
    return dictionary;
}
@end
