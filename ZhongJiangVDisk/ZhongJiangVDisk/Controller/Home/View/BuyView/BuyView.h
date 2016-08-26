//
//  BuyView.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/15.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
@interface BuyView : UIView

- (void)showBuyViewAnimated:(BOOL)animated;
- (void)removeBuyViewAnimated:(BOOL)animated;
@property (nonatomic, strong) ProductModel *model;
@property (nonatomic, assign) BOOL isBuyRise;
@property (nonatomic, copy) btnActionBlock btnActionBlock;
@end
