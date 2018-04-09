//
//  NSObject+JSON.m
//  SCGoJD
//
//  Created by mac on 15/9/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "NSObject+HPJSON.h"
#import <MJExtension/MJExtension.h>

@implementation NSObject (HPJSON)

- (NSString *)JSONString {
    
    NSData *JSONData = nil;
    // 如果self是NSDictionary
    if ([self isKindOfClass:[NSDictionary class]]) {
        
        JSONData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    }
    // 如果self是继承NSObject的非字典对象
    else if ([self isKindOfClass:[NSObject class]]) {
     
        JSONData = [NSJSONSerialization dataWithJSONObject:self.keyValues options:NSJSONWritingPrettyPrinted error:nil];
    }
    
    return [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
}



@end
