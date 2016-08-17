//
//  ChartView.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/16.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//
#define Float(a) (((NSNumber*)a).floatValue)
#import "ChartView.h"

@interface ChartView ()<AxisXLabelProvider>
@property (weak, nonatomic) IBOutlet UIView *chartViewSuper;
@property (weak, nonatomic) IBOutlet UIView *segmentSuper;
@property (nonatomic, strong) HMSegmentedControl *segmentC;
@property (nonatomic) NSArray* chartData;
@property (nonatomic, strong) BBChartView *chartView;
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
    [self loadData];
    [self set_segmentC];
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
        _chartView = [[BBChartView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth-10, _chartViewSuper.frame.size.height-45)];
        _chartView.userInteractionEnabled = YES;
        [self.chartViewSuper addSubview:_chartView];
        [BBTheme theme].barBorderColor = [UIColor clearColor];
        [BBTheme theme].xAxisFontSize = 11;
    }
    Area* areaup = [[Area alloc] init];
    areaup.bottomAxis.labelProvider = self;
    NSInteger index = _segmentC.selectedSegmentIndex;
    if (index == 0) {
        LineSeries* line2 = [[LineSeries alloc] init];
        line2.color = [UIColor brownColor];
        [areaup addSeries:line2];
        
        for (NSArray* arr in _chartData) {
            [line2 addPoint:(Float(arr[4]) + Float(arr[3]))/2];
        }
        NSLog(@"%@",line2.data);
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
#pragma mark 设置segment
- (void)set_segmentC
{
    
    if (_segmentC == nil) {
        NSDictionary *defaults = @{
                                   NSFontAttributeName : [UIFont systemFontOfSize:14],
                                   NSForegroundColorAttributeName : [UIColor blackColor],
                                   };
        NSDictionary *selected = @{
                                   NSFontAttributeName : [UIFont systemFontOfSize:14],
                                   NSForegroundColorAttributeName : [[Core shareCore] zhongJiangColors][@"darkMainColor"],
                                   };
        _segmentC = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, _segmentSuper.frame.size.height)];
        [_segmentSuper addSubview:_segmentC];
        _segmentC.selectionIndicatorHeight = 1.5;
        _segmentC.titleTextAttributes = defaults;
        _segmentC.selectedTitleTextAttributes = selected;
        [_segmentC addTarget:self action:@selector(segment_change_valued:) forControlEvents:UIControlEventValueChanged];
        
        _segmentC.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        _segmentC.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentC.backgroundColor = [UIColor clearColor];
        _segmentC.selectionIndicatorColor = [[Core shareCore] zhongJiangColors][@"darkMainColor"];
        _segmentC.sectionTitles = @[@"分时图", @"五分", @"十五分", @"三十分", @"一小时"];
        
    }
}
- (void)segment_change_valued:(HMSegmentedControl *)segmentC
{
    [self set_chartView];
}
@end