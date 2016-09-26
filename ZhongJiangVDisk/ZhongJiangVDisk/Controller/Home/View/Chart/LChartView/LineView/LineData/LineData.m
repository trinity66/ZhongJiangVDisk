//
//  LineData.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/26.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "LineData.h"

@implementation LineData
+ (LineData *)setData:(double)data time:(NSString *)time
{
    LineData *lineData = [[LineData alloc] init];
    lineData.data = data;
    NSDate *date = [NSDate dateWithString:time dateFormat:@"yyyyMMddHHmmss"];
    lineData.time = [NSString stringWithDate:date dateFormat:@"HH:mm:ss"];
    return lineData;
}
@end
