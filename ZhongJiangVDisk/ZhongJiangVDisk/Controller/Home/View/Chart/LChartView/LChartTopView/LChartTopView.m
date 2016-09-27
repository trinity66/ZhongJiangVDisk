//
//  LChartTopView.m
//  MyTest
//
//  Created by shijian01 on 16/9/23.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "LChartTopView.h"

@interface LChartTopView ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *scaleSeg;
@property (weak, nonatomic) IBOutlet UILabel *scaleLabel;
@property (weak, nonatomic) IBOutlet UILabel *lable1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@end
@implementation LChartTopView
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self _init];
}
- (void)_init
{
    _scaleSeg.tintColor = LCoreCurrent.selectedLineColor;
    UIColor *color = LCoreCurrent.chartXTextColor;
    _scaleLabel.textColor = color;
    _label2.textColor = color;
    _lable1.textColor = color;
    UIFont *font = [UIFont systemFontOfSize:kCellLabelFont-5];
    _scaleLabel.font = font;
    _lable1.font = font;
    _label2.font = font;
}
- (IBAction)segChanged:(id)sender {
    if (self.btnsActionBlock) {
        self.btnsActionBlock(_scaleSeg.selectedSegmentIndex);
    }
}
+(LChartTopView *)viewWithframe:(CGRect)frame
{
    LChartTopView *view = [[NSBundle mainBundle] loadNibNamed:@"LChartTopView" owner:nil options:nil].lastObject;
    view.frame = frame;

    return view;
}
- (void)setData:(StockData *)data
{
    _data = data;
    _lable1.text = [NSString stringWithFormat:@"昨收：%.02lf 最高：%.02lf", data.close, data.high];
    _label2.text = [NSString stringWithFormat:@"今开：%.02lf 最低：%.02lf", data.open, data.low];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
