//
//  DealHistoryHeadView.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/12.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "DealHistoryHeadView.h"

@interface DealHistoryHeadView ()
@property (weak, nonatomic) IBOutlet UILabel *titleOne;
@property (weak, nonatomic) IBOutlet UILabel *titleTwo;
@property (weak, nonatomic) IBOutlet UILabel *titleThree;

@end
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
    self.backgroundColor = LCoreCurrent.backgroundColor;
    UIColor *color = LCoreCurrent.cellTextColor;
    _titleOne.textColor = color;
    _titleTwo.textColor = color;
    _titleThree.textColor = color;
    _tfOne.textColor = color;
    _tfTwo.textColor = color;
    _tfThree.textColor = color;
    _tfOne.enabled = NO;
    _tfTwo.enabled = NO;
    _tfOne.enabled = NO;
}
@end
