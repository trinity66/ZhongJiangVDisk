//
//  LCategory.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/12.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(extend)
- (NSString *)md5;
- (NSString*)base64_encode;
- (NSString*)base64_decode;
+ (NSString*)app_version;
@end

@interface UIImage (extend)
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;
@end

@interface NSDate (extend)
+ (NSString*)get_current_time;
@end
