//
//  NSString+Safe.h
//  iOS-Category
//
//  Created by 庄BB的MacBook on 2017/8/24.
//  Copyright © 2017年 BBFC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HPSafe)

/** 从from开始截取 */
- (NSString *)safeSubstringFromIndex:(NSUInteger)from;

/** 截取到to */
- (NSString *)safeSubstringToIndex:(NSUInteger)to;

/** 截取range范围 */
- (NSString *)safeSubstringWithRange:(NSRange)range;

/** 获取aString范围 */
- (NSRange)safeRangeOfString:(NSString *)aString;

/** 根据条件查询aString范围 */
- (NSRange)safeRangeOfString:(NSString *)aString options:(NSStringCompareOptions)mask;

/** 拼接aString */
- (NSString *)safeStringByAppendingString:(NSString *)aString;

@end
