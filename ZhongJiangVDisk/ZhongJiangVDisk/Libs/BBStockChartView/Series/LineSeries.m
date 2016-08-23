//
//  LineSeries.m
//  BBStockChartViewDemo
//
//  Created by ChenXiaoyu on 15/5/26.
//  Copyright (c) 2015年 ChenXiaoyu. All rights reserved.
//

#import "LineSeries.h"
#import "BBTheme.h"
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

- (void)drawPoint:(NSUInteger)idx animated:(BOOL)animated{
    if (idx == 0 || idx >= self.data.count) {
        return;
    }
    CGFloat height = self.bounds.size.height;
    float y1 = height - [self.axisAttached heighForVal:((NSNumber*)self.data[idx-1]).floatValue];
    float y2 = height - [self.axisAttached heighForVal:((NSNumber*)self.data[idx]).floatValue];
    CALayer* line = [BaseLayer layerOfLineFrom:CGPointMake((idx-1)*self.pointWidth, y1) to:CGPointMake(idx*self.pointWidth, y2) withColor:self.color andWidth:self.width animated:animated];
    CALayer *back = [BaseLayer backOfLineFrom:CGPointMake((float)(idx-1)*self.pointWidth, y1) to:CGPointMake(idx*self.pointWidth, y2)];
    [self addSublayer:back];
    [self addSublayer:line];
}
- (void)addBackLayer
{
    CAGradientLayer *layer = [[CAGradientLayer alloc] init];
    layer.bounds = self.bounds;
    layer.frame = self.bounds;
    layer.colors = @[(__bridge id)[UIColor colorWithRed:0.79 green:0.59 blue:0.39 alpha:1.00].CGColor, (__bridge id)[UIColor colorWithRed:0.88 green:0.73 blue:0.50 alpha:0.90].CGColor, (__bridge id)[UIColor colorWithRed:0.88 green:0.73 blue:0.50 alpha:0.3].CGColor];
    layer.startPoint = CGPointMake(1, 0);
    layer.endPoint = CGPointMake(1, 1);
    [self addSublayer:layer];
}

- (void)prepareForDraw{
    self.axisAttached.touchBottom = YES;
    for (NSNumber* n in self.data) {
        [self.axisAttached addContainingVal:n.floatValue];
    }
}
@end
