//
//  InputDealPswdView.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/15.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "InputDealPswdView.h"

@interface InputDealPswdView ()
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *forgetPswdBtn;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
@implementation InputDealPswdView
- (void)showInputDealPswdView
{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    _mainView.alpha = 0.0;
    _mainView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.3 animations:^{
        _mainView.alpha = 1.0;
        _mainView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}
- (void)removeInputDealPswdView
{
    _mainView.alpha = 1.0;
    _mainView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    [UIView animateWithDuration:0.3 animations:^{
        _mainView.alpha = 0.0;
        _mainView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
- (IBAction)buttonAction:(id)sender {
    [self removeInputDealPswdView];
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    UIColor *color = [[Core shareCore] zhongJiangColors][@"lightMainColor"];
    [_forgetPswdBtn setTitleColor:color forState:UIControlStateNormal];
    _button.backgroundColor = color;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
