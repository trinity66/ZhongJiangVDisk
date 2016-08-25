//
//  BaseViewController.h
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/11.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalTopView.h"
#import "Segment.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) PersonalTopView *personalTopView;
@property (nonatomic, strong) Segment *segment;
- (void)addSegmentWithUserEnabled:(BOOL)userEnabled;
- (CGFloat)getTableViewY;
- (void)addPersonalTopView;
- (void)showAlert:(NSString *)string;
- (void)setBalance;
@end
