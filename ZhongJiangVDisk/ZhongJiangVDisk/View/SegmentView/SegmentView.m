//
//  SegmentView.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/11.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "SegmentView.h"

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
    self.backgroundColor = [[Core shareCore] zhongJiangColors][@"lightGrayColor"];
    self.title.textColor = [[Core shareCore] zhongJiangColors][@"blackColor"];
    self.bottom.backgroundColor = [[Core shareCore] zhongJiangColors][@"darkMainColor"];
    _bottom.hidden = YES;
    // Initialization code
}
- (void)setDataWithTitle:(NSString *)title Number:(double)number isRise:(BOOL)isRise
{
    UIColor *color;
    NSString *imageName;
    _title.text = title;
    if (isRise) {
        color = [Core shareCore].zhongJiangColors[@"riseColor"];
        imageName = @"riseRed";
    }else
    {
        color = [Core shareCore].zhongJiangColors[@"fallColor"];
        imageName = @"fallGreen";
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
