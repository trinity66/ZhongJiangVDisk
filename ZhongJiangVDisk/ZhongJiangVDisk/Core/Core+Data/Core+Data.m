//
//  Core+Data.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/25.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "Core+Data.h"

@implementation Core (Data)
- (void)setIsLogin:(BOOL)isLogin
{
    if (isLogin) {
        [LConfigCurrent set_object_for_key:@"isLogin" value:@"1"];
    }else
    {
        [LConfigCurrent set_object_for_key:@"isLogin" value:@"0"];
    }
}
- (BOOL)isLogin
{
    NSInteger l = [[LConfigCurrent object_value_with_key:@"isLogin"] integerValue];
    if (l) {
        return YES;
    }else
    {
        return NO;
    }
}
/*
 判断正则表达式是否成立
 */
- (BOOL)isValidWithRegex:(NSString *)regex string:(NSString *)string
{
    string = [self deleteSpaceAndNewline:string];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
}
/*
 删除字符串中的空格
 */
- (NSString *)deleteSpaceAndNewline:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
/*
 是否是纯汉字
 */
- (BOOL)isValidChineseCharacter:(NSString *)string
{
    NSString *regex = @"^([\\u4e00-\\u9fa5]){1,5}$";
    return [self isValidWithRegex:regex string:string];
}
/*
 是否是纯数字
 */
- (BOOL)isValidNumber:(NSString *)string
{
    NSString *regex = @"\\d*$";
    return [self isValidWithRegex:regex string:string];
}
/*
 是否是数字，带小数
 */
- (BOOL)isValidNumber:(NSString *)string decimalCount:(int)decimalCount
{
    NSString *regex = [NSString stringWithFormat:@"^(\\d*$|(^\\d+(.\\d{1,%d})?$))$", decimalCount];
    return [self isValidWithRegex:regex string:string];
}
/*
身份证是否规范
 */
- (BOOL)isValidIdCard:(NSString *)string
{
    NSString *regex = @"^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$";
    return [self isValidWithRegex:regex string:string];
}
/*
手机号是否规范
 */
- (BOOL)isValidPhoneNumber:(NSString *)string
{
//    NSString *regex = @"^1(3\\d|5\\d|7[017]|8[0-35-9])\\d{8}$";
    if (string.length == 11) {
        return [self isValidNumber:string];
    }
    return NO;
}

@end
