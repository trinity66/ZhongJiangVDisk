//
//  StockData.m
//  MyTest
//
//  Created by shijian01 on 16/9/22.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "StockData.h"

@implementation StockData

- (void)setOpen:(double)open close:(double)close low:(double)low high:(double)high
{
    self.open = open;
    self.close = close;
    self.low = low;
    self.high = high;
}
@end
