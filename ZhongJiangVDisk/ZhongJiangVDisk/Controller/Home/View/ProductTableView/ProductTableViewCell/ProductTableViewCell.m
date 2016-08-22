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
- (void)setSomeControl
{
    _mainView.backgroundColor = [Core shareCore].backgroundColor;
    _riseButton.backgroundColor = [Core shareCore].riseTextColor;
    _fallButton.backgroundColor = [Core shareCore].fallTextColor;
    UIFont *font = [UIFont systemFontOfSize:kCellLabelFont];
    _riseButton.titleLabel.font = font;
    _fallButton.titleLabel.font = font;
    [_riseButton setTitleColor:[Core shareCore].buttonTitleColor forState:UIControlStateNormal];
    [_fallButton setTitleColor:[Core shareCore].buttonTitleColor forState:UIControlStateNormal];
    
    _title.textColor = [Core shareCore].labelTextColor;
    _detail.textColor = [Core shareCore].selectedLineColor;
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
