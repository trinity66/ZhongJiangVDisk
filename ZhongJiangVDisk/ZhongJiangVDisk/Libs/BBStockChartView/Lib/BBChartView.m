//
//  BBChartView.m
//  BBChart
//
//  Created by ChenXiaoyu on 15/1/5.
//  Copyright (c) 2015年 ChenXiaoyu. All rights reserved.
//

#import "BBChartView.h"
#import "BarSeries.h"
#import "StockSeries.h"
#import "BBTheme.h"
#define axisYwidth [BBTheme theme].axisYwidth
#define axisXheight [BBTheme theme].axisXHeight
@interface BBChartView(){
    
    float _currentScale;
    float _currentX;
    
    NSMutableArray* _areas;
    NSMutableArray* _areaHeights;
    
    // content chart view
    UIView* _chartView;
    UIView* _toastView;
    UILabel* _toastLabel;
    float showWidth, showHeight, showX, showY;
    BOOL showAnimationed;
    
}
@property (nonatomic, strong)Series *series;
@property (nonatomic, strong) UIView *circle, *lineY;
@property (nonatomic, strong) LineChartDataView *lineDataView;
@property (nonatomic, strong) StockChartDataView *stockDataView;


- (void) redraw;
@end

@implementation BBChartView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self _init];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)_init{
    _areas = [[NSMutableArray alloc] init];
    _areaHeights = [[NSMutableArray alloc] init];
    _chartView = [[UIView alloc] initWithFrame:self.frame];
    self.userInteractionEnabled = YES;
    self.multipleTouchEnabled = YES;
    self.clipsToBounds = YES;
    [self addSubview:_chartView];
    [self _initToastView];
    
//    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
//    [self addGestureRecognizer:panGesture];
//    UIPinchGestureRecognizer* pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
//    [self addGestureRecognizer:pinchGesture];
    
    _scaleFloor = 2;
    _currentScale = 1;
    _currentX = 0;
}

- (void)setScaleFloor:(CGFloat)scaleFloor{
    if (scaleFloor < 1) {
        _scaleFloor = 1;
    }else{
        _scaleFloor = scaleFloor;
    }
}

- (void)_initToastView{
    _toastView = [[UIView alloc] init];
    _toastLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 61.8)];
    UILabel* label = _toastLabel;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"x1.3";
    label.font = [UIFont systemFontOfSize:24];
    label.textColor = [UIColor whiteColor];
    [_toastView addSubview:label];
    _toastView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
    _toastView.layer.cornerRadius = 6;
    _toastView.layer.masksToBounds = YES;
    
}

- (void)setHeighRatio:(CGFloat)heightRatio forArea:(Area *)area{
    if (_areas.count < 2) {
        return;
    }
    CGFloat thisHeight = self.bounds.size.height * heightRatio;
    CGFloat otherHeight = (self.bounds.size.height - thisHeight) / (_areas.count-1);
    [_areas enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Area* cur = obj;
        if (cur == area) {
            _areaHeights[idx] = [NSNumber numberWithFloat:thisHeight];
        }else{
            _areaHeights[idx] = [NSNumber numberWithFloat:otherHeight];
        }
    }];
}
- (void)addArea:(Area *)area{
    [_areas addObject:area];
    [_chartView.layer addSublayer:area];
    [_areaHeights removeAllObjects];
    for (int i = 0; i < _areas.count; ++i) {
        [_areaHeights addObject:[NSNumber numberWithFloat:1.0f/_areas.count*self.bounds.size.height]];
    }
    if (area.theSeries.count == 1) {
        _series = area.theSeries.firstObject;
        if (!_data) {
            _data = [NSMutableArray arrayWithArray:_series.data];
        }
    }
}

- (void)prepareForDraw{
    _toastView.frame = CGRectMake(self.frame.size.width / 2 - axisYwidth, 0, 100, 61.8);
    _chartView.frame = CGRectMake(0, 0, self.frame.size.width * _currentScale, self.frame.size.height);
    CGFloat width = _chartView.layer.bounds.size.width;
    //    CGFloat height = self.layer.bounds.size.height;
    
    CGFloat curY = 0;
    for (int i = 0; i < _areas.count; ++i) {
        Area* area = _areas[i];
        CGFloat curHeight = [(NSNumber*)_areaHeights[i] floatValue];
        area.bounds = CGRectMake(0, 0, width, curHeight);
        area.position = CGPointMake(0, curY);
        area.anchorPoint = CGPointZero;
        [area prepareForDraw];
        curY += curHeight;
    }
    
}
- (void)drawAnimated:(BOOL)animated{
    self.backgroundColor = [UIColor clearColor];
    [self prepareForDraw];
    for (Area* a in _areas) {
        [a drawAnimated:animated];
    }
    //    self.layer.borderWidth = 1;
    //    self.layer.borderColor = [BBTheme defTheme].borderColor.CGColor;
}
- (void)redraw{
    self.backgroundColor = [UIColor clearColor];
    [self prepareForDraw];
    for (Area* a in _areas) {
        [a redrawAnimated:NO];
    }
}

- (void)reset{
    for (Area* area in _areas) {
        [area removeFromSuperlayer];
    }
    [_areas removeAllObjects];
    [_areaHeights removeAllObjects];
}

