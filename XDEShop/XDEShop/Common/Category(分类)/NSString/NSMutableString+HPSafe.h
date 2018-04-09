//
//  NSMutableString+Safe.h
//  iOS-Category
//
//  Created by 庄BB的MacBook on 2017/8/24.
//  Copyright © 2017年 BBFC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (HPSafe)

/** 在loc插入aString */
- (void)safeInsertString:(NSString *)aString atIndex:(NSUInteger)loc;

/** 拼接aString */
- (void)safeAppendString:(NSString *)aString;

/** 彻底更换 */
- (void)safeSetString:(NSString *)aString;


- (NSUInteger)safeReplaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange;
@end
