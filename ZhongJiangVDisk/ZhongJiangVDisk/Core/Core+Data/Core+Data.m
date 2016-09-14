//
//  Core+Data.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/25.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "Core+Data.h"

@implementation Core (Data)
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
    return [LConfigCurrent object_value_with_key:@"userInfo"];
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
/*
 存储交易详情
 */
- (void)saveDeal:(NSDictionary *)dictionary
{
    NSMutableArray *list;
    NSArray *getList = [self getDealList];
    if (getList) {
        list = [NSMutableArray arrayWithArray:getList];
    }else
    {
        list = [NSMutableArray array];
    }
    [list addObject:dictionary];
    [LConfigCurrent set_object_for_key:@"dealList" value:list];
    
}
- (void)saveDealWithList:(NSMutableArray *)list
{
    [LConfigCurrent set_object_for_key:@"dealList" value:list];
}
/*
 获取交易详情列表
 */
- (NSArray*)getDealList
{
    return [LConfigCurrent object_value_with_key:@"dealList"];
}
/*
 存储交易历史
 */
- (void)saveDealHistory:(NSDictionary *)dictionary
{
    NSMutableArray *list;
    NSArray *getList = [self getDealHistoryList];
    if (getList) {
        list = [NSMutableArray arrayWithArray:getList];
    }else
    {
        list = [NSMutableArray array];
    }
    [list addObject:dictionary];
    [LConfigCurrent set_object_for_key:@"dealHistoryList" value:list];
}
/*
 获取交易历史
 */
- (NSArray *)getDealHistoryList
{
    return [LConfigCurrent object_value_with_key:@"dealHistoryList"];
}
- (void)products
{
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Products" ofType:@"json"]];
    NSError* err = nil;
    self.productsList = (NSArray*)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
}



@end
