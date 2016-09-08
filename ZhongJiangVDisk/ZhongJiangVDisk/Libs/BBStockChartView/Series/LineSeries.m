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

- (void)drawPoint:(NSUInteger)idx animated:(BOOL)animated{
    if (idx == 0 || idx >= self.data.count) {
        if (idx == 0 && LCoreCurrent.VDiskType != VDiskTypeYinHe) {
            [self addBackLayer];
        }
        return;
    }
    CGFloat height = self.bounds.size.height;
    float y1 = height - [self.axisAttached heighForVal:((NSNumber*)self.data[idx-1]).floatValue];
    float y2 = height - [self.axisAttached heighForVal:((NSNumber*)self.data[idx]).floatValue];
    CALayer* line = [BaseLayer layerOfLineFrom:CGPointMake((idx-1)*self.pointWidth, y1) to:CGPointMake(idx*self.pointWidth, y2) withColor:self.color andWidth:self.width animated:animated];
    [self addSublayer:line];
}
- (void)addBackLayer
{
    if (!dataY) {
        dataY = [NSMutableArray array];
    }
    for (int i = 0; i < self.data.count; i ++) {
        float y = self.bounds.size.height - [self.axisAttached heighForVal:((NSNumber*)self.data[i]).floatValue];
        float x = i*self.pointWidth;
        [dataY addObject:@[[NSNumber numberWithFloat:x], [NSNumber numberWithFloat:y]]];
    }
    CALayer* back = [BaseLayer backWithPoints:dataY height:_height];
    [self addSublayer:back];
}

- (void)prepareForDraw{
    self.axisAttached.touchBottom = YES;
    for (NSNumber* n in self.data) {
        [self.axisAttached addContainingVal:n.floatValue];
    }
}
@end
