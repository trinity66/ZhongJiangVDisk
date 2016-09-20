//
//  ChartView.h
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/16.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartViewSuper.h"
@interface ChartView : UIView
@property (strong, nonatomic) ChartViewSuper *cS;
- (void)setSelFrame:(CGRect)frame;
@end
