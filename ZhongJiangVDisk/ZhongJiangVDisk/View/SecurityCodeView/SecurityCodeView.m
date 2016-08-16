//
//  SecurityCodeView.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/12.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "SecurityCodeView.h"

@implementation SecurityCodeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];
    UIColor *color = [[Core shareCore] zhongJiangColors][@"lightMainColor"];
    _codeButton.backgroundColor = color;
    _phoneButton.backgroundColor = color;
    _button.backgroundColor = color;
}
@end
