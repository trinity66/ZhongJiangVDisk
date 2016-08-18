//
//  ButtonView.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/12.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "ButtonView.h"


@interface ButtonView ()
@property (weak, nonatomic) IBOutlet LButton *button;


@end
@implementation ButtonView

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
    self.backgroundColor = [Core shareCore].backgroundColor;
    _button.backgroundColor = [Core shareCore].buttonBackColor;
}
- (void)setBtnTitle:(NSString *)btnTitle
{
    [_button setTitle:btnTitle forState:UIControlStateNormal];
}
- (IBAction)buttonAction:(id)sender {
    if (self.btnActionBlock) {
        self.btnActionBlock();
    }
}

@end
