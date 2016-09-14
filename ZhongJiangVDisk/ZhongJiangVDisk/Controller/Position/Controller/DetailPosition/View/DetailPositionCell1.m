//
//  DetailPositionCell1.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/13.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "DetailPositionCell1.h"

@interface DetailPositionCell1 ()

@property (weak, nonatomic) IBOutlet UILabel *detail;

@end
@implementation DetailPositionCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSomeControl];
    // Initialization code
}
- (void)setSomeControl
{
    self.backgroundColor = LCoreCurrent.backgroundColor;
    NSArray *controls = @[_title, _detail];
    for (UILabel *label in controls) {
        label.font = [UIFont systemFontOfSize:kCellLabelFont-4];
        label.textColor = LCoreCurrent.cellTextColor;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end