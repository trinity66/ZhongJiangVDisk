//
//  LChartBottomCell.m
//  MyTest
//
//  Created by shijian01 on 16/9/23.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "LChartBottomCell.h"

@interface LChartBottomCell ()
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidth;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineLeft;

@end
@implementation LChartBottomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _line.backgroundColor = LCoreCurrent.chartLineColor;
    _label.textColor = LCoreCurrent.chartXTextColor;
    // Initialization code
}
- (void)setLabelText:(NSString *)text
{
    _label.text = text;
}
- (void)reFrameLeft
{
    _labelLeft.constant = 0;
    _lineLeft.constant = 0;
}

- (void)reFrameWithWidth:(double)width
{
    _labelLeft.constant = (width-_labelWidth.constant)/2.0;
    _lineLeft.constant = (width-1)/2.0;
}
- (void)reFrameRightWithWidth:(double)width
{
    _lineLeft.constant = width-1;
    _labelWidth.constant = width-_labelWidth.constant;
}
@end
