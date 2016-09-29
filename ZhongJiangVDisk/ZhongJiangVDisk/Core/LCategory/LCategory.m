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
+ (NSString *)className:(Class)_class
{
    return [NSString stringWithUTF8String:object_getClassName(_class)];
}
+ (NSString *)strWithDoubNum:(double)doubleNumber
{
    return [NSString stringWithFormat:@"%.02lf",doubleNumber];
}
+ (NSString *)strWithIntNum:(NSInteger)intNumber
{
    return [NSString stringWithFormat:@"%ld",intNumber];
}
+ (NSString *)strWithObj:(id)idObject
{
    return [NSString stringWithFormat:@"%@",idObject];
}
+ (NSString *)phoneHide:(NSString *)phone
{
    if (phone.length == 11) {
        return [NSString stringWithFormat:@"%@****%@",[phone substringToIndex:3], [phone substringFromIndex:7]];
    }
    return phone;
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

@implementation UICollectionView(extend)
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = LCoreCurrent.backgroundColor;
}
- (void)registerCellWithNibName:(NSString *)nibName
{
    [self registerNib:[UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:nibName];
}
- (void)registerHeadWithNibName:(NSString *)nibName
{
    [self registerNib:[UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:nibName];
}
- (void)registerFootWithNibName:(NSString *)nibName
{
    [self registerNib:[UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:nibName];
}

@end

@implementation UITableView(extend)
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = LCoreCurrent.backgroundColor;
}
- (void)registerCellWithNibName:(NSString *)nibName
{
    [self registerNib:[UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]] forCellReuseIdentifier:nibName];
}
- (id)cellFromNibWithClass:(Class)_class
{
    NSString *className = [NSString className:_class];
    id cell = [self dequeueReusableCellWithIdentifier:className];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil].lastObject;
    }
    return cell;
}
- (UITableViewCell *)cellWithStyle:(UITableViewCellStyle)style
{
    NSString *className = [NSString className:[UITableViewCell class]];
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:className];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:className];
        cell.backgroundColor = LCoreCurrent.detailBackColor;
        cell.textLabel.textColor = LCoreCurrent.cellTextColor;
        cell.textLabel.font = [UIFont systemFontOfSize:kCellLabelFont];
        UIView *view = [UIView new];
        view.backgroundColor = LCoreCurrent.selectedLineColor;
        cell.selectedBackgroundView = view;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
@end

@implementation UIView(extend)
- (void)_init
{
    self.backgroundColor = LCoreCurrent.backgroundColor;
}
@end
@implementation UITableViewCell(extend)
- (void)_init
{
    self.backgroundColor = LCoreCurrent.backgroundColor;
}
@end






















