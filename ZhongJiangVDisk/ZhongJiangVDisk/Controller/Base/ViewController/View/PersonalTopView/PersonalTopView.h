//
//  PersonalTopView.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/11.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalTopView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *balance;
- (void)setRechargeEnabled:(BOOL)enabled;
@end
