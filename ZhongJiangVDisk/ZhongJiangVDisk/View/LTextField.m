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
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5;
    self.textColor = [Core shareCore].cellTextColor;
    self.layer.borderColor = [Core shareCore].textFieldBorderColor.CGColor;
    self.backgroundColor = [Core shareCore].textFieldBackColor;
}
- (void)setDefalutColor
{
    self.textColor = [Core shareCore].cellTextColor;
    self.layer.borderColor = [Core shareCore].textFieldBorderColor.CGColor;
    self.backgroundColor = [Core shareCore].textFieldBackColor;
}
- (void)setEnabledColor
{
    self.textColor = [Core shareCore].cellTextColor;
    self.layer.borderColor = [Core shareCore].selectedLineColor.CGColor;
    self.backgroundColor = [Core shareCore].textFieldBackColor;
}
- (void)setSelectedColor
{
    self.textColor = [Core shareCore].labelTextColor;
    self.layer.borderColor = [Core shareCore].selectedLineColor.CGColor;
    self.backgroundColor = [Core shareCore].textFieldSelectBackColor;
}
@end
