//
//  BaseLayer.m
//  BBChart
//
//  Created by ChenXiaoyu on 15/1/6.
//  Copyright (c) 2015年 ChenXiaoyu. All rights reserved.
//

#import "BaseLayer.h"
#import <UIKit/UIKit.h>

@implementation BaseLayer
-(void)drawAnimated:(BOOL)animated{
    
}
- (void)redrawAnimated:(BOOL)animated{

}
-(void)prepareForDraw{
    
}
+ (CALayer *)layerOfLineFrom:(CGPoint)from to:(CGPoint)to withColor:(UIColor*)color andWidth:(CGFloat)width animated:(BOOL)animated {
    CAShapeLayer *line = [CAShapeLayer layer];
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:from];
    [linePath addLineToPoint:to];
    line.path = linePath.CGPath;
    line.opacity = 1.0;
    line.strokeColor = color.CGColor;
    line.lineWidth = width;
    line.strokeStart = 0;
    if (animated) {
        //绘制线条的动画
        CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        drawAnimation.duration            = 2.0;
        drawAnimation.repeatCount         = 1.0;
        drawAnimation.removedOnCompletion = NO;
        drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        drawAnimation.toValue   = [NSNumber numberWithFloat:10.0f];
        drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [line addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    }
    return line;
}
+(CALayer *)lineWithPoints:(NSArray *)points color:(UIColor *)color height:(float)height width:(float)width animated:(BOOL)animated
{
    //画线
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    for (int index = 0; index < points.count; index ++) {
        NSArray *currentP = points[index];
        CGPoint currentPoint = CGPointMake([currentP[0] doubleValue], [currentP[1] doubleValue]);
        if (index != 0) {
           [bezierPath addLineToPoint:currentPoint];
        }[bezierPath moveToPoint:currentPoint];
    }
    [bezierPath closePath];

    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    shapelayer.fillColor = [UIColor clearColor].CGColor;
    shapelayer.lineCap = kCALineCapRound;
    shapelayer.lineJoin = kCALineCapRound;
    shapelayer.lineWidth = 1.0f;
    shapelayer.strokeStart = 0;
    shapelayer.strokeEnd = 1;
    shapelayer.strokeColor = color.CGColor;
    shapelayer.path = bezierPath.CGPath;
    

    return shapelayer;
}
+(CALayer *)backWithPoints:(NSArray *)points height:(float)height width:(float)width
{
    //绘制渐变色层
    UIBezierPath * path=[[UIBezierPath alloc] init];
    for (int index = 0; index < points.count; index ++) {
        NSArray *currentP = points[index];
        double currentPX = [currentP[0] doubleValue], currentPY = [currentP[1] doubleValue];
        if (index == 0) {
            [path moveToPoint:CGPointMake(0, height)];
        }else
        {
            NSArray *preP = points[index-1];
            double prePX = [preP[0] doubleValue], prePY = [preP[1] doubleValue];
            [path addLineToPoint:CGPointMake(prePX, prePY)];
            [path addLineToPoint:CGPointMake(currentPX, currentPY)];
            [path addLineToPoint:CGPointMake(currentPX, height)];
            [path addLineToPoint:CGPointMake(prePX, height)];
        }
    }
    [path closePath];
    
    CAShapeLayer *arc = [CAShapeLayer layer];
    arc.path =path.CGPath;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, width, height);// self.view.frame;
    gradientLayer.mask=arc;
    NSDictionary *dict = [LCoreCurrent colorsDictionary][LCoreCurrent.VDiskTypeString];
    NSArray *rgba = dict[@"selectedLineColor"];
    CGFloat R = [rgba[0] floatValue];
    CGFloat G = [rgba[1] floatValue];
    CGFloat B = [rgba[2] floatValue];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:R green:G blue:B alpha:0.8].CGColor,
                             (__bridge id)[UIColor colorWithRed:R green:G blue:B alpha:0.2].CGColor,
                             (__bridge id)[UIColor colorWithRed:R green:G blue:B alpha:0.05].CGColor];
    gradientLayer.locations=@[@0.0,@0.5,@1.0];
    
    return gradientLayer;
}
+ (CATextLayer *)layerOfText:(NSString *)text withFont:(NSString*)font fontSize:(CGFloat)fontSize andColor:(UIColor *)color{
    CATextLayer *ret = [[CATextLayer alloc] init];
    ret.string = text;
    ret.font = (__bridge CFTypeRef)(font);
    ret.fontSize = fontSize;
    ret.foregroundColor = color.CGColor;
    ret.contentsScale = [UIScreen mainScreen].scale;
    return ret;
}
@end
