//
//  RachargeFootView.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/12.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "RachargeFootView.h"

@interface RachargeFootView ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end
@implementation RachargeFootView

- (void)awakeFromNib {
    [super awakeFromNib];
    _button.backgroundColor = [[Core shareCore] zhongJiangColors][@"lightMainColor"];
    // Initialization code
}

@end
