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
@property (nonatomic, assign) NSInteger segSelectedIndex;
- (void)setSelfFrame:(CGRect)frame;

@end
