//
//  BaseViewController.h
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/11.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalTopView.h"
@interface BaseViewController : UIViewController
@property (nonatomic, strong) Segment *segment;
@property (nonatomic, strong) PersonalTopView *personalTopView;
- (void)addSegmentWithUserEnabled:(BOOL)userEnabled;
- (CGFloat)getTableViewY;
- (void)addPersonalTopView;
- (void)showAlert:(NSString *)string;
- (void)setBalance;
@end
