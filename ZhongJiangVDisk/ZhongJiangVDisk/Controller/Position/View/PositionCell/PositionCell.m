//
//  PositionCell.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/13.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "PositionCell.h"

@interface PositionCell ()
@property (weak, nonatomic) IBOutlet UILabel *profitMoney;
@property (weak, nonatomic) IBOutlet UILabel *isBuyRise;
@property (weak, nonatomic) IBOutlet UILabel *buyCount;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *contractMoney;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;
@property (weak, nonatomic) IBOutlet LButton *button;
@end

@implementation PositionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSomeControl];
    // Initialization code
}
- (void)setSomeControl
{
    UIColor *color = LCoreCurrent.cellTextColor;
    _buyCount.textColor = color;
    _productName.textColor = color;
    _contractMoney.textColor = color;
    _arrow.image = [_arrow.image imageWithTintColor:color];
    _button.backgroundColor = LCoreCurrent.buttonBackColor;
    
    UIFont *font = [UIFont systemFontOfSize:kCellLabelFont-4];
    _profitMoney.font = font;
    _productName.font = font;
    _isBuyRise.font = font;
    _buyCount.font = font;
    _profitMoney.font = font;
    _contractMoney.font = font;
    _button.titleLabel.font = font;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(DealHistoryModel *)model
{
    _model = model;
    _profitMoney.text = @"-0.0";
    if ([_profitMoney.text doubleValue]<0) {
        _profitMoney.textColor = LCoreCurrent.fallTextColor;
    }else
    {
         _profitMoney.textColor = LCoreCurrent.riseTextColor;
    }
    if (model.isBuyRise) {
        _isBuyRise.text = @"买涨";
        _isBuyRise.textColor = LCoreCurrent.riseTextColor;
    }else
    {
        _isBuyRise.text = @"买跌";
        _isBuyRise.textColor = LCoreCurrent.fallTextColor;
    }
    _buyCount.text = [NSString stringWithFormat:@"%ld手",(long)model.countNumber];
    _productName.text = model.productName;
    _contractMoney.text = [NSString stringWithFormat:@"%.02lf",model.productModel.contractPrice];
    
}
- (IBAction)buttonAction:(id)sender {
    if (self.btnActionBlock) {
        self.btnActionBlock();
    }
}

@end
