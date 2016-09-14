//
//  PositionHead.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/13.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "PositionHead.h"

@interface PositionHead ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet LButton *button;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonHeight;
@end
@implementation PositionHead

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSomeControl];
    // Initialization code
}
- (void)setSomeControl
{
    _button.backgroundColor = LCoreCurrent.buttonBackColor;
    self.backgroundColor = LCoreCurrent.detailBackColor;
    if (LCoreCurrent.VDiskType == VDiskTypeYinHe) {
        _title.font = [UIFont systemFontOfSize:kCellLabelFont-4];
        _titleWidth.constant = 60;
        _buttonHeight.constant = 20;
        self.backgroundColor = LCoreCurrent.topSegmentColor;
    }else
    {
        _title.font = [UIFont systemFontOfSize:kCellLabelFont+2];
        _title.textColor = LCoreCurrent.positionCellTextColor;
    }
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
- (void)setTitle:(NSString *)title detail:(NSString *)detail buttonTitle:(NSString *)buttonTite
{
    _title.text = title;
    if (detail) {
      _detail.text = detail;
    }
    if (buttonTite) {
        [_button setTitle:buttonTite forState:UIControlStateNormal];
    }else
    {
        _button.hidden = YES;
    }
    
    
}

@end
