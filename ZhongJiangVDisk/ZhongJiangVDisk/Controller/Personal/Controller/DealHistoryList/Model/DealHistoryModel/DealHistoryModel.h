//
//  DealHistoryModel.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/29.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"
@interface DealHistoryModel : NSObject
/*
 _id:
 time:
 productName:商品名称
 countNumber:买的个数
 money:钱数
 product:
 isBuyRise:是否是买涨
 */
@property (nonatomic, copy) NSString *_id, *time, *productName;
@property (nonatomic, assign) NSInteger countNumber;
@property (nonatomic, assign) double money;
@property (nonatomic, strong) ProductModel *productModel;
@property (nonatomic, assign) BOOL isBuyRise;
@property (nonatomic, strong) NSDictionary *modelDict, *product;
+(DealHistoryModel *)modelWithDictionary:(NSDictionary *)dictionary;
@end
