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
/*
 保存home顶端的数据
 
 [LCoreCurrent requestWithURL:@"http://123.206.194.14:18081/HQ/AllGoods" resultBlock:^(BOOL success, id result, NSError *error, NSURLResponse *response) {
 
 }];
 */
- (void)saveHomeTopData:(NSDictionary *)homeTopData
{
    NSMutableArray *homeTopDatas = [self getHomeTopDatas];
    BOOL isHavePreData = YES;
    if (!homeTopDatas) {
        homeTopDatas = [NSMutableArray array];
        isHavePreData = NO;
    }
    for (int i = 0; i < LCoreCurrent.homeTopTitles.count; i ++) {
        double number = 0, preNumber = 0;
        BOOL isRise = YES;
        if (!isHavePreData && !homeTopData) {
            //之前无数据，当前也无数据
            number = 0.00;
        }else
        {
            NSString *key = self.homeTopTitles[i][@"key"];
            if (isHavePreData) {
                //之前有数据
                preNumber = [homeTopDatas.lastObject[key] doubleValue];
                if (homeTopData) {
                    //当前有数据
                    number = [homeTopData[key] doubleValue];
                    if (preNumber>number) {
                        isRise = NO;
                    }
                }else
                {
                    //当前无数据，填写之前数据
                    number = preNumber;
                }
            }
        }
        [self.segmentHome setValueWithIndex:i title:nil number:number isRise:isRise];
        [self.segmentPosition setValueWithIndex:i title:nil number:number isRise:isRise];
    }
    if (homeTopData) {
        [homeTopDatas addObject:homeTopData];
        [LConfigCurrent set_object_for_key:@"homeTopDatas" value:homeTopDatas];
    }
}
/*
 获取home顶端的数据
 */
- (NSMutableArray *)getHomeTopDatas
{
    return [LConfigCurrent object_value_with_key:@"homeTopDatas"];
}



@end
