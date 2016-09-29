//
//  StockChartDataView.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/19.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "StockChartDataView.h"

@interface StockChartDataView ()
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *open;
@property (weak, nonatomic) IBOutlet UILabel *close;
@property (weak, nonatomic) IBOutlet UILabel *high;
@property (weak, nonatomic) IBOutlet UILabel *low;

@end
@implementation StockChartDataView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.borderColor = [UIColor redColor].CGColor;
}
- (void)setTime:(NSString *)time open:(double)open close:(double)close high:(double)high low:(double)low
{
    _time.text = time;
    _open.text = [NSString strWithDoubNum:open];
    _close.text = [NSString strWithDoubNum:close];
    _high.text = [NSString strWithDoubNum:high];
    _low.text = [NSString strWithDoubNum:low];
}
@end
