//
//  BaseNavigationController.m
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/11.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *color = [Core shareCore].darkMainColor;
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    [[UINavigationBar appearance] setTintColor:color];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName:color,
                                                           NSFontAttributeName:[UIFont systemFontOfSize:16]}];
     [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:color}];
    self.interactivePopGestureRecognizer.delegate = self;
    self.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //    if (self.childViewControllers.count > 0) {
    //        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"v1_left_item"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    //    }
    if (self.childViewControllers.count == 1) {
        //        if ([viewController isKindOfClass:[JPViewController class]]) {
        //            JPViewController *vc = (JPViewController*)viewController;
        //            vc.enable_transition_animation = YES;
        //        }
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}
- (void)back
{
    [self popViewControllerAnimated:YES];
}
#pragma mark - <UIGestureRecognizerDelegate>
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 手势何时有效 : 当导航控制器的子控制器个数 > 1就有效
    return self.childViewControllers.count > 1;
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
