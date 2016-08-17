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
    self.backgroundColor = [Core shareCore].lightMainColor;
    UIColor *borderColor = [Core shareCore].lightGrayColor;
    _imageView.layer.borderColor = borderColor.CGColor;
    _recharge.backgroundColor = [Core shareCore].riseColor;
}
- (IBAction)rechargeAction:(id)sender {
    [[Core shareCore] goRechargeVC];
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
