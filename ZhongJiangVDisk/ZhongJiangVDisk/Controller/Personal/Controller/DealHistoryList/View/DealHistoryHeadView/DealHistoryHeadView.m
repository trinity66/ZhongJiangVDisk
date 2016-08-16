//
//  DealHistoryHeadView.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/12.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "DealHistoryHeadView.h"

@implementation DealHistoryHeadView

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
    UIColor *color = [UIColor lightGrayColor];
    _numberOne.layer.borderColor = color.CGColor;
    _numberTwo.layer.borderColor = color.CGColor;
    _numberThree.layer.borderColor = color.CGColor;
}
@end
