//
//  DetailPositionCell3.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/13.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "DetailPositionCell3.h"

@interface DetailPositionCell3 ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;

@end
@implementation DetailPositionCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    [self _init];
    // Initialization code
}
- (void)_init
{
    [super _init];
    NSArray *controls = @[_title, _detail];
    for (UILabel *label in controls) {
        label.font = [UIFont systemFontOfSize:kCellLabelFont-4];
        label.textColor = LCoreCurrent.cellTextColor;
    }
}
- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    _title.text = [[dict allKeys] firstObject];
    _detail.text = dict[_title.text];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
