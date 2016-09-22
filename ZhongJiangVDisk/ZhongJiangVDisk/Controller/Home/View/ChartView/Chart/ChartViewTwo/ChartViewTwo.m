//
//  ChartView.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/16.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//
#define Float(a) (((NSNumber*)a).floatValue)
#import "ChartViewTwo.h"

@interface ChartViewTwo ()<AxisXLabelProvider>
@property (weak, nonatomic) IBOutlet UISegmentedControl *bottomSeg;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIView *lineSub;

@property (weak, nonatomic) IBOutlet UISegmentedControl *topSeg;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSegHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSegSpace;


@end
@implementation ChartViewTwo

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = LCoreCurrent.detailBackColor;
    [self setSomeControl];
}
- (void)setSelfFrame:(CGRect)frame
{
    self.frame = frame;
    double y = _topSegHeight.constant + _topSegSpace.constant;
    if (!_cS) {
        _cS = [[ChartViewSuper alloc] initWithFrame:CGRectMake(0, y, frame.size.width, frame.size.height-y-_topSegHeight.constant)];
        [self addSubview:_cS];
    }
}
- (void)setSomeControl
{
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
- (IBAction)topSegChanged:(id)sender {
}
- (IBAction)bottpmSegChanged:(id)sender {
    [self.cS setChartViewWithIndex:_bottomSeg.selectedSegmentIndex];
}
@end
