//
//  StockData.m
//  MyTest
//
//  Created by shijian01 on 16/9/22.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "StockData.h"

@implementation StockData

+ (StockData *)setOpen:(double)open close:(double)close low:(double)low high:(double)high time:(NSString *)time
{
    StockData *stockData = [[StockData alloc] init];
    stockData.open = open;
    stockData.close = close;
    stockData.low = low;
    stockData.high = high;
    if (time) {
        NSDate *date = [NSDate dateWithString:time dateFormat:@"yyyyMMddHHmmss"];
        stockData.time = [NSString stringWithDate:date dateFormat:@"HH:mm:ss"];
    }
    return stockData;
}
@end
