//
//  Core+Color.h
//  ZhongJiangVDisk
//
//  Created by liuxiaomin on 16/8/11.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "Core.h"

@interface Core (Color)

- (void)initColors;
- (UIImage *)image_with_color:(UIColor *)color;
- (NSDictionary *)colorsDictionary;
@end
