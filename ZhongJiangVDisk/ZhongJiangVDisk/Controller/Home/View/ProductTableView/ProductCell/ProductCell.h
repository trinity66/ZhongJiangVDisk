//
//  ProductCell.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/18.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UITableViewCell
@property (nonatomic, copy) btnsActionBlock btnsActionBlock;
@property (nonatomic, strong)ProductModel *model;
@end
