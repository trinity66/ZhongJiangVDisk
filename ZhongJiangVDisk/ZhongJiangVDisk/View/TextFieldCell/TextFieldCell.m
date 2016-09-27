//
//  TextFieldCell.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/12.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "TextFieldCell.h"

@implementation TextFieldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self _init];
    // Initialization code
}
- (void)_init
{
    [super _init];
    _title.textColor = LCoreCurrent.cellTextColor;
    _title.font = [UIFont systemFontOfSize:kCellLabelFont];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
