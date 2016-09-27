//
//  SelectDataCell.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/15.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "SelectDataCell.h"

@interface SelectDataCell ()
@property (weak, nonatomic) IBOutlet LButton *subtractBtn;
@property (weak, nonatomic) IBOutlet LButton *addBtn;
@end
@implementation SelectDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self _init];
    // Initialization code
}
- (void)_init
{
    [super _init];
    UIColor *color = LCoreCurrent.buttonBackColor;
    _addBtn.backgroundColor = color;
    _subtractBtn.backgroundColor = color;
    _title.textColor = LCoreCurrent.cellTextColor;
    _textField.enabled = NO;
    UIFont *font = [UIFont systemFontOfSize:kCellLabelFont];
    _title.font = font;
    _textField.font = font;
    _textField.enabled = NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)subAction:(id)sender {
    if (self.btnsActionBlock) {
        self.btnsActionBlock(0);
    }
}
- (IBAction)addAction:(id)sender {
    if (self.btnsActionBlock) {
        self.btnsActionBlock(1);
    }
}

@end
