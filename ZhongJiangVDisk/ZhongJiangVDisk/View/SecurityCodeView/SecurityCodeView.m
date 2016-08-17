//
//  SecurityCodeView.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/12.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "SecurityCodeView.h"

@interface SecurityCodeView ()
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UIButton *CIAButton;
@property (weak, nonatomic) IBOutlet UIButton *button;
@end
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
    UIColor *color = [Core shareCore].lightMainColor;
    _codeButton.backgroundColor = color;
    _CIAButton.backgroundColor = color;
    _button.backgroundColor = color;
}
- (IBAction)codeButtonAction:(id)sender {
    if (self.btnsActionBlock) {
        self.btnsActionBlock(0);
    }
}
- (IBAction)CIAButtonAction:(id)sender {
    if (self.btnsActionBlock) {
        self.btnsActionBlock(1);
    }
}
- (IBAction)buttonAction:(id)sender {
    if (self.btnsActionBlock) {
        self.btnsActionBlock(2);
    }
}
- (void)setButtonTitle:(NSString *)buttontitle
{
    [_button setTitle:buttontitle forState:UIControlStateNormal];
}
@end
