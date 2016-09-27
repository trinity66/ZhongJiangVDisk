//
//  DealHistoryCell.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/12.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "DealHistoryCell.h"

@interface DealHistoryCell ()
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@end
@implementation DealHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self _init];
    // Initialization code
}
- (void)_init
{
    UIColor *color = LCoreCurrent.cellTextColor;
    _title.textColor = color;
    _time.textColor = color;
    _detail.textColor = color;
    _money.textColor = color;
    UIFont *font = [UIFont systemFontOfSize:kCellLabelFont-4];
    _title.font = font;
    _time.font = font;
    _detail.font = font;
    _money.font = font;
}
- (void)setModel:(DealHistoryModel *)model
{
    _model = model;
    NSString *str = [model.time substringToIndex:10];
    _time.text = [NSString stringWithFormat:@"%@",str];
    _title.text = model.productName;
    _money.text = [NSString stringWithFormat:@"%.02lf",model.money];
    [self setDetailWithNumber:model.countNumber isRise:model.isBuyRise];
}
- (void)setDetailWithNumber:(NSInteger)num isRise:(BOOL)isRise
{
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld手 ",(long)num]];
    NSMutableAttributedString *str2;
    if (isRise) {
        str2 = [[NSMutableAttributedString alloc] initWithString:@"买涨" attributes:@{NSForegroundColorAttributeName:LCoreCurrent.riseTextColor}];
    }else
    {
        str2 = [[NSMutableAttributedString alloc] initWithString:@"买跌" attributes:@{NSForegroundColorAttributeName:LCoreCurrent.fallTextColor}];
    }
    [str1 appendAttributedString:str2];
    _detail.attributedText = str1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
