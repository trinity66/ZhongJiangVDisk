//
//  ChartViewSuper.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/20.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBChartView.h"
@interface ChartViewSuper : UIView
@property (nonatomic, strong) BBChartView *chartView;
- (void)setChartViewWithIndex:(NSInteger)index;
@property (nonatomic) NSArray* chartData;

@end
