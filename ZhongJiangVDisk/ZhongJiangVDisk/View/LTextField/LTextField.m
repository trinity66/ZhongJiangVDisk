//
//  LTextField.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/18.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "LTextField.h"

@implementation LTextField

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
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5;
    self.font = [UIFont systemFontOfSize:kCellLabelFont];
    self.returnKeyType = UIReturnKeyDone;
    [self setDefalutColor];
}
- (void)setDefalutColor
{
    self.textColor = LCoreCurrent.cellTextColor;
    self.tintColor = LCoreCurrent.cellTextColor;
    self.layer.borderColor = LCoreCurrent.textFieldBorderColor.CGColor;
    self.backgroundColor = LCoreCurrent.textFieldBackColor;
}
- (void)setEnabledColor
{
    self.textColor = LCoreCurrent.cellTextColor;
    self.tintColor = LCoreCurrent.cellTextColor;
    self.layer.borderColor = LCoreCurrent.selectedLineColor.CGColor;
    self.backgroundColor = LCoreCurrent.textFieldBackColor;
}
- (void)setSelectedColor
{
    self.textColor = LCoreCurrent.labelTextColor;
    self.tintColor = LCoreCurrent.labelTextColor;
    self.layer.borderColor = LCoreCurrent.selectedLineColor.CGColor;
    self.backgroundColor = LCoreCurrent.textFieldSelectBackColor;
}
- (void)startLayerColor
{
    self.layer.borderColor = LCoreCurrent.selectedLineColor.CGColor;
}
- (void)finishLayerColor
{
    self.layer.borderColor = LCoreCurrent.textFieldBackColor.CGColor;
}
@end
