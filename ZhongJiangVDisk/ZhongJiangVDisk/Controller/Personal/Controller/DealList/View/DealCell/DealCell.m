//
//  DealCell.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/12.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "DealCell.h"

@implementation DealCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setAmountWithNumber:(double)number isRise:(BOOL)isRise
{
    UIColor *color = [[Core shareCore] zhongJiangColors][@"riseColor"];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"金额："];
    NSString *num = [NSString stringWithFormat:@"+%.02f",number];
    if (!isRise) {
        color = [[Core shareCore] zhongJiangColors][@"fallColor"];
        num = [NSString stringWithFormat:@"-%.02f",number];
        _kind.text = @"类型：亏损";
    }else
    {
        _kind.text = @"类型：盈利";
    }
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:num attributes:@{NSForegroundColorAttributeName:color}];
    [str appendAttributedString:str2];
    _amount.attributedText = str;
}

@end
