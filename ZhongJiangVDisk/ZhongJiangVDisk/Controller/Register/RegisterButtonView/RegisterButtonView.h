//
//  RegisterButtonView.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/22.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterButtonView : UIView
@property (weak, nonatomic) IBOutlet LTextField *securityCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *isAgreeBtn;
@property (weak, nonatomic) IBOutlet LButton *codeButton;
@property (nonatomic, copy) btnsActionBlock btnsActionBlock;
@end
