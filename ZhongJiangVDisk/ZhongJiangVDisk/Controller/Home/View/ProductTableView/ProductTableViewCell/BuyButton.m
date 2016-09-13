//
//  BuyButton.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/13.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//
#define kImageWidth 25
#import "BuyButton.h"

@implementation BuyButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    double width = self.bounds.size.width;
    return CGRectMake((width-kImageWidth)/2.0, -4, kImageWidth, kImageWidth);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    double width = self.bounds.size.width, height = self.bounds.size.height;
    return CGRectMake(0, kImageWidth-8, width, height-kImageWidth);
}
- (void)setTite:(NSString *)title imageName:(NSString *)imageName titleColor:(UIColor *)titleColor imageColor:(UIColor *)imageColor backColor:(UIColor *)backColor font:(UIFont*)font
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setImage:[[UIImage imageNamed:imageName] imageWithTintColor:imageColor] forState:UIControlStateNormal];
    self.backgroundColor = backColor;
    self.titleLabel.font = font;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
@end
