//
//  LChartView.m
//  MyTest
//
//  Created by shijian01 on 16/9/22.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "LChartView.h"
@interface LChartView ()<UIScrollViewDelegate>
{
    BOOL isFirstTouch;
    UIView *circle, *lineY;
    double showViewX, showViewY, showViewWidth, showViewHeight;
    double topViewHeight, leftViewWidth, bottomViewHeight;
    UILabel *label1, *label2;
    LineChartDataView *showLineView;
    StockChartDataView *showStockView;
}
/*
 dataPoints:对于真实数据处理之后的CGPoint--用于画填充色
 loadDatas:提取data.json中的数据
 datas:存储数据，用于显示当前点击数据
 ---minValue、maxValue用于计算真实的CGPoint中的y
 minValue:数据中最大的数据
 maxValue:数据中最小的数据
 */
@property (nonatomic, strong)NSMutableArray *dataPoints, *datas;
@property (nonatomic, strong)NSArray *loadDatas;
@property (nonatomic, assign)double minValue, maxValue;
@property (nonatomic, strong)CALayer *backLayer, *lineLayer, *stockLayer, *linesLayer;
@end
@implementation LChartView
/*
 初始化一些数据
 */
-(void)initWithFrame:(CGRect)frame itemWidth:(double)itemWidth leftLabelCount:(NSInteger)leftLabelCount bottomLabelCount:(NSInteger)bottomLabelCount leftViewWidth:(double)leftViewWith bottomViewHeight:(double)bottomViewHight isStock:(BOOL)isStock isGradient:(BOOL)isGradient
{
    self.frame = frame;//行情图的superView的frame
    _item_width = itemWidth;//每个行情所占宽度
    _isGradient = isGradient;//折线图是否显示渐变背景
    topViewHeight = 25;//topView高度
    leftViewWidth = leftViewWith;//leftView宽度
    bottomViewHeight = bottomViewHight;//bottomView高度
    _leftLabelCount = leftLabelCount;//左视图共划分为几段
    _bottomLabelCount = bottomLabelCount;//bottomView共划分成几段，当前暂未用到
   /*
    行情图frame
    */
    _mainOriginX = leftViewWith;
    _mainOriginY = topViewHeight;
    _mainSizeWidth = frame.size.width -leftViewWith;
    _mainSizeHeight = frame.size.height - topViewHeight;
    [self _init];
    self.isStock = isStock;
}
/*
 初始化views
 */
- (void)_init{
    //图
    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(_mainOriginX, _mainOriginY, _mainSizeWidth, _mainSizeHeight)];
    _mainView.bounces = NO;
    _mainView.delegate = self;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.showsVerticalScrollIndicator = NO;
    _mainView.contentSize = CGSizeMake(_mainSizeWidth, _mainSizeHeight);
    //底部坐标图
    _bottomView = [LChartBottomView initWithDatas:@[@"08:00", @"09:00", @"10:00", @"11:00", @"12:00"] frame:CGRectMake(0, _mainSizeHeight-bottomViewHeight, _mainSizeWidth, bottomViewHeight)];
    [_mainView addSubview:_bottomView];
    //左边坐标图
    _leftView = [LChartLeftView initWithFrame:CGRectMake(0, topViewHeight, leftViewWidth,_mainSizeHeight-bottomViewHeight) maxValue:_maxValue minValue:_minValue itemCount:_leftLabelCount];
    //顶部显示图
    _topView = [LChartTopView viewWithframe:CGRectMake(0, 0, self.frame.size.width-10, topViewHeight)];
    [self addSubview:_mainView];
    [self addSubview:_leftView];
    [self addSubview:_topView];
    
    [self _initSubShowViews];
    self.backgroundColor = [UIColor clearColor];
    _leftView.backgroundColor = [UIColor clearColor];
    _bottomView.backgroundColor = [UIColor clearColor];
}
/*
 设置当前图是否为k图
 */
