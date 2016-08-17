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
    // Do any additional setup after loading the view.
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
       _personalTopView = [[NSBundle mainBundle] loadNibNamed:@"PersonalTopView" owner:nil options:nil].lastObject;
        _personalTopView.frame = CGRectMake(0, 0, kScreenWidth, kPersonalTopViewHeight+64);
        _personalTopView.backgroundColor = [Core shareCore].lightMainColor;
        [self.view addSubview:_personalTopView];
    }
    
    
}
- (void)addSegmentWithUserEnabled:(BOOL)userEnabled
{
    if (_segment == nil) {
        CGFloat y = 0;
        if (_personalTopView != nil) {
            y += kPersonalTopViewHeight;
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
- (void)awakeFromNib
{
    [super awakeFromNib];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
