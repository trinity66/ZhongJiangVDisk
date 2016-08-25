//
//  Core+CheckData.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/25.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "Core.h"

@interface Core (CheckData)
- (BOOL)isValidChineseCharacter:(NSString *)string;
- (BOOL)isValidNumber:(NSString *)string;
- (BOOL)isValidNumber:(NSString *)string decimalCount:(int)decimalCount;
- (BOOL)isValidIdCard:(NSString *)string;
- (BOOL)isValidPhoneNumber:(NSString *)string;
- (NSString *)deleteSpaceAndNewline:(NSString *)string;
@end
