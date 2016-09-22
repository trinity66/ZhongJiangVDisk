//
//  LineSeries.h
//  BBStockChartViewDemo
//
//  Created by ChenXiaoyu on 15/5/26.
//  Copyright (c) 2015年 ChenXiaoyu. All rights reserved.
//

#import "Series.h"

@interface LineSeries : Series

@property (nonatomic, strong) UIColor* color;
/*
 因项目需求，用自己写的方法实现折线图及折线背景色的方法
 superViewheight 折线图的高度
 superViewWidth 折线图的总宽度
 */
@property (nonatomic) float width, superViewheight, superViewWidth;
- (void)addBackLayer;
@end
