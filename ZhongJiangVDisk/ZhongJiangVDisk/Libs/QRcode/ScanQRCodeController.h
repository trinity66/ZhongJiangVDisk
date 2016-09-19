//
//  ScanQRCodeController.h
//  eCarry
//
//  Created by whde on 15/8/14.
//  Copyright (c) 2015年 Joybon. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ScanQRCodeController : UIViewController
typedef void (^QRCodeDidReceiveBlock)(NSString *rst);
@property (nonatomic, copy, readonly) QRCodeDidReceiveBlock didReceiveBlock;
- (void)setDidReceiveBlock:(QRCodeDidReceiveBlock)didReceiveBlock;
- (void)selfRemoveFromSuperview;
- (void)selfAddToParentController:(UIViewController *)parentController;
@end
