//
//  DealHistoryModel.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/29.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "DealHistoryModel.h"

@implementation DealHistoryModel
+(DealHistoryModel *)modelWithDictionary:(NSDictionary *)dictionary
{
    DealHistoryModel *model = [[DealHistoryModel alloc] init];
    model._id = dictionary[@"_id"];
    model.time = dictionary[@"time"];
    model.profit = dictionary[@"profit"];
    model.loss = dictionary[@"loss"];
    model.productName = dictionary[@"productName"];
    model.countNumber = [dictionary[@"countNumber"] integerValue];
    model.money = [dictionary[@"money"] doubleValue];
    model.product = dictionary[@"product"];
    model.productModel = [ProductModel modelWithDictionary:dictionary[@"product"]];
    model.isBuyRise = [dictionary[@"isBuyRise"] boolValue];
    model.modelDict = dictionary;
    return model;
}
@end
