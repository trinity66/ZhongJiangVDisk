//
//  DetailPositionCell2.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/13.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealHistoryModel.h"
@interface DetailPositionCell2 : UITableViewCell
@property (nonatomic, strong)DealHistoryModel *model;
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@end
