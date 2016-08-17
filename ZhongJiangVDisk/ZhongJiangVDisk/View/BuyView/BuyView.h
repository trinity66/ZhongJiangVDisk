//
//  BuyView.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/15.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyView : UIView
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (nonatomic, copy) btnActionBlock btnActionBlock;
- (void)showBuyView;
- (void)removeBuyView;
@end
