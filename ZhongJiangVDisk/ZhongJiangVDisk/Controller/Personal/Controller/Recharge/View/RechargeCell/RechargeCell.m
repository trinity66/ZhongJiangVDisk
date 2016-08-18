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
    self.backgroundColor = [UIColor clearColor];
    
    // Initialization code
}
- (void)cellIsSelected:(BOOL)selected enabled:(BOOL)enabled
{
    if (enabled) {
        _textField.enabled = YES;
        [_textField setEnabledColor];
    }else
    { 
        _textField.enabled = NO;
        if (selected) {
            [_textField setSelectedColor];
        }else
        {
            [_textField setDefalutColor];
        }
    }
}

@end
