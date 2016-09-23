//
//  LChartTopView.h
//  MyTest
//
//  Created by shijian01 on 16/9/23.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockData.h"
@interface LChartTopView : UIView
@property (nonatomic, strong)StockData *data;
@property (nonatomic, copy)btnsActionBlock btnsActionBlock;
+(LChartTopView *)viewWithframe:(CGRect)frame;
@end
