//
//  ProductTableViewCell.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/18.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "ProductTableViewCell.h"

@interface ProductTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *riseButton;
@property (weak, nonatomic) IBOutlet UIButton *fallButton;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UIView *mainView;


@end
@implementation ProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSomeControl];
    // Initialization code
}
- (void)setModel:(ProductModel *)model
{
    _model = model;
    _model = model;
    NSString *title = _model.productName;
    NSString *detail = [NSString stringWithFormat:@"波动盈亏:%.03f元",_model.fluctuations];
    [self setTitleWithTitle:title detail:detail];
    _detail.text = [NSString stringWithFormat:@"%.02f元/手",_model.price];
    
}
- (void)setSomeControl
{
    _mainView.backgroundColor = LCoreCurrent.backgroundColor;
    _riseButton.backgroundColor = LCoreCurrent.riseTextColor;
    _fallButton.backgroundColor = LCoreCurrent.fallTextColor;
    UIFont *font = [UIFont systemFontOfSize:kCellLabelFont];
    _riseButton.titleLabel.font = font;
    _fallButton.titleLabel.font = font;
    [_riseButton setTitleColor:LCoreCurrent.buttonTitleColor forState:UIControlStateNormal];
    [_fallButton setTitleColor:LCoreCurrent.buttonTitleColor forState:UIControlStateNormal];
    
    _title.textColor = LCoreCurrent.labelTextColor;
    _detail.textColor = LCoreCurrent.selectedLineColor;
    _detail.font = [UIFont systemFontOfSize:kCellLabelFont-4];
}
- (void)setTitleWithTitle:(NSString *)title detail:(NSString *)detail
{
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kCellLabelFont-3]}];
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:detail attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kCellLabelFont-5]}];
    [str1 appendAttributedString:str2];
    _title.attributedText = str1;
}
- (IBAction)riseAction:(id)sender {
    if (self.btnsActionBlock) {
        self.btnsActionBlock(0);
    }
}
- (IBAction)fallAction:(id)sender {
    if (self.btnsActionBlock) {
        self.btnsActionBlock(1);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
