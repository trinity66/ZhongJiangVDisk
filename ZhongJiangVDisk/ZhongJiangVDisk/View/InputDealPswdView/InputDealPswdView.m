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
@property (weak, nonatomic) IBOutlet LButton *button;
@property (weak, nonatomic) IBOutlet LTextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *lOne;
@property (weak, nonatomic) IBOutlet UIView *lTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lHeight;


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
- (IBAction)forgetPswdBtnAction:(id)sender {
    if (self.btnsActionBlock) {
        self.btnsActionBlock(0);
    }
}
- (IBAction)buttonAction:(id)sender {
    if (self.btnsActionBlock) {
        self.btnsActionBlock(1);
    }
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setSomeControl];
}
- (void)setSomeControl
{
    _lHeight.constant = 0.5;
    [_forgetPswdBtn setTitleColor:[Core shareCore].selectedLineColor forState:UIControlStateNormal];
    _button.backgroundColor = [Core shareCore].buttonBackColor;
    _mainView.backgroundColor = [Core shareCore].backgroundColor;
    _title.textColor = [Core shareCore].cellTextColor;
    _lOne.backgroundColor = [Core shareCore].detailLightBackColor;
    _lTwo.backgroundColor = [Core shareCore].detailLightBackColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
