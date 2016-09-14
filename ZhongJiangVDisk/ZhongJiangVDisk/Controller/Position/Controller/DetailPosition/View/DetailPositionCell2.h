//
//  DetailPositionCell2.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/13.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LButton.h"
@interface DetailPositionCell2 : UITableViewCell
@property (nonatomic, strong) NSArray *datas;
@property (weak, nonatomic) IBOutlet LButton *button;
@property (nonatomic, copy) btnActionBlock btnActionBlock;
@end
