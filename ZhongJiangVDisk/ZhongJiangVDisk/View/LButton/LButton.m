//
//  LButton.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/18.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "LButton.h"

@interface LButton ()
{
    NSInteger timerCount;
}
@property (nonatomic, strong) NSTimer *timerCoder;
@property (nonatomic) BOOL buttonEnabled;
@end
@implementation LButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = 5;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = LCoreCurrent.buttonBorderColor.CGColor;
    [self setTitleColor:LCoreCurrent.buttonTitleColor forState:UIControlStateNormal];
}
- (void)startWithTimerCount:(NSInteger)count
{
    [self stopTimer];
    NSString *buttonTitle = [NSString stringWithFormat:@"%ld秒重发",count];
    [self setButtonTitle:buttonTitle];
    self.buttonEnabled = NO;
    timerCount = count-1;
    _timerCoder = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}
- (void)stopTimer
{
    if (_timerCoder) {
        [_timerCoder invalidate];
        _timerCoder = nil;
        self.buttonEnabled = YES;
    }
}
- (void)timerAction {
    if (timerCount > 0) {
        NSString *title = [NSString stringWithFormat:@"%ld秒后重发",(long)timerCount];
        [self setButtonTitle:title];
    }else
    {
        [self stopTimer];
    }
    timerCount -= 1;
}
- (void)setButtonTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self setTitle:title forState:UIControlStateNormal];
}
- (void)setButtonEnabled:(BOOL)buttonEnabled
{
    _buttonEnabled = buttonEnabled;
    if (buttonEnabled) {
       [self setButtonTitle:@"发送验证码"];
        self.alpha = 1.0;
    }else
    {
        self.alpha = 0.5;
    }
    self.enabled = buttonEnabled;
}
@end
