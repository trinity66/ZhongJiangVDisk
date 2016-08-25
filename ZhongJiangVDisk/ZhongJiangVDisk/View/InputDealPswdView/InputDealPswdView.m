//
//  InputDealPswdView.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/15.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "InputDealPswdView.h"

@interface InputDealPswdView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *forgetPswdBtn;
@property (weak, nonatomic) IBOutlet LButton *button;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *lOne;
@property (weak, nonatomic) IBOutlet UIView *lTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lHeight;


@end
@implementation InputDealPswdView
- (void)showInputDealPswdViewAnimated:(BOOL)animated
{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    if (animated) {
        _mainView.alpha = 0.0;
        _mainView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        [UIView animateWithDuration:0.3 animations:^{
            _mainView.alpha = 1.0;
            _mainView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }
    [_textField becomeFirstResponder];
}
- (void)removeInputDealPswdViewAnimated:(BOOL)animated
{
    [self resignTextFieldFirstResponder];
    if (animated) {
        _mainView.alpha = 1.0;
        _mainView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        [UIView animateWithDuration:0.3 animations:^{
            _mainView.alpha = 0.0;
            _mainView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else
    {
        [self removeFromSuperview];
    }
    
    
}
- (IBAction)forgetPswdBtnAction:(id)sender {
    [self resignTextFieldFirstResponder];
    if (self.btnsActionBlock) {
        self.btnsActionBlock(0);
    }
}
- (IBAction)buttonAction:(id)sender {
    [self resignTextFieldFirstResponder];
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
    [_forgetPswdBtn setTitleColor:LCoreCurrent.selectedLineColor forState:UIControlStateNormal];
    _button.backgroundColor = LCoreCurrent.buttonBackColor;
    _mainView.backgroundColor = LCoreCurrent.backgroundColor;
    _mainView.layer.borderColor = LCoreCurrent.buttonBorderColor.CGColor;
    _title.textColor = LCoreCurrent.cellTextColor;
    _lOne.backgroundColor = LCoreCurrent.detailLightBackColor;
    _lTwo.backgroundColor = LCoreCurrent.detailLightBackColor;
    _textField.delegate = self;
    _textField.returnKeyType = UIReturnKeyDone;
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_textField startLayerColor];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resignTextFieldFirstResponder];
    return YES;
}
- (void)resignTextFieldFirstResponder
{
    [_textField resignFirstResponder];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [_textField setDefalutColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
