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
    [self setSomeControl];
    // Initialization code
}
- (void)setSomeControl
{
    UIColor *color = LCoreCurrent.cellTextColor;
    _idNumber.textColor = color;
    _balance.textColor = color;
    _kind.textColor = color;
    _product.textColor = color;
    _amount.textColor = color;
    _time.textColor = color;
    self.backgroundColor = LCoreCurrent.backgroundColor;
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
    NSDate *date = [formatter dateFromString:model._id];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    _idNumber.text = [NSString stringWithFormat:@"交易号：%@",[formatter stringFromDate:date]];
    _balance.text = [NSString stringWithFormat:@"余额：%.02lf",model.balance];
    _amount.text = [NSString stringWithFormat:@"金额%.02lf",model.money];
    NSString *str = [model.time substringToIndex:19];
    _time.text = [NSString stringWithFormat:@"时间：%@",str];
    str = model.product[@"productName"];
    if (str.length > 0) {
        _product.text = [NSString stringWithFormat:@"商品：%@",str];
    }
    if (model.type == 100 || model.type == 300 || model.type == 600) {
        [self setAmountWithNumber:model.money isRise:YES];
    }else
    {
        [self setAmountWithNumber:model.money isRise:NO];
    }
    switch (model.type) {
        case 100:
           //充值
            kindStr = @"充值";
            break;
        case 200:
           //买入
            kindStr = @"买入";
            break;
        case 300:
            //卖出
            kindStr = @"卖出";
            break;
        case 301:
            //卖出手续费
            kindStr = @"卖出手续费";
            break;
        case 400:
            //提现
            kindStr = @"提现";
            break;
        case 401:
            //提现手续费
            kindStr = @"提现手续费";
            break;
        case 500:
            //亏损
            kindStr = @"亏损";
            break;
        case 600:
            //盈利
            kindStr = @"盈利";
            break;
        default:
            break;
    }
    _kind.text = [NSString stringWithFormat:@"类型：%@",kindStr];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setAmountWithNumber:(double)number isRise:(BOOL)isRise
{
    UIColor *color = LCoreCurrent.fallColor;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"金额："];
    NSString *num = [NSString stringWithFormat:@"-%.02lf",number];
    if (isRise) {
        color = LCoreCurrent.riseTextColor;
        num = [NSString stringWithFormat:@"+%.02lf",number];
    }
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:num attributes:@{NSForegroundColorAttributeName:color}];
    [str appendAttributedString:str2];
    _amount.attributedText = str;
}

@end
