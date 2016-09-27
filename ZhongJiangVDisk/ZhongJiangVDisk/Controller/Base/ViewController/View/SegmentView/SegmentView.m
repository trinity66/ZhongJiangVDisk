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
    [self _init];
}
- (void)_init
{
    if (LCoreCurrent.VDiskType == VDiskTypeYinHe) {
        _title.textColor = [UIColor whiteColor];
        [_bottom removeFromSuperview];
        _topLabelHeight.constant = 15;
        UIFont *font = [UIFont systemFontOfSize:kCellLabelFont-3];
        _title.font = font;
        _record.font = font;
    }else
    {
        self.backgroundColor = LCoreCurrent.topSegmentColor;
        _bottom.hidden = YES;
        self.title.textColor = LCoreCurrent.cellTextColor;
        self.bottom.backgroundColor = LCoreCurrent.selectedLineColor;
        _title.font = [UIFont systemFontOfSize:kCellLabelFont-4];
        _record.font = [UIFont systemFontOfSize:kCellLabelFont];
    }
}
- (void)setDataWithTitle:(NSString *)title Number:(NSString *)number isRise:(BOOL)isRise
{
    UIColor *color;
    NSString *imageName;
    _title.text = title;
    if (isRise) {
        imageName = @"arrow_up";
    }else
    {
        imageName = @"arrow_down";
    }
    switch (LCoreCurrent.VDiskType) {
        case VDiskTypeYinHe:
        {
            color = [UIColor whiteColor];
            if (isRise) {
                self.backgroundColor = LCoreCurrent.riseTextColor;
            }else
            {
                self.backgroundColor = LCoreCurrent.fallTextColor;
            }
        }
            break;
            
        default:
        {
            if (isRise) {
                color = LCoreCurrent.riseTextColor;
            }else
            {
                color = LCoreCurrent.fallTextColor;
            }
        }
            break;
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:number attributes:@{
                                                                                                                                             NSForegroundColorAttributeName:color
                                                                                                                                             }];
    NSTextAttachment *im = [[NSTextAttachment alloc] init];
    [im setImage:[[UIImage imageNamed:imageName] imageWithTintColor:color]];
    im.bounds = CGRectMake(0, -2, 8, 14);
    NSAttributedString *image = [NSAttributedString attributedStringWithAttachment:im];
    [str appendAttributedString:image];
    _record.attributedText = str;
    
}
@end