- (void)setIsStock:(BOOL)isStock
{
    _isStock = isStock;
    if (isStock) {
        /*
         k图显示数据View的宽高
         */
        showViewWidth = 140;
        showViewHeight = 60;
    }else
    {
        /*
         折线图显示数据view的宽高
         */
        showViewWidth = 76;
        showViewHeight = 40;
    }
    [self loadData];
}
- (void)setItem_width:(double)item_width
{
    _item_width = item_width;
    [self scaleWidth];
}
/*
 计算图的宽度，重新画图
 */
- (void)scaleWidth {
    _mainSizeWidth = _item_width * _datas.count;
    _mainView.contentSize = CGSizeMake(_mainSizeWidth, _mainSizeHeight);
    _bottomView.frame = CGRectMake(0, _mainSizeHeight-bottomViewHeight, _mainSizeWidth, bottomViewHeight);
    if (_isStock) {
        [self addStockLayer];
    }else
    {
        [self addLineLayer];
    }
}
/*
 初始化显示某个行情的数据View
 */
- (void)_initSubShowViews
{
    if (!lineY) {
        lineY = [[UIView alloc] init];
        lineY.backgroundColor = [UIColor lightGrayColor];
        
    }
    if (!circle) {
        circle = [[UIView alloc] init];
        circle.backgroundColor = [UIColor redColor];
        circle.layer.cornerRadius = 2;
    }
    if (!showStockView) {
        showStockView = [[NSBundle mainBundle] loadNibNamed:@"StockChartDataView" owner:nil options:nil].lastObject;
    }
    if (!showLineView) {
        showLineView = [[NSBundle mainBundle] loadNibNamed:@"LineChartDataView" owner:nil options:nil].lastObject;
    }
    [self addSubview:lineY];
    [self addSubview:circle];
    [self addSubview:showStockView];
    [self addSubview:showLineView];
    [self subShowViewsHidden:YES];
    
}
/*
 是否显示某个行情的数据
 */
- (void)subShowViewsHidden:(BOOL)isHidden
{
    lineY.hidden = isHidden;
    circle.hidden = isHidden;
    if (_isStock) {
       showLineView.hidden = YES;
        showStockView.hidden = isHidden;
    }else
    {
        showStockView.hidden = YES;
        showLineView.hidden = isHidden;
    }
    
    if (isHidden) {
        isFirstTouch = isHidden;
    }
}
/*
 移除显示视图
 */
- (void)removeSubShowViews
{
    [lineY removeFromSuperview];
    [circle removeFromSuperview];
    [showLineView removeFromSuperview];
    [showStockView removeFromSuperview];
}

/*
 加载数据，现在是加载的本地数据
 同时处理datas、minValue、maxValue、mainSizeWidth、顶部显示数据
 */
- (void)loadData{
    [self subShowViewsHidden:YES];
    _minValue = FLT_MAX;
    _maxValue = -FLT_MAX;
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"]];
    NSError* err = nil;
    _loadDatas = (NSArray*)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
    if (!_datas) {
        _datas = [NSMutableArray array];
        
    }else
    {
        [_datas removeAllObjects];
    }
    for (NSArray *data in _loadDatas) {
        if ([data[3] doubleValue] > _maxValue) {
            _maxValue = [data[3] doubleValue];
        }
        if ([data[4] doubleValue] < _minValue) {
            _minValue = [data[4] doubleValue];
        }
        if (_isStock) {
            StockData *d = [StockData setOpen:[data[2] doubleValue] close:[data[5] doubleValue] low:[data[4] doubleValue] high:[data[3] doubleValue] time:[NSString strWithObj:data[0]]];
            [_datas addObject:d];
        }else
        {
            LineData *d = [LineData setData:[data[2] doubleValue] time:[NSString strWithObj:data[0]]];
            [_datas addObject:d];
        }
    }
    [self scaleWidth];
    /*
     设置顶部数据 昨收，今开，最高，最低
     */
    StockData *data = [StockData setOpen:2222.00 close:3333.00 low:_minValue high:_maxValue time:nil];
    _topView.data = data;
    [_leftView setMaxValue:_maxValue minValue:_minValue itemCount:_leftLabelCount];
}
/*
设置画图位置数组dataPoints
 */
