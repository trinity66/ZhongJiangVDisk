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
    _title.textColor = [Core shareCore].positionCellTextColor;
    _button.backgroundColor = [Core shareCore].buttonBackColor;
    self.backgroundColor = [Core shareCore].detailBackColor;
    // Initialization code
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
        color = [Core shareCore].riseTextColor;
        imageName = @"riseRed";
        num = [NSString stringWithFormat:@"+%.02f",number];
    }else
    {
        color = [Core shareCore].fallTextColor;
        imageName = @"fallGreen";
        num = [NSString stringWithFormat:@"-%.02f",number];
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:num attributes:@{
                                                                                                                                                NSForegroundColorAttributeName:color
                                                                                                                                                }];
    NSTextAttachment *im = [[NSTextAttachment alloc] init];
    [im setImage:[UIImage imageNamed:imageName]];
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
