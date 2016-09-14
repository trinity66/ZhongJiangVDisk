//
//  PositionHead.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/13.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PositionHead : UIView
@property (nonatomic, copy)btnActionBlock btnActionBlock;
- (void)setDetailWithNumber:(double)number isRise:(BOOL)isRise;
- (void)setTitle:(NSString *)title detail:(NSString *)detail buttonTitle:(NSString *)buttonTite;
@end
