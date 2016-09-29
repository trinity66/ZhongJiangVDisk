//
//  ProductCell.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/18.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "ProductCell.h"

@interface ProductCell ()
@property (weak, nonatomic) IBOutlet BuyButton *riseButton;
@property (weak, nonatomic) IBOutlet BuyButton *fallButton;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UILabel *detailTwo;


@end
@implementation ProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self _init];
    // Initialization code
}
- (void)_init
{
    _mainView.backgroundColor = LCoreCurrent.backgroundColor;
    UIFont *font = [UIFont systemFontOfSize:kCellLabelFont-3];
    UIColor *backColor = LCoreCurrent.topSegmentColor;
    if (LCoreCurrent.VDiskType == VDiskTypeZhongHui) {
        backColor = [UIColor whiteColor];
    }
    _mainView.layer.borderColor = backColor.CGColor;
    [_riseButton setTite:@"买涨" imageName:@"arrow_up_small" titleColor:LCoreCurrent.riseTextColor imageColor:LCoreCurrent.riseTextColor backColor:backColor font:font];
    [_fallButton setTite:@"买跌" imageName:@"arrow_down_small" titleColor:LCoreCurrent.fallTextColor imageColor:LCoreCurrent.fallTextColor backColor:backColor font:font];
    _title.textColor = LCoreCurrent.cellTextColor;
    _detail.textColor = LCoreCurrent.selectedLineColor;
    _detail.font = [UIFont systemFontOfSize:kCellLabelFont-4];
    _detailTwo.textColor = [UIColor lightGrayColor];
    _detailTwo.font = [UIFont systemFontOfSize:kCellLabelFont-5];
}

- (void)setModel:(ProductModel *)model
{
    _model = model;
    NSString *title = _model.productName;
    NSString *detail = [NSString stringWithFormat:@"波动盈亏:%.03f元",_model.fluctuations];
    [self setTitleWithTitle:title detail:detail];
    _detail.text = [[NSString strWithDoubNum:_model.price] stringByAppendingString:@"元/手"];
}
- (void)setTitleWithTitle:(NSString *)title detail:(NSString *)detail
{
    _title.font = [UIFont systemFontOfSize:kCellLabelFont-3];
    _title.text = title;
    _detailTwo.text = detail;
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
