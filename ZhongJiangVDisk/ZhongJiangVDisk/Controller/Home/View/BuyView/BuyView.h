//
//  BuyView.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/15.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
#import "DealHistoryModel.h"
typedef NS_ENUM(NSUInteger, BuyViewType) {
    BuyViewTypeBuy = 0,
    BuyViewTypeAdjustProfit,
};
@interface BuyView : UIView
- (void)showBuyViewAnimated:(BOOL)animated buyViewType:(BuyViewType)buyViewType;
- (void)removeBuyViewAnimated:(BOOL)animated;
@property (nonatomic, strong) ProductModel *model;
@property (nonatomic, strong) DealHistoryModel *dealModel;
@property (nonatomic, assign) BOOL isBuyRise;
@property (nonatomic, copy) btnActionBlock btnActionBlock;
@end
