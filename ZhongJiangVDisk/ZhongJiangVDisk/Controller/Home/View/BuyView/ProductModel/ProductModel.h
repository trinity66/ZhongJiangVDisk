//
//  ProductModel.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/26.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject
/*
 "_id":"20160826100001",
 "productType":100,类型
 "productName":"中江银750G",名称
 "fluctuations":0.750,浮动盈亏
 "maxProfit":90,止盈
 "maxLoss":60,止损
 "price":50.00,价格
 "contractPrice":2989.50,合同价值
 "poundage":0.120,手续费百分比
 */
@property(nonatomic, copy)NSString *_id, *productName;
@property(nonatomic, assign)NSInteger productType,maxProfit,maxLoss;
@property(nonatomic, assign)double fluctuations, price, contractPrice, poundage;
+(ProductModel *)modelWithDictionary:(NSDictionary *)dictionary;
@end
