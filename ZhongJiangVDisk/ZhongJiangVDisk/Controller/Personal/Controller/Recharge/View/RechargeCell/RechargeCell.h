//
//  RechargeCell.h
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/12.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RechargeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (void)cellIsSelected:(BOOL)selected enabled:(BOOL)enabled;
@end
