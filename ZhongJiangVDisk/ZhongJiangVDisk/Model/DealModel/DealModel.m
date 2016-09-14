//
//  DealModel.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/29.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "DealModel.h"

@implementation DealModel
/*
 "_id":"20160826100001",
 "type":100充值,200买入,300卖出,301卖出手续费,400提现,401提现手续费,500亏损，600盈利
 "product":prroductModel
 "time":时间
 "money":金额
 "balance":余额
 */
+(DealModel*)modelWithDictionary:(NSDictionary *)dictionary
{
    DealModel *model = [[DealModel alloc] init];
    model._id = dictionary[@"_id"];
    model.profit = dictionary[@"profit"];
    model.loss = dictionary[@"loss"];
    model.type = [dictionary[@"type"] integerValue];
    model.time = dictionary[@"time"];
    model.product = dictionary[@"product"];
    model.productModel = [ProductModel modelWithDictionary:dictionary[@"product"]];
    model.money = [dictionary[@"money"] doubleValue];
    model.balance = [dictionary[@"balance"] doubleValue];
    model.isFinsih = [dictionary[@"isFinsih"] boolValue];
    model.modelDict = dictionary;
    
    return model;
}

@end
