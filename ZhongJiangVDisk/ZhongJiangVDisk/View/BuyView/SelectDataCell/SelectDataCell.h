//
//  SelectDataCell.h
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/15.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LButton.h"
@interface SelectDataCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet LTextField *textField;
@property (nonatomic, copy) btnsActionBlock btnsActionBlock;


@end
