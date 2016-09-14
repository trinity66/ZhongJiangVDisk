//
//  DetailPositionCell2.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/13.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "DetailPositionCell2.h"

@interface DetailPositionCell2 ()

@property (weak, nonatomic) IBOutlet UILabel *detail1;
@property (weak, nonatomic) IBOutlet LButton *detail2;
@property (weak, nonatomic) IBOutlet LButton *button;

@end
@implementation DetailPositionCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSomeControl];
    // Initialization code
}
- (void)setSomeControl
{
    self.backgroundColor = LCoreCurrent.backgroundColor;
    _button.hidden = YES;
    NSArray *controls = @[_title1, _title2, _detail1, _detail2];
    for (UILabel *label in controls) {
        label.font = [UIFont systemFontOfSize:kCellLabelFont-4];
        label.textColor = LCoreCurrent.cellTextColor;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickButtonAction:(id)sender {
}

@end
