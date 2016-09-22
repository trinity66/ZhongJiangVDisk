//
//  Core.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/8/11.
//  Copyright © 2016年 shijian01. All rights reserved.
//

#import "Core.h"
#import "MBProgressHUD.h"

@implementation Core
+(Core *)current
{
    static Core *core = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        core = [[Core alloc] init];
        core.userInfo = [core getUserInfo];
        [core products];
    });
    return core;
}
//当前是否是登录状态
- (void)setIsLogin:(BOOL)isLogin
{
    if (isLogin) {
        [LConfigCurrent set_object_for_key:@"isLogin" value:@"1"];
    }else
    {
        [LConfigCurrent set_object_for_key:@"isLogin" value:@"0"];
    }
}
- (BOOL)isLogin
{
    NSInteger l = [[LConfigCurrent object_value_with_key:@"isLogin"] integerValue];
    if (l) {
        return YES;
    }else
    {
        return NO;
    }
}
//微盘类型
-(void)setVDiskType:(VDiskType)VDiskType
{
    _VDiskType = VDiskType;
    switch (_VDiskType) {
        case VDiskTypeZhongJiang:
        {
            self.VDiskTypeString = @"VDiskTypeZhongJiang";
            self.homeTopTitles = @[@{@"title":@"中江银", @"key":@"AG"},
                                   @{@"title":@"中江油", @"key":@"CO"},
                                   @{@"title":@"中江铜", @"key":@"CU"}];
        }
            break;
        case VDiskTypeZhongHui:
        {
            self.VDiskTypeString = @"VDiskTypeZhongHui";
            self.homeTopTitles = @[@{@"title":@"中汇银", @"key":@"AG"},
                                  @{@"title":@"中汇油", @"key":@"CO"},
                                  @{@"title":@"中汇铜", @"key":@"CU"}];
        }
            break;
        case VDiskTypeYinHe:
        {
            self.VDiskTypeString = @"VDiskTypeYinHe";
            self.homeTopTitles = @[@{@"title":@"银河银", @"key":@"AG"},
                                   @{@"title":@"银河油", @"key":@"CO"},
                                   @{@"title":@"银河铜", @"key":@"CU"}];
        }
            break;
        default:
            break;
    }
    [self initColors];
}
@end
