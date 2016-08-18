//
//  SelectDataCell.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/15.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "SelectDataCell.h"

@implementation SelectDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIColor *color = [Core shareCore].buttonBackColor;
    _addBtn.backgroundColor = color;
    _subtractBtn.backgroundColor = color;
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
