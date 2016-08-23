//
//  LButton.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/18.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "LButton.h"

@implementation LButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = 5;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = LCoreCurrent.buttonBorderColor.CGColor;
    [self setTitleColor:LCoreCurrent.buttonTitleColor forState:UIControlStateNormal];
}
@end
