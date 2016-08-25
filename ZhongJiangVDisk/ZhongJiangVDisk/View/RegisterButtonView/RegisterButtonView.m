//
//  RegisterButtonView.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/22.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "RegisterButtonView.h"

@interface RegisterButtonView ()
@property (weak, nonatomic) IBOutlet LButton *codeButton;

@property (weak, nonatomic) IBOutlet UIButton *propertyBtn;
@property (weak, nonatomic) IBOutlet LButton *button;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UILabel *propertyLabel;
@end
@implementation RegisterButtonView

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
    [self setSomeControl];
}
- (void)setSomeControl
{
    UIColor *color = LCoreCurrent.buttonBackColor;
    _codeButton.backgroundColor = color;
    _button.backgroundColor = color;
    _codeLabel.textColor = LCoreCurrent.cellTextColor;
    _propertyLabel.textColor = LCoreCurrent.cellTextColor;
    _codeLabel.font = [UIFont systemFontOfSize:kCellLabelFont];
    _propertyLabel.font = [UIFont systemFontOfSize:kCellLabelFont-4];
    _propertyBtn.titleLabel.font = [UIFont systemFontOfSize:kCellLabelFont-4];
    self.backgroundColor = LCoreCurrent.backgroundColor;
}
- (IBAction)codeButtonAction:(id)sender {
    if (self.btnsActionBlock) {
        self.btnsActionBlock(0);
    }
}
- (IBAction)isAgreeBtnAction:(id)sender {
    if (self.btnsActionBlock) {
        self.btnsActionBlock(1);
    }
}
- (IBAction)propertyBtnAction:(id)sender {
    if (self.btnsActionBlock) {
        self.btnsActionBlock(2);
    }
}
- (IBAction)buttonAction:(id)sender {
    if (self.btnsActionBlock) {
        self.btnsActionBlock(3);
    }
}

@end
