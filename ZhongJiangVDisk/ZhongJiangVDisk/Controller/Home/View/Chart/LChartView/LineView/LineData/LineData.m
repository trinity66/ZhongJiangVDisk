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
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *date = [formatter dateFromString:time];
    [formatter setDateFormat:@"HH:mm:ss"];
    lineData.time = [formatter stringFromDate:date];
    
    return lineData;
}
@end
