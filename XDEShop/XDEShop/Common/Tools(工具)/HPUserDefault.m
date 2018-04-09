//
//  XMUserDefault.m
//  项目初始化模板(TableBarStyle)
//
//  Created by 秦正华 on 2017/4/19.
//  Copyright © 2017年 qinzhenghua. All rights reserved.
//

#import "HPUserDefault.h"

static NSString *const kArrayKey = @"array";

@implementation HPUserDefault

+ (void)addUserDefaultArrayFromStr:(NSString *)text {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *array = [userDefaults arrayForKey:kArrayKey];
    
    if (array.count > 0) {} else {array = [NSArray array];}
    
    NSMutableArray *mutableArray = [array mutableCopy];
    [mutableArray addObject:text];
    if (mutableArray.count > 4) {
        [mutableArray removeObjectAtIndex:0];
    }
    
    [userDefaults setObject:mutableArray forKey:kArrayKey];
    [userDefaults synchronize];
}

+ (NSArray *)arrayForKey {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    return [userDefault arrayForKey:kArrayKey];
}

+ (void)removeAllArray {
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:kArrayKey];
    [userDefault synchronize];
}


+ (void)removeUserDefaultObjectFromKey:(NSString *)key {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault removeObjectForKey:key];
    
    [userDefault synchronize];
}

+ (id)objectForKey:(NSString *)key {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    return  [userDefault objectForKey:key];
    
}

+ (void)addUserDefaultObject:(id)object key:(NSString *)key {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:object forKey:key];
    
    [userDefault synchronize];
}

@end
