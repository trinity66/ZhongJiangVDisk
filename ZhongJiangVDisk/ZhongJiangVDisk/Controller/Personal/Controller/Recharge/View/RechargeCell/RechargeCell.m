//
//  RechargeCell.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/12.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "RechargeCell.h"

@implementation RechargeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
- (void)cellIsSelected:(BOOL)selected enabled:(BOOL)enabled
{
    if (enabled) {
        _textField.enabled = YES;
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.textColor = [Core shareCore].blackColor;
        UIColor *color = [Core shareCore].lightMainColor;
        _textField.layer.borderColor = color.CGColor;
    }else
    { 
        _textField.enabled = NO;
        if (selected) {
            UIColor *color = [Core shareCore].lightMainColor;
            _textField.backgroundColor = color;
            _textField.textColor = [UIColor whiteColor];
            _textField.layer.borderColor = color.CGColor;
        }else
        {
            _textField.backgroundColor = [UIColor whiteColor];
            _textField.textColor = [Core shareCore].blackColor;
            _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        }
    }
}

@end
