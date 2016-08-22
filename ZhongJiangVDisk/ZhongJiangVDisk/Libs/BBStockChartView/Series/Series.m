//
//  Series.m
//  BBChart
//
//  Created by ChenXiaoyu on 15/1/5.
//  Copyright (c) 2015年 ChenXiaoyu. All rights reserved.
//

#import "Series.h"

@implementation Series

- (instancetype)init{
    self = [super init];
    if (self) {
        _data = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void)drawPoint:(NSUInteger)idx animated:(BOOL)animated{
    
}


- (void)drawAnimated:(BOOL)animated{
    NSUInteger cnt = [BBTheme theme].defYLabelGap;
    for (int i = 0; i < cnt; i++) {
        CGFloat curHei = self.bounds.size.height/(float)cnt*(float)i;
        CALayer* dash = [BaseLayer layerOfLineFrom:CGPointMake(0, curHei) to:CGPointMake(self.bounds.size.width, curHei) withColor:[Core shareCore].chartLinesColor andWidth:0.5 animated:NO];
        [self addSublayer:dash];
    }
    for (int i = 0; i < self.data.count; ++i) {
        [self drawPoint:i animated:animated];
    }
    
    
}
- (void)redrawAnimated:(BOOL)animated{
    self.sublayers = nil;
    [self drawAnimated:animated];
}

-(float)pointWidth{
    CGFloat w = self.bounds.size.width;
    if ( _data.count == 0) {
        return w;
    }
    return w / _data.count;

}

- (void)addPoint:(float)p{
    
}
@end
