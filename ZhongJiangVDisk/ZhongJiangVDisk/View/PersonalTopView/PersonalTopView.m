//
//  PersonalTopView.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/11.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "PersonalTopView.h"

@interface PersonalTopView ()
@property (weak, nonatomic) IBOutlet LButton *recharge;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailing;
@end
@implementation PersonalTopView
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.frame = CGRectMake(0, 0, kScreenWidth, kPersonalTopViewHeight);
    self.backgroundColor = [Core shareCore].personalTopColor;
    UIColor *borderColor = [Core shareCore].detailBackColor;
    _imageView.layer.borderColor = borderColor.CGColor;
    _recharge.backgroundColor = [Core shareCore].riseTextColor;
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
