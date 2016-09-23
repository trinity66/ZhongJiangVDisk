//
//  StockData.h
//  MyTest
//
//  Created by shijian01 on 16/9/22.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockData : NSObject
@property (nonatomic)double open, close, high, low;
- (void)setOpen:(double)open close:(double)close low:(double)low high:(double)high;
@end
