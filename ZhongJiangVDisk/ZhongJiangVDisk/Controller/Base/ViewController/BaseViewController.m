//
//  BaseViewController.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/11.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addPersonalTopView];
    self.view.backgroundColor = LCoreCurrent.backgroundColor;
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setBalance];
}
- (void)setBalance
{
    if (LCoreCurrent.isLogin) {
        _personalTopView.balance.text = [NSString stringWithFormat:@"个人资产:%.02f",[LCoreCurrent.userInfo[@"balance"] doubleValue]];
    }
}
- (CGFloat)getTableViewY
{
    CGFloat y = 0;
    if (self.personalTopView != nil) {
        y += kPersonalTopViewHeight;
    }
    if (self.segment != nil) {
        y += kSegmentHeight;
    }
    return y;
}
- (void)addPersonalTopView
{
    if (_personalTopView == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kPersonalTopViewHeight)];
        _personalTopView = [[NSBundle mainBundle] loadNibNamed:@"PersonalTopView" owner:nil options:nil].lastObject;
        _personalTopView.frame = view.bounds;
        view.backgroundColor = LCoreCurrent.personalTopColor;
        [view addSubview:_personalTopView];
        [self.view addSubview:view];
    }
}
- (void)addSegmentWithUserEnabled:(BOOL)userEnabled
{
    if (_segment == nil) {
        CGFloat y = 0;
        if (_personalTopView != nil) {
            y += _personalTopView.frame.size.height + _personalTopView.frame.origin.y;
        }
        _segment = [[Segment alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, kSegmentHeight)];
        [_segment setUserInteractionEnabled:userEnabled];
        if (userEnabled) {
            _segment.selectedIndex = 0;
        }
        [_segment setValueWithIndex:0 title:@"中江银" number:4295.00 isRise:YES];
        [_segment setValueWithIndex:1 title:@"中江油" number:279.17 isRise:NO];
        [_segment setValueWithIndex:2 title:@"中江铜" number:32076 isRise:YES];
        [self.view addSubview:_segment];
    }
    
    
}
- (void)showAlert:(NSString *)string
{
    [LCoreCurrent showAlertTitle:string timeCount:2 inView:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
