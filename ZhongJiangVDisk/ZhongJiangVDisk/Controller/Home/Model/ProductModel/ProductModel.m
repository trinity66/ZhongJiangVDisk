//
//  ProductModel.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/26.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

+(ProductModel *)modelWithDictionary:(NSDictionary *)dictionary
{
    ProductModel *model = [[ProductModel alloc] init];
    model._id = dictionary[@"_id"];
    model.productName = dictionary[@"productName"];
    
    model.productType = [dictionary[@"productType"] integerValue];
    model.maxProfit = [dictionary[@"maxProfit"] integerValue];
    model.maxLoss = [dictionary[@"maxLoss"] integerValue];
    
    model.fluctuations = [dictionary[@"fluctuations"] doubleValue];
    model.price = [dictionary[@"price"] doubleValue];
    model.contractPrice = [dictionary[@"contractPrice"] doubleValue];
    model.poundage = [dictionary[@"poundage"] doubleValue];
    model.modelDict = dictionary;
    return model;
}
@end
