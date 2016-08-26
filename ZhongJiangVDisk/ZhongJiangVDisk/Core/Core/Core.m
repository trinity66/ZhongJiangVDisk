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
-(void)setVDiskType:(VDiskType)VDiskType
{
    _VDiskType = VDiskType;
    if (_VDiskType == VDiskTypeZhongJiang) {
        self.VDiskTypeString = @"VDiskTypeZhongJiang";
    }
    if (_VDiskType == VDiskTypeZhongHui) {
        self.VDiskTypeString = @"VDiskTypeZhongHui";
    }
    [self initColors];
}
@end
