//
//  LCategory.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/12.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "LCategory.h"
#import <CocoaSecurity/CocoaSecurity.h>

@implementation NSString (extend)
- (NSString*)md5
{
    CocoaSecurityResult* e = [CocoaSecurity md5:self];
    return e.hexLower;
}

- (NSString*)base64_encode
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    CocoaSecurityEncoder* e = [[CocoaSecurityEncoder alloc] init];
    return [e base64:data];
}

- (NSString*)base64_decode
{
    CocoaSecurityDecoder* e = [[CocoaSecurityDecoder alloc] init];
    NSString* ret = [[NSString alloc] initWithData:[e base64:self] encoding:NSUTF8StringEncoding];
    return ret;
}
+ (NSString*)app_version
{
    NSDictionary* info = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [info objectForKey:@"CFBundleShortVersionString"];
    //NSLog(@"appver:%@",version);
    return version;
}
@end



@implementation UIImage (extend)
- (UIImage *) imageWithTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}
@end


@implementation NSDate (extend)
+ (NSString*)get_current_time
{
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    NSDate* today = [NSDate date];
    [fmt setDateFormat:@"yyyyMMddHHmmss"];
    NSString* date = [fmt stringFromDate:today];
    return date;
}
@end


