#pragma mark panGesture
- (void) scaleWith:(float)ratio{
    CGRect newFrame = CGRectMake(_chartView.frame.origin.x, _chartView.frame.origin.y, self.frame.size.width, self.frame.size.height);
    newFrame.size.width = newFrame.size.width * ratio;
    _chartView.frame = newFrame;
    [self redraw];
}
- (void) properPosition{
    CGFloat newX = _chartView.frame.origin.x;
    if (newX > 0) {
        newX = 0;
    }
    if (newX + _chartView.frame.size.width < self.frame.size.width) {
        newX = self.frame.size.width - _chartView.frame.size.width;
    }
    if (newX != _chartView.frame.origin.x) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _chartView.frame = CGRectMake(newX, 0, _chartView.frame.size.width, _chartView.frame.size.height);
        } completion: nil];
    }
    
    
}
// TODO: the axisX should be fixed when dragging the view
- (void) handlePanGesture:(UIPanGestureRecognizer* )recognizer{
    CGPoint trans = [recognizer translationInView:_chartView];
    CGFloat newX = _currentX + trans.x;
    if (newX > 0) {
        newX = 0;
    }
    if (newX + _chartView.frame.size.width < self.frame.size.width) {
        newX = self.frame.size.width - _chartView.frame.size.width;
    }
    //    NSLog(@"newX %f", trans.x);
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        _currentX = newX;
    }
    // make the drag smoother
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _chartView.frame = CGRectMake(newX, 0, _chartView.frame.size.width, _chartView.frame.size.height);
    } completion: ^(BOOL finished){
        
    }];
}
- (void) handlePinchGesture:(UIPinchGestureRecognizer* )recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self addSubview:_toastView];
        return;
    }
    float s = ((int)(recognizer.scale * 10)) / 10.0;
    float scale = s - 1 + _currentScale;
    if (scale > _scaleFloor) {
        scale = _scaleFloor;
    }
    if (scale < 1) {
        scale = 1;
    }
    if (_realTimeScale) {
        // TODO: redraw all the sublayers make the real-time scale stuck, needs to be fixed.
        [self scaleWith:scale];
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [_toastView removeFromSuperview];
        _currentScale = scale;
        [self scaleWith:scale];
        [self properPosition];
        return;
    }
    _toastLabel.text = [NSString stringWithFormat:@"x %.1f", scale];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (touches.count == 1) {
        NSArray *ts = [touches allObjects];
        UITouch *touch = ts.firstObject;
        CGPoint point = [touch locationInView:self];
        float x = point.x-axisYwidth;
        double itemWidth = self.series.pointWidth;
        NSInteger index = (NSInteger)x/itemWidth;
        x = itemWidth*index;
        if (!_lineY) {
            _lineY = [[UIView alloc] init];
            _lineY.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:_lineY];
        }
        if (!_circle) {
            _circle = [[UIView alloc] init];
            _circle.backgroundColor = LCoreCurrent.selectedLineColor;
            _circle.layer.cornerRadius = 2;
            [self addSubview:_circle];
        }
        showAnimationed = YES;
        CGFloat f = 0;
        if (index>=0 && index < self.data.count) {
            id shujv = self.data[index];
            if ([shujv isKindOfClass:[StockSeriesPoint class]]) {
                StockSeriesPoint *p =shujv;
                f = p.high;
                if (!_stockDataView) {
                    showWidth = 140;
                    showHeight = 60;
                    showAnimationed = NO;
                    _stockDataView = [[NSBundle mainBundle] loadNibNamed:@"StockChartDataView" owner:nil options:nil].lastObject;
                    [_stockDataView setTime:@"未知" open:p.open close:p.close high:p.high low:p.low];
                    [self addSubview:_stockDataView];
                }
                x += itemWidth/2.0;
            }else
            {
                NSNumber *num = shujv;
                f = [num doubleValue];
                if (!_lineDataView) {
                    _lineDataView = [[NSBundle mainBundle] loadNibNamed:@"LineChartDataView" owner:nil options:nil].lastObject;
                    showWidth = 76;
                    showHeight = 40;
                    showAnimationed = NO;
                    [_lineDataView setTime:@"未知" data:f];
                    
                    [self addSubview:_lineDataView];
                }
            }
            CGFloat height = self.series.bounds.size.height;
            float y = height - [self.series.axisAttached heighForVal:f];
            showX = (x+axisYwidth)-showWidth/2.0;
            if (showX < axisYwidth) {
                showX = x+axisYwidth;
            }
            if (showX > self.bounds.size.width-axisYwidth-showWidth/2.0) {
                showX = showX-showWidth/2.0;
            }
            if (y > showHeight) {
                showY = y - showHeight;
            }else
            {
                showY = y;
            }
            CGRect frame = CGRectMake(showX, showY, showWidth, showHeight);
            if (_lineDataView) {
                [self updateView:_lineDataView frame:frame];
            }else
            {
                [self updateView:_stockDataView frame:frame];
            }
            _lineY.frame = CGRectMake(axisYwidth + x, 0, 0.5, self.bounds.size.height-axisXheight);
            _circle.frame = CGRectMake(axisYwidth + x - 2, y-2, 4, 4);
        }
    }
}
- (void)updateView:(UIView *)view frame:(CGRect)frame
{
    if (showAnimationed) {
        [UIView animateWithDuration:0.2 animations:^{
            view.frame = frame;
        }];
    }else
    {
        view.frame = frame;
    }
    
}

@end
