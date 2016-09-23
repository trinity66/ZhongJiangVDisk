//
//  LChartBottomView.h
//  MyTest
//
//  Created by shijian01 on 16/9/23.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LChartBottomView : UIView
@property (nonatomic, strong) NSArray *itemDatas;
+(LChartBottomView *)initWithDatas:(NSArray *)datas frame:(CGRect)frame;

@end
