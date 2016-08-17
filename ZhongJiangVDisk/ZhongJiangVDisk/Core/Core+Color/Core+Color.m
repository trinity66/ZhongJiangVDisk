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
             @"blackColor":[UIColor colorWithRed:0.37 green:0.37 blue:0.37 alpha:1.00],
             @"lightGrayColor":[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00],
             @"riseColor":[UIColor colorWithRed:0.79 green:0.03 blue:0.08 alpha:1.00],
             @"fallColor":[UIColor colorWithRed:0.06 green:0.51 blue:0.07 alpha:1.00],
             @"lightMainColor":[UIColor colorWithRed:0.84 green:0.72 blue:0.53 alpha:1.00],
             @"darkMainColor":[UIColor colorWithRed:0.64 green:0.52 blue:0.38 alpha:1.00]
             };
}
- (void)initColors
{
    NSDictionary *dict = [self zhongJiangColors];
    self.blackColor = dict[@"blackColor"];
    self.lightGrayColor = dict[@"lightGrayColor"];
    self.riseColor = dict[@"riseColor"];
    self.fallColor = dict[@"fallColor"];
    self.lightMainColor = dict[@"lightMainColor"];
    self.darkMainColor = dict[@"darkMainColor"];
}
@end
