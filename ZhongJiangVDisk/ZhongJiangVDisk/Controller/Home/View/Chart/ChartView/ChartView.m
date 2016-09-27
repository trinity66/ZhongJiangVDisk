//
//  ChartView.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/16.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "ChartView.h"

@interface ChartView ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentC;
@property (weak, nonatomic) IBOutlet UIView *segBottomLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segBottomLineLeftX;
//@property (nonatomic, strong) HMSegmentedControl *segmentC;

@end
@implementation ChartView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self _init];
}
- (void)_init
{
    self.backgroundColor = LCoreCurrent.detailBackColor;
    [self setSegmentC];
}
- (void)setSelfFrame:(CGRect)frame
{
    self.frame = frame;
    if (!_lChart) {
        _lChart = [[LChartView alloc] init];
        [_lChart initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-40) itemWidth:kItemWidth leftLabelCount:5 bottomLabelCount:4 leftViewWidth:50 bottomViewHeight:20 isStock:NO isGradient:YES];
        [self addSubview:_lChart];
    }
}
#pragma mark 设置segment
- (void)setSegmentC
{
    NSDictionary *defaults = @{
                                   NSFontAttributeName : [UIFont systemFontOfSize:kCellLabelFont-2],
                                   NSForegroundColorAttributeName : LCoreCurrent.cellTextColor,
                                   };
    NSDictionary *selected = @{
                                   NSFontAttributeName : [UIFont systemFontOfSize:kCellLabelFont-2],
                                   NSForegroundColorAttributeName :LCoreCurrent.selectedLineColor,
                                   };
    _segBottomLine.backgroundColor = LCoreCurrent.selectedLineColor;
    _segmentC.backgroundColor = [UIColor clearColor];
    [_segmentC setTitleTextAttributes:defaults forState:UIControlStateNormal];
    [_segmentC setTitleTextAttributes:selected forState:UIControlStateSelected];
    _segmentC.selectedSegmentIndex = 0;
}
- (void)setTopSegSelectedIndex:(NSInteger)topSegSelectedIndex
{
    if (_topSegSelectedIndex != topSegSelectedIndex) {
        _segmentC.selectedSegmentIndex = 0;
        [self handleChart];
    }
    _topSegSelectedIndex = topSegSelectedIndex;
}
- (void)handleChart
{
    _segBottomLineLeftX.constant = kScreenWidth/(_segmentC.numberOfSegments)*_segmentC.selectedSegmentIndex;
    _lChart.isStock = _segmentC.selectedSegmentIndex;
    [_lChart loadData];
}
- (IBAction)segment_change_valued:(id)sender {
    [self handleChart];
}
@end
