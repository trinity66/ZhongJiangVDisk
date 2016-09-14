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
@property (weak, nonatomic) IBOutlet UILabel *detail2;
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;

@end
@implementation DetailPositionCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSomeControl];
    // Initialization code
}
- (void)setDatas:(NSArray *)datas{
    _datas = datas;
    _title1.text = [(NSDictionary *)datas[0] allKeys].firstObject;
    _detail1.text = datas[0][_title1.text];
    _title2.text = [(NSDictionary *)datas[1] allKeys].firstObject;
    _detail2.text = datas[1][_title2.text];
}
- (void)setSomeControl
{
    self.backgroundColor = LCoreCurrent.backgroundColor;
    NSArray *controls = @[_title1, _title2, _detail1, _detail2];
    UIFont *font = [UIFont systemFontOfSize:kCellLabelFont-4];
    for (UILabel *label in controls) {
        label.font = font;
        label.textColor = LCoreCurrent.cellTextColor;
    }
    _button.titleLabel.font = font;
    _button.backgroundColor = LCoreCurrent.buttonBackColor;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickButtonAction:(id)sender {
    if (self.btnActionBlock) {
        self.btnActionBlock();
    }
}

@end
