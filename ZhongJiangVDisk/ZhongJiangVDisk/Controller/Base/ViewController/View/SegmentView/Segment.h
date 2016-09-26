//
//  Segment.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/11.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Segment : UIView
@property (nonatomic, assign) NSInteger selectedIndex;
- (void)setValueWithIndex:(NSInteger)index title:(NSString *)title number:(NSString *)number isRise:(BOOL)isRise;
@property (nonatomic, copy)btnsActionBlock btnsActionBlock;
@end
