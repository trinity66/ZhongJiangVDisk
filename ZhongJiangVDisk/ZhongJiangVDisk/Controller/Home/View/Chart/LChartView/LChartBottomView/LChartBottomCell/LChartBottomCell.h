//
//  LChartBottomCell.h
//  MyTest
//
//  Created by shijian01 on 16/9/23.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LChartBottomCell : UICollectionViewCell

- (void)setLabelText:(NSString *)text;
- (void)reFrameWithWidth:(double)width;
- (void)reFrameRightWithWidth:(double)width;
- (void)reFrameLeft;
@end
