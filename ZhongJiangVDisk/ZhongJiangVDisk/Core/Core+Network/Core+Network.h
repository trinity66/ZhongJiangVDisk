//
//  Core+Network.h
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/12.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "Core.h"

typedef void(^networkResultBlock)(BOOL success, id result, NSError* error, NSURLResponse* response);
typedef void(^networkProgressBlock)(NSProgress *uploadProgress);
@interface Core (Network)
- (NSURLSessionDataTask *)requestWithURL:(NSString *)url resultBlock:(networkResultBlock)resultBlock;
@end
