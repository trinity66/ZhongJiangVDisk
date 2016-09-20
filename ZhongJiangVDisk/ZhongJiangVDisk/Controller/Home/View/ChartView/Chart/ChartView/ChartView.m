//
//  ChartView.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/16.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "ChartView.h"

@interface ChartView ()

@property (weak, nonatomic) IBOutlet UIView *segmentSuper;
@property (nonatomic, strong) HMSegmentedControl *segmentC;

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
    [self addSegmentC];
}
- (void)setSelFrame:(CGRect)frame
{
    self.frame = frame;
    if (!_cS) {
        _cS = [[ChartViewSuper alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-40)];
        [self addSubview:_cS];
    }
}
#pragma mark 设置segment
- (void)addSegmentC
{
    if (_segmentC == nil) {
        NSDictionary *defaults = @{
                                   NSFontAttributeName : [UIFont systemFontOfSize:kCellLabelFont-2],
                                   NSForegroundColorAttributeName : LCoreCurrent.cellTextColor,
                                   };
        NSDictionary *selected = @{
                                   NSFontAttributeName : [UIFont systemFontOfSize:kCellLabelFont-2],
                                   NSForegroundColorAttributeName :LCoreCurrent.selectedLineColor,
                                   };
        _segmentC = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, -10, kScreenWidth, 35)];
        [_segmentSuper addSubview:_segmentC];
        _segmentSuper.backgroundColor = LCoreCurrent.detailBackColor;
        _segmentC.selectionIndicatorHeight = 1.5;
        _segmentC.titleTextAttributes = defaults;
        _segmentC.selectedTitleTextAttributes = selected;
        [_segmentC addTarget:self action:@selector(segment_change_valued:) forControlEvents:UIControlEventValueChanged];
        
        _segmentC.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        _segmentC.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentC.backgroundColor = LCoreCurrent.detailBackColor;
        _segmentC.selectionIndicatorColor = LCoreCurrent.selectedLineColor;
        _segmentC.sectionTitles = @[@"分时线", @"五分", @"十五分", @"三十分", @"一小时"];
        
    }
}
- (void)segment_change_valued:(HMSegmentedControl *)segmentC
{
    [self.cS setChartViewWithIndex:segmentC.selectedSegmentIndex];
}
@end
