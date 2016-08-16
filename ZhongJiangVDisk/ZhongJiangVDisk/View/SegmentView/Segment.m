//
//  Segment.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/11.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "Segment.h"

@interface Segment ()
{
    NSMutableArray *views;
}
@end
@implementation Segment

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (views == nil) {
            views = [NSMutableArray array];
        }
        for (int i = 0; i < 3; i ++) {
            SegmentView *view = [[NSBundle mainBundle] loadNibNamed:@"SegmentView" owner:nil options:nil].lastObject;
            CGFloat width = frame.size.width/3.0;
            view.frame = CGRectMake(i * width, 0, width, frame.size.height);
            [views addObject:view];
            [self addSubview:view];
        }
    }
    return self;
}
- (void)setValueWithIndex:(NSInteger)index title:(NSString *)title number:(double)number isRise:(BOOL)isRise {
    if (index < views.count) {
        SegmentView *view = views[index];
        [view setDataWithTitle:title Number:number isRise:isRise];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSArray *t = [touches allObjects];
    if (touches.count == 1) {
        UITouch *touch = t[0];
        CGPoint point = [touch locationInView:self];
        if (point.x <= self.frame.size.width/3.0) {
            self.selectedIndex = 0;
        }else if (point.x <= self.frame.size.width/3.0*2.0) {
            self.selectedIndex = 1;
        }else {
            self.selectedIndex = 2;
        }
    }
}
-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    for (int i = 0; i < views.count; i ++) {
        SegmentView *view = views[i];
        if (i == _selectedIndex) {
            view.bottom.hidden = NO;
        }else
        {
            view.bottom.hidden = YES;
        }
    }
}

@end
