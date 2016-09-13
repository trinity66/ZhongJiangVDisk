//
//  Core+Network.m
//  ZhongJiangVDisk
//
//  Created by shijian01 on 16/9/12.
//  Copyright © 2016年 liuxiaomin. All rights reserved.
//

#import "Core+Network.h"


@implementation Core (Network)
- (NSDictionary *)candleParams:(NSDictionary*)params
{
    NSString* _params = [[LConfigCurrent toJsonWithParams:params] base64_encode];
    NSUInteger str_length = 10;
    
    NSRange rg = {0,str_length};
    NSString* sub_front = [_params substringWithRange:rg];
    
    rg.location = str_length;
    NSString* middle = [_params substringWithRange:rg];
    
    NSString* end_behind = [_params substringFromIndex:str_length * 2];
    NSString* full_params = [[NSString stringWithFormat:@"%@%@%@", middle, sub_front, end_behind] base64_encode];
    NSMutableDictionary* common_params = [NSMutableDictionary dictionary];
    
    [common_params setObject:@101 forKey:@"source"];//101
    NSString* current_time = [NSDate get_current_time];
    [common_params setObject:current_time forKey:@"time"];
    [common_params setObject:@"zh_CN" forKey:@"lang"];
    [common_params setObject:full_params forKey:@"params"];
    
    NSString* sign = [[NSString stringWithFormat:@"%@%@", [[NSString stringWithFormat:@"%@%@",full_params,current_time] md5], APP_KEY] md5];
    [common_params setObject:sign forKey:@"sign"];
    
    [common_params setObject:[NSString app_version] forKey:@"version"];
    [common_params setObject:[[[UIDevice currentDevice]identifierForVendor] UUIDString] forKey:@"device_udid"];
    return common_params;
}

- (NSURLSessionDataTask *)requestWithMethod:(NSString *)method module:(NSString *)module params:(NSDictionary *)params resultBlock:(networkResultBlock)resultBlock {
    if ([self networkEnabled]) {
        NSString *url = [kBaseURL stringByAppendingPathComponent:module];
        NSDictionary *candledParams = [self candleParams:params];
        NSError* err = nil;
        NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer] requestWithMethod:method URLString:url parameters:candledParams error:&err];
        request.timeoutInterval = kTimeOutCount;
        AFURLSessionManager* manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        NSURLSessionDataTask* task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id response_object, NSError *error) {
            
        }];
        [task resume];
        return task;
    }
    return nil;
}
- (NSURLSessionDataTask *)requestWithMethod:(NSString *)method module:(NSString *)module params:(NSDictionary *)params filePath:(NSString *)filePath fileRequestName:(NSString *)fileRequestName mime_type:(NSString*)mime_type  progressBlock:(networkProgressBlock)progressBlock resultBlock:(networkResultBlock)resultBlock {
    if ([self networkEnabled]) {
        NSString *url = [kBaseURL stringByAppendingPathComponent:module];
        NSDictionary *candledParams = [self candleParams:params];
        NSError* err = nil;
        if(mime_type == nil)
        {
            mime_type = @"image/jpeg";
        }
        NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:method URLString:url parameters:candledParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:fileRequestName fileName:[filePath lastPathComponent] mimeType:mime_type error:nil];
        } error:&err];
        request.timeoutInterval = kTimeOutCount;
        AFURLSessionManager* manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSURLSessionUploadTask *task = [manager
                                        uploadTaskWithStreamedRequest:request
                                        progress:progressBlock
                                        completionHandler:^(NSURLResponse *response, id response_object, NSError *error) {
                                            [self candleHandlerWithReaponse:response response_object:response_object error:error resultBlock:resultBlock];
                                        }];
        [task resume];
        return task;
    }
    return nil;
}
- (void)candleHandlerWithReaponse:(NSURLResponse *)response response_object:(id)response_object error:(NSError*)error resultBlock:(networkResultBlock)resultBlock
{
    resultBlock((error ? NO : YES), nil, error, response);
}
- (BOOL)networkEnabled
{
    if ([AFNetworkReachabilityManager sharedManager].reachable) {
        return YES;
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前网络不可用，请检查网络设置" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alert show];
        return NO;
    }
}


@end