- (void)resetDataPointsWithArray:(NSArray *)datas
{
    if (!_dataPoints) {
        _dataPoints = [NSMutableArray array];
    }else
    {
        [_dataPoints removeAllObjects];
    }
    for (int i = 0; i < datas.count; i ++) {
        double f = 0;
        if (_isStock) {
            StockData *data = datas[i];
            f = data.high;
        }else
        {
            LineData *data = datas[i];
            f = data.data;
        }
        float y = (_mainSizeHeight -bottomViewHeight) - [self heightForValue:f];
        float x = i*_item_width;
        [_dataPoints addObject:@[[NSNumber numberWithFloat:x], [NSNumber numberWithFloat:y]]];
    }
}
/*
 当点击事件结束后，若为单击，则显示当前点击行情的数据
 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (touches.count == 1) {
        NSArray *ts = [touches allObjects];
        UITouch *touch = ts.firstObject;
        CGPoint point = [touch locationInView:_mainView];
        float x = point.x;
        if (x <_mainView.contentOffset.x) {
            return;
        }
        NSInteger index = (NSInteger)x/(NSInteger)_item_width;
        if (index>=0 && index < self.datas.count) {
            if (isFirstTouch) {
                [self subShowViewsHidden:NO];
            }
            x = [_dataPoints[index][0] doubleValue]-_mainView.contentOffset.x;
            if (_isStock) {
                x+=_item_width/2.0;
            }
            float y = [_dataPoints[index][1] doubleValue];
            showViewX = (x+leftViewWidth)-showViewWidth/2.0;
            if (showViewX < leftViewWidth) {
                showViewX = x+leftViewWidth;
            }
            if (showViewX > self.bounds.size.width-leftViewWidth-20-showViewWidth/2.0) {
                showViewX = showViewX-showViewWidth/2.0;
            }
            if (y > showViewHeight) {
                showViewY = y - showViewHeight;
            }else
            {
                showViewY = y;
            }
            CGRect frame = CGRectMake(showViewX, showViewY+topViewHeight, showViewWidth, showViewHeight);
            if (_isStock) {
                StockData *p =self.datas[index];
                [showStockView setTime:p.time open:p.open close:p.close high:p.high low:p.low];
                [self updateView:showStockView frame:frame];
            }else
            {
                LineData *p = self.datas[index];
                [showLineView setTime:p.time data:p.data];
                [self updateView:showLineView frame:frame];
            }
            lineY.frame = CGRectMake(leftViewWidth + x, topViewHeight, 0.5, _mainSizeHeight-bottomViewHeight);
            circle.frame = CGRectMake(leftViewWidth + x - 2, y-2+topViewHeight, 4, 4);
        }
    }
}
/*
 显示视图frame移动时的动画效果
 */
- (void)updateView:(UIView *)view frame:(CGRect)frame
{
    if (isFirstTouch) {
        isFirstTouch = NO;
        view.frame = frame;
    }else
    {
        [UIView animateWithDuration:0.2 animations:^{
            view.frame = frame;
        }];
    }
}
/*
 添加折线图
 */
- (void)addLineLayer
{
    [self resetDataPointsWithArray:_datas];
    [self removeSubLayers];
    [self add_linesLayer];
    if (_isGradient) {
        
        const CGFloat *rgba =CGColorGetComponents(LCoreCurrent.chartBackColor.CGColor);
        if (CGColorGetNumberOfComponents(LCoreCurrent.chartBackColor.CGColor) == 4) {
            CGFloat R = rgba[0];
            CGFloat G = rgba[1];
            CGFloat B = rgba[2];
            NSArray *colors = @[[UIColor colorWithRed:R green:G blue:B alpha:0.9],
                                [UIColor colorWithRed:R green:G blue:B alpha:0.6],
                                [UIColor colorWithRed:R green:G blue:B alpha:0.3]
                                ];
            _backLayer = [CALayer backGradientWithPoints:_dataPoints height:_mainSizeHeight- bottomViewHeight width:_mainSizeWidth colors:colors];
        }
        [_mainView.layer addSublayer:_backLayer];
    }
    _lineLayer = [CALayer lineWithPoints:_dataPoints lineColor:LCoreCurrent.selectedLineColor height:_mainSizeHeight- bottomViewHeight width:_mainSizeWidth isGradient:_isGradient isShowFillColor:NO fillColor:[UIColor brownColor]];
    [_mainView.layer addSublayer:_lineLayer];
}
/*
 添加k图
 */
