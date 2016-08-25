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
 保存用户信息
 */
- (void)saveUserInfo:(NSDictionary *)userInfo
{
    self.userInfo = userInfo;
    [LConfigCurrent set_object_for_key:@"userInfo" value:userInfo];
    
}
/*获取用户信息*/
- (NSDictionary *)getUserInfo
{
    return self.userInfo;
}
/*保存用户的某一个信息*/
- (void)saveUserInfoWithKey:(NSString *)key value:(id)value
{
    NSMutableDictionary *dictionary;
    if (self.userInfo) {
        dictionary = [NSMutableDictionary dictionaryWithDictionary:self.userInfo];
    }else
    {
        dictionary = [NSMutableDictionary dictionary];
    }
    [dictionary setObject:value forKey:key];
    [self saveUserInfo:dictionary];
}


@end
