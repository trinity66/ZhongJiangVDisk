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
    self.backgroundColor = LCoreCurrent.detailBackColor;
    [self setSegmentC];
}
- (void)setSelfFrame:(CGRect)frame
{
    self.frame = frame;
    if (!_cS) {
        _cS = [[ChartViewSuper alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-40)];
        [self addSubview:_cS];
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
- (void)setSegSelectedIndex:(NSInteger)segSelectedIndex
{
    _segmentC.selectedSegmentIndex = segSelectedIndex;
    [self handleSelf];
}
- (IBAction)segment_change_valued:(id)sender {
    [self handleSelf];
}
- (void)handleSelf
{
    [self.cS setChartViewWithIndex:_segmentC.selectedSegmentIndex];
    _segBottomLineLeftX.constant = kScreenWidth/5.0*_segmentC.selectedSegmentIndex;
}
@end
