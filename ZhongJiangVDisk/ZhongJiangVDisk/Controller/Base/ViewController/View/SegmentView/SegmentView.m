//
//  SegmentView.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/11.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "SegmentView.h"

@interface SegmentView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLabelHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineHeight;

@end
@implementation SegmentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    [super awakeFromNib];
    if (LCoreCurrent.VDiskType == VDiskTypeYinHe) {
        [self setSomeControlTwo];
    }else
    {
      [self setSomeControl];
    }
    
}
- (void)setSomeControlTwo
{
    _title.textColor = [UIColor whiteColor];
    [_bottom removeFromSuperview];
    _topLabelHeight.constant = 15;
    UIFont *font = [UIFont systemFontOfSize:kCellLabelFont-3];
    _title.font = font;
    _record.font = font;
}
- (void)setSomeControl
{
    self.backgroundColor = LCoreCurrent.topSegmentColor;
    self.title.textColor = LCoreCurrent.cellTextColor;
    self.bottom.backgroundColor = LCoreCurrent.selectedLineColor;
    _title.font = [UIFont systemFontOfSize:kCellLabelFont-4];
    _record.font = [UIFont systemFontOfSize:kCellLabelFont];
    
}
- (void)setDataWithTitle:(NSString *)title Number:(double)number isRise:(BOOL)isRise
{
    UIColor *color;
    NSString *imageName;
    _title.text = title;
    switch (LCoreCurrent.VDiskType) {
        case VDiskTypeYinHe:
        {
            color = [UIColor whiteColor];
            if (isRise) {
                self.backgroundColor = LCoreCurrent.riseTextColor;
                imageName = @"riseRed";
            }else
            {
                self.backgroundColor = LCoreCurrent.fallTextColor;
                imageName = @"fallGreen";
    
            }
        }
            break;
            
        default:
        {
            if (isRise) {
                color = LCoreCurrent.riseTextColor;
                imageName = @"riseRed";
            }else
            {
                color = LCoreCurrent.fallTextColor;
                imageName = @"fallGreen";
            }
        }
            break;
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.02f",number] attributes:@{
                                                                                                                                             NSForegroundColorAttributeName:color
                                                                                                                                             }];
    NSTextAttachment *im = [[NSTextAttachment alloc] init];
    [im setImage:[UIImage imageNamed:imageName]];
    im.bounds = CGRectMake(0, -5, 10, 20);
    NSAttributedString *image = [NSAttributedString attributedStringWithAttachment:im];
    [str appendAttributedString:image];
    _record.attributedText = str;
    
}
@end
