//
//  ChartViewSuper.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/20.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "ChartViewSuper.h"
#define Float(a) (((NSNumber*)a).floatValue)
@interface ChartViewSuper ()<AxisXLabelProvider>
@property (nonatomic, strong) Area *areaup;
@property (nonatomic, strong) LineSeries *lineSeries;
@property (nonatomic, strong) StockSeries *stockSeries;
@property (strong, nonatomic) UILabel *label1;
@property (strong, nonatomic) UILabel *label2;

@end
@implementation ChartViewSuper

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (instancetype)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
    if (self) {
        if (!_label1) {
            _label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width-10, 22)];
            _label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 14, frame.size.width-10, 22)];
            UIFont *font = [UIFont systemFontOfSize:kCellLabelFont-5];
            UIColor *color = LCoreCurrent.chartXTextColor;
            _label1.font = font;
            _label2.font = font;
            _label1.textColor = color;
            _label2.textColor = color;
            _label1.textAlignment = NSTextAlignmentRight;
            _label2.textAlignment = NSTextAlignmentRight;
            [self addSubview:_label1];
            [self addSubview:_label2];
        }
        if (!_chartView) {
            _chartView = [[BBChartView alloc] initWithFrame:CGRectMake(0, 36, kScreenWidth-10, frame.size.height-36)];
            [self addSubview:_chartView];
            [BBTheme theme].barBorderColor = [UIColor clearColor];
            [BBTheme theme].xAxisFontSize = 11;
        }
        [self setChartViewWithIndex:0];
    }
    return self;
}
#pragma mark 设置分时图
- (void)setChartViewWithIndex:(NSInteger)index
{
    [self loadData];
    [self setDataWithY:4440.00 t:6666.00 h:8888.00 l:2222.00];
    [_chartView reset];
    _areaup = nil;
    _lineSeries = nil;
    _stockSeries = nil;
    _areaup = [[Area alloc] init];
    _areaup.bottomAxis.labelProvider = self;
    if (index == 0) {
        _lineSeries = [[LineSeries alloc] init];
        _lineSeries.height = self.bounds.size.height-64;
        _lineSeries.color = LCoreCurrent.selectedLineColor;
        [_areaup addSeries:_lineSeries];
        for (NSArray* arr in _chartData) {
            [_lineSeries addPoint:(Float(arr[4]) + Float(arr[3]))/2];
        }
    }else {
        _stockSeries = [[StockSeries alloc] init];
        [_areaup addSeries:_stockSeries];
        for (NSArray* arr in _chartData) {
            [_stockSeries addPointOpen:Float(arr[2]) close:Float(arr[5]) low:Float(arr[4]) high:Float(arr[3])];
        }
    }
    [_chartView addArea:_areaup];
    [_chartView drawAnimated:YES];
}
- (void)setDataWithY:(double)y t:(double)t h:(double)h l:(double)l
{
    _label1.text = [NSString stringWithFormat:@"昨收：%@ 最高：%@",[self strWithData:y], [self strWithData:h]];
    _label2.text = [NSString stringWithFormat:@"今开：%@ 最低：%@",[self strWithData:t], [self strWithData:l]];
}
- (NSString *)strWithData:(double)data
{
    return [NSString stringWithFormat:@"%.02lf",data];
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
- (void)loadData{
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"]];
    NSError* err = nil;
    _chartData = (NSArray*)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
}
@end
