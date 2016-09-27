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
    _textField.enabled = NO;
    _textField.textAlignment = NSTextAlignmentCenter;
    // Initialization code
}


@end