- (void)addStockLayer
{
    [self resetDataPointsWithArray:_datas];
    [self removeSubLayers];
    [self add_linesLayer];
    _stockLayer = [CALayer layer];
    for (int index = 0; index < _datas.count; index ++) {
        StockData *data = _datas[index];
        //颜色
        UIColor *color = LCoreCurrent.riseColor;
        if (index != 0) {
            StockData *preData = _datas[index-1];
            if (preData.open < data.open) {
                color = LCoreCurrent.fallColor;
            }
        }
        //竖线
        double height = _mainSizeHeight-bottomViewHeight;
        double x = index*_item_width+_item_width/2;
        double y1 = height-[self heightForValue:data.high];
        double y2 = height-[self heightForValue:data.low];
        CALayer *line = [CALayer layerOfLineFrom:CGPointZero to:CGPointMake(0, y1-y2+1) withColor:color andWidth:1];
        line.position = CGPointMake(x, y2);
        if (data.open > data.close) {
            y1 = height - [self heightForValue:data.open];
            y2 = height - [self heightForValue:data.close];
        }else{
            y1 = height - [self heightForValue:data.close];
            y2 = height - [self heightForValue:data.open];
        }
        //Rectangle绘制矩形
        double rectangleWidth = 8;
        if (_item_width <= rectangleWidth+2) {
            rectangleWidth = _item_width-2;
        }
        CALayer *rectangleLayer = [CALayer layerOfLineFrom:CGPointZero to:CGPointMake(0, y1-y2+1) withColor:color andWidth:rectangleWidth];
        rectangleLayer.position =CGPointMake(x, y2);
        [_stockLayer addSublayer:rectangleLayer];
        [_stockLayer addSublayer:line];
    }
    [_mainView.layer addSublayer:_stockLayer];
    
}
//背景线
- (void)add_linesLayer
{
    _linesLayer = [CALayer layer];
    for (int i = 1; i <= _leftLabelCount; i ++) {
        double y = (_mainSizeHeight-bottomViewHeight)/_leftLabelCount *i;
        CALayer *layer = [CALayer layerOfLineFrom:CGPointMake(0, y) to:CGPointMake(_mainSizeWidth, y) withColor:LCoreCurrent.chartLinesColor andWidth:0.5];
        [_linesLayer addSublayer:layer];
    }
    [_mainView.layer addSublayer:_linesLayer];
}
//移除layers
- (void)removeSubLayers
{
    if (_backLayer) {
        [_backLayer removeFromSuperlayer];
        _backLayer = nil;
    }
    if (_linesLayer) {
        [_linesLayer removeFromSuperlayer];
        _linesLayer = nil;
    }
    if (_lineLayer) {
        [_lineLayer removeFromSuperlayer];
        _lineLayer = nil;
    }
    if (_stockLayer) {
        [_stockLayer removeFromSuperlayer];
        _stockLayer = nil;
    }
}
/*
 将真实数据变转化为相应的坐标元素
 */
- (CGFloat)heightForValue:(CGFloat)value {
    if (_maxValue-_minValue < 0.01) {
        return 0;
    }
    return (value-_minValue) * (_mainSizeHeight - bottomViewHeight)/ (_maxValue-_minValue);
}
/*
 scrollView delegate
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self subShowViewsHidden:YES];
}
@end
