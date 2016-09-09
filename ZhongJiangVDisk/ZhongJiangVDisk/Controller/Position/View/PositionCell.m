//
//  PositionCell.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/12.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "PositionCell.h"

@interface PositionCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet LButton *button;
@end
@implementation PositionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSomeControl];
    // Initialization code
}
- (void)setSomeControl
{
    _title.textColor = LCoreCurrent.positionCellTextColor;
    _button.backgroundColor = LCoreCurrent.buttonBackColor;
    self.backgroundColor = LCoreCurrent.detailBackColor;
    _title.font = [UIFont systemFontOfSize:kCellLabelFont+2];
    _detail.font = [UIFont systemFontOfSize:kCellLabelFont-4];
}
- (IBAction)buttonAction:(id)sender {
    if (self.btnActionBlock) {
        self.btnActionBlock();
    }
}
- (void)setDetailWithNumber:(double)number isRise:(BOOL)isRise
{
    UIColor *color;
    NSString *imageName;
    NSString *num;
    if (isRise) {
        color = LCoreCurrent.riseTextColor;
        imageName = @"arrow_up";
        num = [NSString stringWithFormat:@"+%.02f",number];
    }else
    {
        color = LCoreCurrent.fallTextColor;
        imageName = @"arrow_down";
        num = [NSString stringWithFormat:@"-%.02f",number];
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:num attributes:@{
                                                                                                                                                NSForegroundColorAttributeName:color
                                                                                                                                                }];
    NSTextAttachment *im = [[NSTextAttachment alloc] init];
    [im setImage:[[UIImage imageNamed:imageName] imageWithTintColor:color]];
    im.bounds = CGRectMake(2, -2, 6, 12);
    NSAttributedString *image = [NSAttributedString attributedStringWithAttachment:im];
    [str appendAttributedString:image];
    _detail.attributedText = str;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
