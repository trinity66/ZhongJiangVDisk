//
//  BBTheme.m
//  BBChart
//
//  Created by ChenXiaoyu on 15/1/12.
//  Copyright (c) 2015年 ChenXiaoyu. All rights reserved.
//

#import "BBTheme.h"

BBTheme* _defTheme = nil;
@implementation BBTheme

- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}

+(BBTheme *)theme{
    if (!_defTheme) {
        _defTheme = [[BBTheme alloc] init];
        _defTheme.riseColor = [[Core shareCore] zhongJiangColors][@"riseColor"];
        _defTheme.fallColor = [[Core shareCore] zhongJiangColors][@"fallColor"];
        _defTheme.barFillColor = [UIColor greenColor];
        _defTheme.barBorderColor = [UIColor clearColor];
        _defTheme.xAxisFontSize = 10;
        _defTheme.yAxisFontSize = 10;
        _defTheme.backgroundColor = [UIColor whiteColor];
        _defTheme.axisColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.78 alpha:1.00];
        _defTheme.borderColor = [UIColor yellowColor];
        _defTheme.defTextColor = [UIColor whiteColor];
        _defTheme.defLineColor = [UIColor yellowColor];
        _defTheme.defLineWidth = 1;
        _defTheme.defLabelGap = 30;
    }
    return _defTheme;
}
@end
