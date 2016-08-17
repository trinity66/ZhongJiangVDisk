//
//  ButtonView.h
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/12.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ButtonView : UIView
- (void)setBtnTitle:(NSString *)btnTitle;
@property (nonatomic, copy) btnActionBlock btnActionBlock;

@end
