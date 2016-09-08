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

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chartHeight;
@property (weak, nonatomic) IBOutlet UISegmentedControl *topSeg;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *chartViewSuper;
@property (nonatomic) NSArray* chartData;
@property (nonatomic, strong) BBChartView *chartView;

@end
@implementation ChartViewTwo

-(void)awakeFromNib
{
    [super awakeFromNib];
    UIColor *color = LCoreCurrent.topSegmentColor;
    self.layer.borderColor = color.CGColor;
    _line.backgroundColor = color;
    _lineSub.backgroundColor = color;
    self.backgroundColor = LCoreCurrent.detailBackColor;
    _title.textColor = LCoreCurrent.cellTextColor;
    _title.font = [UIFont systemFontOfSize:kCellLabelFont-4];
    _topSeg.tintColor = LCoreCurrent.riseColor;
    _bottomSeg.tintColor = LCoreCurrent.riseColor;
    _chartViewSuper.backgroundColor = LCoreCurrent.detailBackColor;
    [BBTheme theme].barBorderColor = [UIColor clearColor];
    [BBTheme theme].xAxisFontSize = 11;
    [self loadData];
    [self set_chartView];
}
- (void)loadData{
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"]];
    NSError* err = nil;
    _chartData = (NSArray*)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
}
#pragma mark 设置分时图
- (void)set_chartView
{
    [_chartView removeFromSuperview];
    _chartView = nil;
    if (!_chartView) {
        _chartViewSuper.backgroundColor = LCoreCurrent.detailBackColor;
        _chartView = [[BBChartView alloc] initWithFrame:CGRectMake(0, 36, kScreenWidth-30, _chartViewSuper.bounds.size.height-36)];
        _chartView.userInteractionEnabled = YES;
        [self.chartViewSuper addSubview:_chartView];
        [BBTheme theme].barBorderColor = [UIColor clearColor];
        [BBTheme theme].xAxisFontSize = 11;
    }
    Area* areaup = [[Area alloc] init];
    areaup.bottomAxis.labelProvider = self;
    NSInteger index = _bottomSeg.selectedSegmentIndex;
    if (index == 0) {
        LineSeries* line = [[LineSeries alloc] init];
        line.color = LCoreCurrent.selectedLineColor;
        line.height = _chartHeight.constant;
        [areaup addSeries:line];
        for (NSArray* arr in _chartData) {
            [line addPoint:(Float(arr[4]) + Float(arr[3]))/2];
        }
    }else {// if (index == 1)
        StockSeries* stock = [[StockSeries alloc] init];
        [areaup addSeries:stock];
        for (NSArray* arr in _chartData) {
            [stock addPointOpen:Float(arr[2]) close:Float(arr[5]) low:Float(arr[4]) high:Float(arr[3])];
        }
    }
    [self.chartView addArea:areaup];
    [self.chartView drawAnimated:YES];
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
    [self set_chartView];
}
@end
