//
//  LConfig.m
//  JuCaiEmployee
//
//  Created by renpan on 16/3/17.
//  Copyright © 2016年 HangZhouShangFu. All rights reserved.
//

#import "LConfig.h"


#define LConfigFileName    @"config.json"

@interface LConfig ()
@property (nonatomic, strong) NSString* file_path;
@end

@implementation LConfig
+(LConfig *)current
{
    static LConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[LConfig alloc] init];
        [config init_data];
    });
    return config;
}
- (void)init_data
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *realPath = [documentPath stringByAppendingPathComponent:LConfigFileName];
    _file_path = realPath;
}

- (void)clear
{
    NSFileManager* fm = [NSFileManager defaultManager];
    if([fm fileExistsAtPath:_file_path])
    {
        [fm removeItemAtPath:_file_path error:nil];
    }
}

- (NSMutableDictionary*)read_file_to_object
{
    NSDictionary* ob = [self toObject];
    return [NSMutableDictionary dictionaryWithDictionary:ob];
}
- (BOOL)write_object_to_file:(NSDictionary*)ob
{
    return [[self toJsonWithParams:ob] writeToFile:_file_path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (NSDictionary*)config_with_all_key_value
{
    return [self read_file_to_object];
}

- (void)set_object_for_key:(id)key value:(id)value
{
    NSMutableDictionary* ob = [self read_file_to_object];
    [ob setObject:value forKey:key];
    [self write_object_to_file:ob];
}

- (id)object_value_with_key:(NSString*)key
{
    NSMutableDictionary* ob = [self read_file_to_object];
    id value = [ob objectForKey:key];
    return value;
}

- (BOOL)remove_item_with_key:(NSString*)key
{
    NSMutableDictionary* ob = [self read_file_to_object];
    [ob removeObjectForKey:key];
    return [self write_object_to_file:ob];
}
//手势相关

- (void)setBool:(BOOL)value forKey:(NSString *)defaultName
{
    [self set_object_for_key:defaultName value:[NSNumber numberWithBool:value]];
}
- (BOOL)boolForKey:(NSString *)defaultName
{
    id object = [self object_value_with_key:defaultName];
    if(object == nil)
    {
        return NO;
    }
    return [object boolValue];
}
//对象转为JSON字符串
- (NSString *)toJsonWithParams:(id)params
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    if (data) {
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return jsonString;
    }else
    {
        return nil;
    }
}
- (id)toObject
{
    NSString *jsonString = [NSString stringWithContentsOfFile:_file_path encoding:NSUTF8StringEncoding error:nil];
    if (jsonString) {
        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        return object;
    }else
    {
        return [NSMutableDictionary dictionary];
    }
    
}


@end
