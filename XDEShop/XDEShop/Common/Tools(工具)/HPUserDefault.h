//
//  XMUserDefault.h
//  项目初始化模板(TableBarStyle)
//
//  Created by 秦正华 on 2017/4/19.
//  Copyright © 2017年 qinzhenghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPUserDefault : NSObject

+ (void)addUserDefaultObject:(id _Nullable )object   key:(NSString *_Nullable)key;

+ (void)removeUserDefaultObjectFromKey:(NSString *_Nullable)key;

+ (id _Nullable )objectForKey:(NSString *_Nullable)key;



+ (void)addUserDefaultArrayFromStr:(NSString *_Nullable)text;

+ (NSArray *_Nullable)arrayForKey;

+ (void)removeAllArray;


@end
