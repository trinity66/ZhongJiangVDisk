//
//  PersonalTopView.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/11.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "PersonalTopView.h"

@interface PersonalTopView ()
@property (weak, nonatomic) IBOutlet UIButton *recharge;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailing;
@end
@implementation PersonalTopView
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [[Core shareCore] zhongJiangColors][@"lightMainColor"];
    UIColor *borderColor = [[Core shareCore] zhongJiangColors][@"lightGrayColor"];
    _imageView.layer.borderColor = borderColor.CGColor;
    _recharge.backgroundColor = [[Core shareCore] zhongJiangColors][@"riseColor"];
}
- (IBAction)rechargeAction:(id)sender {
    [[Core shareCore] goRechargeVC];
//     InputDealPswdView *put = [[NSBundle mainBundle] loadNibNamed:@"InputDealPswdView" owner:nil options:nil].lastObject;
//    [put showInputDealPswdView];
}
- (void)setRechargeEnabled:(BOOL)enabled
{
    if (enabled) {
        _trailing.constant = 55;
    }else
    {
        _trailing.constant = 10;
        
    }
    _recharge.hidden = !enabled;
}
@end
