//
//  LineData.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/26.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LineData : NSObject
@property (nonatomic) double data;
@property (nonatomic, copy) NSString *time;
+ (LineData *)setData:(double)data time:(NSString *)time;
@end
