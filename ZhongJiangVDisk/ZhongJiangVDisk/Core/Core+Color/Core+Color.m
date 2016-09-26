//
//  Core+Color.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/11.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "Core+Color.h"

@implementation Core (Color)

- (void)initColors
{
    NSDictionary *dict = [self colorsDictionary][self.VDiskTypeString];
    self.riseColor = [self colorWithArray:dict[@"riseColor"]];
    self.fallColor = [self colorWithArray:dict[@"fallColor"]];
    self.backgroundColor = [self colorWithArray:dict[@"backgroundColor"]];
    self.detailBackColor = [self colorWithArray:dict[@"detailBackColor"]];
    self.detailLightBackColor = [self colorWithArray:dict[@"detailLightBackColor"]];
    self.riseTextColor = [self colorWithArray:dict[@"riseTextColor"]];
    self.fallTextColor = [self colorWithArray:dict[@"fallTextColor"]];
    self.labelTextColor = [self colorWithArray:dict[@"labelTextColor"]];
    self.buttonTitleColor = [self colorWithArray:dict[@"buttonTitleColor"]];
    self.positionCellTextColor = [self colorWithArray:dict[@"positionCellTextColor"]];
    
    self.chartLineColor = [self colorWithArray:dict[@"chartLineColor"]];
    self.chartLinesColor = [self colorWithArray:dict[@"chartLinesColor"]];
    self.chartYTextColor = [self colorWithArray:dict[@"chartYTextColor"]];
    self.chartXTextColor = [self colorWithArray:dict[@"chartXTextColor"]];
    self.chartBackColor = [self colorWithArray:dict[@"chartBackColor"]];
    
    self.selectedLineColor = [self colorWithArray:dict[@"selectedLineColor"]];
    self.tabBarSelectTextColor = [self colorWithArray:dict[@"tabBarSelectTextColor"]];
    self.tabBarTextColor = [self colorWithArray:dict[@"tabBarTextColor"]];
    self.buttonBackColor = [self colorWithArray:dict[@"buttonBackColor"]];
    self.personalTopColor = [self colorWithArray:dict[@"personalTopColor"]];
    
    self.cellTextColor = [self colorWithArray:dict[@"cellTextColor"]];
    self.topSegmentColor = [self colorWithArray:dict[@"topSegmentColor"]];
    self.textFieldBorderColor = [self colorWithArray:dict[@"textFieldBorderColor"]];
    self.textFieldBackColor = [self colorWithArray:dict[@"textFieldBackColor"]];
    self.textFieldSelectBackColor = [self colorWithArray:dict[@"textFieldSelectBackColor"]];
    self.buttonBorderColor = [self colorWithArray:dict[@"buttonBorderColor"]];
}
- (UIColor *)colorWithArray:(NSArray *)array
{
    CGFloat R = [array[0] floatValue];
    CGFloat G = [array[1] floatValue];
    CGFloat B = [array[2] floatValue];
    CGFloat alpha = [array[3] floatValue];
    return [UIColor colorWithRed:R green:G blue:B alpha:alpha];
}
- (NSDictionary *)colorsDictionary
{
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"VDiskTypes" ofType:@"json"]];
    NSError* err = nil;
    NSDictionary *dictionary = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
    return dictionary;
}
- (UIImage *)image_with_color:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
