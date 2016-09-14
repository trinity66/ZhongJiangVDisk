//
//  DealModel.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/29.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"
@interface DealModel : NSObject
/*
 "_id":"20160826100001",
 "type":100充值,200买入,300卖出,301卖出手续费,400提现,401提现手续费,500亏损，600盈利
 "product":prroductModel
 "time":时间
 "money":金额
 "balance":余额
 "isFinsih":
 "profit":
 "loss":
 */
+(DealModel*)modelWithDictionary:(NSDictionary *)dictionary;
@property (nonatomic,copy) NSString *_id, *time, *profit, *loss;
@property (nonatomic, assign) double money, balance;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) BOOL isFinsih;
@property (nonatomic, strong) ProductModel *productModel;
@property (nonatomic, strong) NSDictionary *modelDict, *product;
@end
