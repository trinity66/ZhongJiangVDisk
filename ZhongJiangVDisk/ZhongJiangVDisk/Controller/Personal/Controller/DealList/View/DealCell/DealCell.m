//
//  DealCell.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/12.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "DealCell.h"

@interface DealCell ()
@property (weak, nonatomic) IBOutlet UILabel *idNumber;
@property (weak, nonatomic) IBOutlet UILabel *balance;
@property (weak, nonatomic) IBOutlet UILabel *kind;
@property (weak, nonatomic) IBOutlet UILabel *product;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UILabel *time;
@end
@implementation DealCell
- (void)awakeFromNib {
    [super awakeFromNib];
    [self _init];
    // Initialization code
}
- (void)_init
{
    [super _init];
    UIColor *color = LCoreCurrent.cellTextColor;
    _idNumber.textColor = color;
    _balance.textColor = color;
    _kind.textColor = color;
    _product.textColor = color;
    _amount.textColor = color;
    _time.textColor = color;
    UIFont *font = [UIFont systemFontOfSize:kCellLabelFont-5];
    _idNumber.font = font;
    _balance.font = font;
    _kind.font = font;
    _product.font = font;
    _amount.font = font;
    _time.font = font;
}
- (void)setModel:(DealModel *)model
{
    _model = model;
    NSString *kindStr;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss +0000"];
    NSDate *date = [NSDate dateWithString:model._id dateFormat:@"yyyy-MM-dd hh:mm:ss +0000"];
    _idNumber.text = [@"交易号：" stringByAppendingString:[NSString stringWithDate:date dateFormat:@"yyyyMMddHHmmss"]];
    _balance.text = [@"余额：" stringByAppendingString:[NSString strWithDoubNum:model.balance]];
    _amount.text = [@"金额：" stringByAppendingString:[NSString strWithDoubNum:model.money]];
    _time.text = [@"时间：" stringByAppendingString:[model.time substringToIndex:19]];
    _product.text = [@"商品：" stringByAppendingString:model.product[@"productName"]];
    switch (model.type) {
        case 100: kindStr = @"充值"; break;
        case 200: kindStr = @"买入"; break;
        case 300: kindStr = @"卖出"; break;
        case 301: kindStr = @"卖出手续费"; break;
        case 400: kindStr = @"提现"; break;
        case 401: kindStr = @"提现手续费"; break;
        case 500: kindStr = @"亏损"; break;
        case 600: kindStr = @"盈利"; break;
        default: break;
    }
    _kind.text = [@"类型：" stringByAppendingString:kindStr];
    if (model.type == 100 || model.type == 300 || model.type == 600) {
        [self setAmountWithNumber:model.money isRise:YES];
    }else
    {
        [self setAmountWithNumber:model.money isRise:NO];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setAmountWithNumber:(double)number isRise:(BOOL)isRise
{
    UIColor *color = LCoreCurrent.fallColor;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"金额："];
    NSString *_number = [NSString strWithDoubNum:number];
    NSString *num = [@"-" stringByAppendingString:_number];
    if (isRise) {
        color = LCoreCurrent.riseTextColor;
        num = [@"+" stringByAppendingString:_number];
    }
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:num attributes:@{NSForegroundColorAttributeName:color}];
    [str appendAttributedString:str2];
    _amount.attributedText = str;
}

@end
