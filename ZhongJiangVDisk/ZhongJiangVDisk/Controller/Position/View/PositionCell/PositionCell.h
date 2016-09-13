//
//  PositionCell.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/13.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealHistoryModel.h"
@interface PositionCell : UITableViewCell
@property (nonatomic, strong) DealHistoryModel *model;
@property (nonatomic, copy) btnActionBlock btnActionBlock;
@end
