//
//  ProductCollectionCell.h
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/15.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
@interface ProductCollectionCell : UICollectionViewCell
- (void)setColorWithType:(NSString *)type;
@property (nonatomic, copy) btnsActionBlock btnsActionBlock;
@property (nonatomic, strong)ProductModel *model;
@end
