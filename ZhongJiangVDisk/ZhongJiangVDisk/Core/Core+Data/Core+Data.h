//
//  Core+Data.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/25.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "Core.h"

@interface Core (Data)



- (void)saveUserInfo:(NSDictionary *)userInfo;
- (void)saveUserInfoWithKey:(NSString *)key value:(id)value;
- (NSDictionary *)getUserInfo;

- (void)products;

- (void)saveDeal:(NSDictionary *)dictionary;
- (void)saveDealWithList:(NSMutableArray *)list;
- (NSArray*)getDealList;

- (void)saveDealHistory:(NSDictionary *)dictionary;
- (NSArray *)getDealHistoryList;

- (void)saveHomeTopData:(NSDictionary *)homeTopData;
//- (NSMutableArray *)getHomeTopDatas;
- (NSDictionary *)getHomeTopData;
@end
