//
//  ChartView.h
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/16.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LChartView.h"
@interface ChartView : UIView
@property (nonatomic, strong)LChartView *lChart;
- (void)setSelfFrame:(CGRect)frame;
@property (nonatomic, assign) NSInteger topSegSelectedIndex;

@end
