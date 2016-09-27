//
//  ChartView.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/16.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//
#define Float(a) (((NSNumber*)a).floatValue)
#import "ChartViewTwo.h"

@interface ChartViewTwo ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *bottomSeg;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIView *lineSub;
@property (weak, nonatomic) IBOutlet UISegmentedControl *topSeg;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSegHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSegSpace;
@property (nonatomic, assign) NSInteger segSelectedIndex;

@end
@implementation ChartViewTwo

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self _init];
}
- (void)_init
{
    self.backgroundColor = LCoreCurrent.detailBackColor;
    UIColor *color = LCoreCurrent.topSegmentColor;
    self.layer.borderColor = color.CGColor;
    _line.backgroundColor = color;
    _lineSub.backgroundColor = color;
    self.backgroundColor = LCoreCurrent.detailBackColor;
    _title.textColor = LCoreCurrent.cellTextColor;
    _title.font = [UIFont systemFontOfSize:kCellLabelFont-4];
    _topSeg.tintColor = LCoreCurrent.riseColor;
    _bottomSeg.tintColor = LCoreCurrent.riseColor;
}
- (void)setSelfFrame:(CGRect)frame
{
    self.frame = frame;
    double y = _topSegHeight.constant + _topSegSpace.constant;
    if (!_lChart) {
        _lChart = [[LChartView alloc] init];
        [_lChart initWithFrame:CGRectMake(0, y, frame.size.width, frame.size.height-y-_topSegHeight.constant-20) itemWidth:kItemWidth leftLabelCount:5 bottomLabelCount:4 leftViewWidth:50 bottomViewHeight:20 isStock:NO isGradient:YES];
        [self addSubview:_lChart];
    }
}
#pragma mark - AxisDataProvider
- (NSString *)textForIdx:(NSUInteger)idx{
    NSString* ret = nil;
    
    // Too much labels would make them overlapping
        NSDate* curDate = [NSDate date];
        NSDate* date = nil;
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        NSDateComponents* dateComponents = [[NSDateComponents alloc] init];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        // idx - 90, is meaningless for your data.
        [dateComponents setDay:idx-90];
        formatter.dateFormat =  @"MM/dd";;
        date = [calendar dateByAddingComponents:dateComponents toDate:curDate options:0];
        ret = [formatter stringFromDate:date];
    return ret;
}
- (void)setSegSelectedIndex:(NSInteger)segSelectedIndex
{
    _segSelectedIndex = segSelectedIndex;
    _bottomSeg.selectedSegmentIndex = segSelectedIndex;
    _lChart.isStock = segSelectedIndex;
    [_lChart loadData];
}
- (IBAction)topSegChanged:(id)sender {
    self.segSelectedIndex = 0;
}
- (IBAction)bottpmSegChanged:(id)sender {
    self.segSelectedIndex = _bottomSeg.selectedSegmentIndex;
}

@end
