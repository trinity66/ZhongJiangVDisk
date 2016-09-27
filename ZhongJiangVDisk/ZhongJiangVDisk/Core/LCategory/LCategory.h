//
//  LCategory.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/12.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(extend)
- (NSString *)md5;
- (NSString*)base64_encode;
- (NSString*)base64_decode;
+ (NSString*)app_version;
+ (NSString *)stringWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat;
+ (NSString *)className:(Class)_class;
@end

@interface UIImage (extend)
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;
@end

@interface NSDate (extend)
+ (NSDate *)dateWithString:(NSString *)string dateFormat:(NSString *)dateFormat;
@end

@interface UIScrollView (extend)

@end

@interface CALayer (extend)
+ (CALayer *)layerOfLineFrom:(CGPoint)from to:(CGPoint)to withColor:(UIColor*)color andWidth:(CGFloat)width;
+(CALayer *)backGradientWithPoints:(NSArray*)points height:(double)height width:(double)width colors:(NSArray<UIColor *> *)colors;

+(CALayer *)lineWithPoints:(NSArray*)points lineColor:(UIColor *)lineColor height:(double)height width:(double)width isGradient:(BOOL)isGradient isShowFillColor:(BOOL)isShowFillColor fillColor:(UIColor*)fillColor;

@end

@interface UICollectionView(extend)
- (void)registerCellWithNibName:(NSString *)nibName;
- (void)registerHeadWithNibName:(NSString *)nibName;
- (void)registerFootWithNibName:(NSString *)nibName;
@end

@interface UITableView(extend)
- (void)registerCellWithNibName:(NSString *)nibName;
- (id)cellFromNibWithClass:(Class)_class;
- (UITableViewCell *)cellWithStyle:(UITableViewCellStyle)style;

@end
@interface UIView(extend)
- (void)_init;
@end
@interface UITableViewCell(extend)
- (void)_init;
@end
