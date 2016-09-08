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
    [self setSomeControl];
}
- (void)setSomeControl
{
    self.backgroundColor = LCoreCurrent.personalTopColor;
    _imageView.layer.borderColor = LCoreCurrent.detailBackColor.CGColor;
    _recharge.backgroundColor = LCoreCurrent.riseTextColor;
    _balance.font = [UIFont systemFontOfSize:kCellLabelFont-4];
    if (LCoreCurrent.VDiskType == VDiskTypeYinHe) {
        _balance.textColor = LCoreCurrent.riseColor;
    }
}
- (IBAction)rechargeAction:(id)sender {
    [LCoreCurrent goRechargeVC];
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
