//
//  SecurityCodeView.h
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/12.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecurityCodeView : UIView
@property (weak, nonatomic) IBOutlet LTextField *securityCodeTF;
@property (weak, nonatomic) IBOutlet LButton *codeButton;
@property (nonatomic, copy) btnsActionBlock btnsActionBlock;
- (void)setButtonTitle:(NSString *)buttontitle;
@end
