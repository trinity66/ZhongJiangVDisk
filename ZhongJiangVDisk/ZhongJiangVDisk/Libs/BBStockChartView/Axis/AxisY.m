//
//  AxisY.m
//  BBChart
//
//  Created by ChenXiaoyu on 15/1/5.
//  Copyright (c) 2015年 ChenXiaoyu. All rights reserved.
//

#import "AxisY.h"
#import <float.h>
#import "BBTheme.h"
#import "BBChartUtils.h"

@implementation AxisY

- (instancetype)init{
    self = [super init];
    if (self) {
        self.minVal = FLT_MAX;
        self.maxVal = -FLT_MAX;
        self.touchBottom = YES;
    }
    return self;
}
-(void)addContainingVal:(CGFloat)val{
    if (self.minVal > val) {
        self.minVal = val;
    }
    if (self.maxVal < val) {
        self.maxVal = val;
    }
}

- (CGFloat)designHight{
    return self.bounds.size.height;
}

- (void)setTouchBottom:(BOOL)touchBottom{
    if (!_touchBottom) {
        return;
    }
    _touchBottom = touchBottom;
}
- (CGFloat)heighForVal:(CGFloat)val{
    CGFloat low = self.minVal;
    CGFloat high = self.maxVal;
    
    if (!self.touchBottom) {
        low -= (high - low) * 0.2;
    }
    if (high - low <= 0.001) {
        return 0;
    }
    return (val - low) * self.designHight /  (high-low) ;
}

- (CGFloat)valForHeigth:(CGFloat)height{
    CGFloat low = self.minVal;
    CGFloat high = self.maxVal;
    
    if (!self.touchBottom) {
        low -= (high - low) * 0.2;
    }
    return height * (high-low) / self.designHight + low;
}

//-(CATextLayer*)textLabel:(NSString*)text{
//    CATextLayer* ret = [[CATextLayer alloc] init];
//    ret.fontSize = 13;
//    ret.string = text;
//    ret.foregroundColor = [UIColor redColor].CGColor;
//    return ret;
//}
-(CGSize)sizeOfText:(NSString*) text andSize:(CGFloat)size{

    CGSize textSize = [BBChartUtils textBoundsForFont:[UIFont systemFontOfSize:size].familyName andSize:size text:text];
    return textSize;
}

-(void)drawAnimated:(BOOL)animated{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CALayer* line = [BaseLayer layerOfLineFrom:CGPointMake(0, 0) to:CGPointMake(0, self.designHight+1) withColor:LCoreCurrent.chartLineColor andWidth:1 animated:NO];
    line.position = CGPointMake(self.bounds.size.width, 0);
    [self addSublayer:line];
    NSUInteger cnt = [BBTheme theme].defYLabelGap;
    CGFloat labelHei = [self sizeOfText:@"abc" andSize:[BBTheme theme].yAxisFontSize].height;
    for (int i = 0; i < cnt; ++i) {
        CGFloat curHei = self.bounds.size.height/(float)cnt*(float)i;
        CALayer* dash = [BaseLayer layerOfLineFrom:CGPointMake(self.bounds.size.width+2-1-5, curHei) to:CGPointMake(self.bounds.size.width, curHei) withColor:LCoreCurrent.chartLineColor andWidth:0.5 animated:animated];
        CGFloat val = [self valForHeigth:height-curHei];
        NSString* lab = [NSString stringWithFormat:@"%.3f", val];
        if (val > 1000) {
            lab = [NSString stringWithFormat:@"%.1f", val];
        }
        CATextLayer* t = [BaseLayer layerOfText:lab withFont:@"Helvetica" fontSize:[BBTheme theme].yAxisFontSize andColor:LCoreCurrent.chartYTextColor];
        t.alignmentMode = kCAAlignmentRight;
        if (i == 0) {
            t.anchorPoint = CGPointZero;
        }else{
            t.anchorPoint = CGPointMake(0, 0.5);
        }
        
        t.position = CGPointMake(0, curHei);
        t.bounds = CGRectMake(0, 0, width-12, labelHei);
        [self addSublayer:t];
        [self addSublayer:dash];
    }
    
}

- (void)redrawAnimated:(BOOL)animated{
    self.sublayers = nil;
    [self drawAnimated:animated];
}
@end