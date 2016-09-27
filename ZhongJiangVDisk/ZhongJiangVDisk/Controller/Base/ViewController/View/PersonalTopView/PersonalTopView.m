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
    [self _init];
}
- (void)_init
{
    self.backgroundColor = LCoreCurrent.personalTopColor;
    UIColor *imageColor = LCoreCurrent.detailBackColor;
    _imageView.layer.borderColor = imageColor.CGColor;
    _imageView.image = [[UIImage imageNamed:@"user_head_image"] imageWithTintColor:imageColor];
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
