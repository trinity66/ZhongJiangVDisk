//
//  LineSeries.m
//  BBStockChartViewDemo
//
//  Created by ChenXiaoyu on 15/5/26.
//  Copyright (c) 2015年 ChenXiaoyu. All rights reserved.
//

#import "LineSeries.h"
#import "BBTheme.h"

@interface LineSeries ()
{
    NSMutableArray *dataY;
}
@end
@implementation LineSeries

-(instancetype)init{
    self = [super init];
    if (self) {
        self.width = [BBTheme theme].defLineWidth;
        self.color = LCoreCurrent.chartLineColor;
    }
    return self;
}


- (void)addPoint:(float)p{
    [super.data addObject:[NSNumber numberWithFloat:p]];
}
- (void)drawAnimated:(BOOL)animated
{
    [super drawAnimated:animated];
    if (!dataY) {
        dataY = [NSMutableArray array];
    }else
    {
        [dataY removeAllObjects];
    }
    for (int i = 0; i < self.data.count; i ++) {
        float y = self.bounds.size.height - [self.axisAttached heighForVal:((NSNumber*)self.data[i]).floatValue];
        float x = i*self.pointWidth;
        [dataY addObject:@[[NSNumber numberWithFloat:x], [NSNumber numberWithFloat:y]]];
    }
    [self addLineLayer];
    if (LCoreCurrent.VDiskType != VDiskTypeYinHe) {
        [self addBackLayer];
    }
}
/*
 此处因项目要求，无用
 */
/*
 - (void)drawPoint:(NSUInteger)idx animated:(BOOL)animated{
 if (idx == 0 || idx >= self.data.count) {
 return;
 }
 CGFloat height = self.bounds.size.height;
 float y1 = height - [self.axisAttached heighForVal:((NSNumber*)self.data[idx-1]).floatValue];
 float y2 = height - [self.axisAttached heighForVal:((NSNumber*)self.data[idx]).floatValue];
 CALayer* line = [BaseLayer layerOfLineFrom:CGPointMake((idx-1)*self.pointWidth, y1) to:CGPointMake(idx*self.pointWidth, y2) withColor:self.color andWidth:self.width animated:animated];
 [self addSublayer:line];
 }
 */
/*
 画折线
 */
- (void)addLineLayer
{
    CALayer *line = [BaseLayer lineWithPoints:dataY color:self.color height:_superViewheight width:_superViewWidth animated:NO];
    [self addSublayer:line];
}
/*
 画渐变背景
 */
- (void)addBackLayer
{
    CALayer* back = [BaseLayer backWithPoints:dataY height:_superViewheight width:_superViewWidth];
    [self addSublayer:back];
}

- (void)prepareForDraw{
    self.axisAttached.touchBottom = YES;
    for (NSNumber* n in self.data) {
        [self.axisAttached addContainingVal:n.floatValue];
    }
}
@end
