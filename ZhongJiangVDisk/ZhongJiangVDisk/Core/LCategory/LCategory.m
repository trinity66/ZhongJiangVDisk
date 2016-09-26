//
//  LCategory.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/12.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "LCategory.h"
#import <CocoaSecurity/CocoaSecurity.h>

@implementation NSString (extend)
- (NSString *)md5
{
    CocoaSecurityResult* e = [CocoaSecurity md5:self];
    return e.hexLower;
}

- (NSString *)base64_encode
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    CocoaSecurityEncoder* e = [[CocoaSecurityEncoder alloc] init];
    return [e base64:data];
}

- (NSString *)base64_decode
{
    CocoaSecurityDecoder* e = [[CocoaSecurityDecoder alloc] init];
    NSString* ret = [[NSString alloc] initWithData:[e base64:self] encoding:NSUTF8StringEncoding];
    return ret;
}
+ (NSString *)app_version
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [info objectForKey:@"CFBundleShortVersionString"];
    //NSLog(@"appver:%@",version);
    return version;
}
+ (NSString *)stringWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    return [formatter stringFromDate:date];
}
@end



@implementation UIImage (extend)
- (UIImage *)imageWithTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}
@end


@implementation NSDate (extend)
+ (NSDate *)dateWithString:(NSString *)string dateFormat:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    return [formatter dateFromString:string];
}
@end

@implementation UIScrollView (extend)
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesCancelled:touches withEvent:event];
    [super touchesCancelled:touches withEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}
@end

@implementation CALayer (extend)
+ (CALayer *)layerOfLineFrom:(CGPoint)from to:(CGPoint)to withColor:(UIColor*)color andWidth:(CGFloat)width
{
    CAShapeLayer *line = [CAShapeLayer layer];
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:from];
    [linePath addLineToPoint:to];
    line.path = linePath.CGPath;
    line.opacity = 1.0;
    line.strokeColor = color.CGColor;
    line.lineWidth = width;
    line.strokeStart = 0;
    return line;
}
+(CALayer *)lineWithPoints:(NSArray*)points lineColor:(UIColor *)lineColor height:(double)height width:(double)width isGradient:(BOOL)isGradient isShowFillColor:(BOOL)isShowFillColor fillColor:(UIColor*)fillColor
{
    //画线
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    //(有渐变背景)or(无渐变背景&&不需填充背景)，所以只划线即可
    if (isGradient || (!isGradient && !isShowFillColor)) {
        shapelayer.fillColor = [UIColor clearColor].CGColor;
        for (int index = 0; index < points.count; index ++) {
            NSArray *currentP = points[index];
            CGPoint currentPoint = CGPointMake([currentP[0] doubleValue], [currentP[1] doubleValue]);
            if (index != 0) {
                [bezierPath addLineToPoint:currentPoint];
            }[bezierPath moveToPoint:currentPoint];
        }
        [bezierPath closePath];
    }else if (isShowFillColor)
    {
        //无渐变背景&&需填充背景
        shapelayer.fillColor = fillColor.CGColor;
        for (int index = 0; index < points.count; index ++) {
            NSArray *currentP = points[index];
            CGPoint currentPoint = CGPointMake([currentP[0] doubleValue], [currentP[1] doubleValue]);
            if (index == 0) {
                [bezierPath moveToPoint:CGPointMake(0, height)];
            }
            [bezierPath addLineToPoint:currentPoint];
            if (index == points.count-1) {
                [bezierPath addLineToPoint:CGPointMake(currentPoint.x, height)];
                [bezierPath addLineToPoint:CGPointMake(0, height)];
            }
        }
        [bezierPath closePath];
    }
    shapelayer.lineCap = kCALineCapRound;
    shapelayer.lineJoin = kCALineCapRound;
    shapelayer.lineWidth = 1.0f;
    shapelayer.strokeStart = 0;
    shapelayer.strokeEnd = 1;
    shapelayer.strokeColor = lineColor.CGColor;
    shapelayer.path = bezierPath.CGPath;
    
    return shapelayer;
}
+(CALayer *)backGradientWithPoints:(NSArray*)points height:(double)height width:(double)width colors:(NSArray<UIColor *> *)colors
{
    //绘制渐变色层
    height = height;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame =CGRectMake(0, 0, width, height) ;// self.view.frame;
    
    NSMutableArray *backColors = [NSMutableArray array];
    NSMutableArray *locations = [NSMutableArray array];
    for (int i = 0; i < colors.count; i ++) {
        [backColors addObject:(__bridge id)colors[i].CGColor];
        [locations addObject:@(1.0/(float)colors.count*i)];
    }
    gradientLayer.colors = backColors;
    gradientLayer.locations = locations;
    
    
    //    gradientLayer.locations=@[@0.0,@0.5,@1.0];
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
    gradientLayer.mask=arc;
    return gradientLayer;
}

@end














