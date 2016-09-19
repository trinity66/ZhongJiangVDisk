//
//  LConfig.h
//  JuCaiEmployee
//
//  Created by renpan on 16/3/17.
//  Copyright © 2016年 HangZhouShangFu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LConfig : NSObject
+(LConfig *)current;
- (NSString *)toJsonWithParams:(id)params;

- (void)clear;
- (NSDictionary*)config_with_all_key_value;
- (void)set_object_for_key:(id)key value:(id)value;
- (id)object_value_with_key:(NSString*)key;
- (BOOL)remove_item_with_key:(NSString*)key;
@end
