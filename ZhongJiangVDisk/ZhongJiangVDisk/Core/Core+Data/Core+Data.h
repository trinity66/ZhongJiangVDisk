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
- (NSDictionary *)getUserInfo;
- (void)saveUserInfoWithKey:(NSString *)key value:(id)value;
- (void)products;
@end
