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
+(CALayer *)backOfLineFrom:(CGPoint)from to:(CGPoint)to
{
    //绘制渐变色层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame =CGRectMake(0, 0, 500, 400) ;// self.view.frame;
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:0.79 green:0.59 blue:0.39 alpha:0.9].CGColor ,
                             (__bridge id)[UIColor colorWithRed:0.79 green:0.59 blue:0.39 alpha:0.4].CGColor,
                             (__bridge id)[UIColor colorWithRed:0.79 green:0.59 blue:0.39 alpha:0.1].CGColor];
    gradientLayer.locations=@[@0.0,@0.5,@1.0];

    UIBezierPath * path=[[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(from.x, from.y)];
    [path addLineToPoint:to];
    [path addLineToPoint:CGPointMake(to.x, 290-64-1)];
    [path addLineToPoint:CGPointMake(from.x, 290-64-1)];
    [path closePath];
    CAShapeLayer *arc = [CAShapeLayer layer];
    arc.path =path.CGPath;
    gradientLayer.mask=arc;
    return gradientLayer;
}
// TODO: when line series is thick, their joint part would leave a small black space, which should be filled
//+ (CALayer *)layerOfConcatLineFrom:(CGPoint)from to:(CGPoint)to withColor:(UIColor*)color andWidth:(CGFloat)width{
//    CAShapeLayer *line = [CAShapeLayer layer];
//    UIBezierPath *linePath = [UIBezierPath bezierPath];
//    [linePath moveToPoint: from];
//    [linePath addLineToPoint:to];
//    line.path = linePath.CGPath;
//    line.fillColor = nil;
//    line.opacity = 1.0;
//    line.strokeColor = color.CGColor;
//    line.lineWidth = width;
//    return line;
//}


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
