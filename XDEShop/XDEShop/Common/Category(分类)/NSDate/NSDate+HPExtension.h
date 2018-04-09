//
//  NSDate+Extension.h
//  SLYP
//
//  Created by 秦正华 on 2017/5/22.
//  Copyright © 2017年 秦正华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HPExtension)

/** 通过时间戳计算时间差（几小时前、几天前 */
+ (NSString *) compareCurrentTime:(NSTimeInterval) compareDate;

/** 通过时间戳显示时间(自定义formatter)*/
+ (NSString *) getStringWithTimestamp:(NSTimeInterval)timestamp formatter:(NSString*)formatter;

/**
 获取当前日期
 yyy-MM-dd
 
 @param time -
 @return -
 */
+ (NSString *)getCurrentTimeToDay:(NSTimeInterval )time;

/**
 获取当前时间 time 秒以后的时间 
 yyy-MM-dd HH:mm:ss

 @param time -
 @return -
 */
+ (NSString *)getCurrentTimeToSec:(NSTimeInterval )time;

/**
 根据时间戳 获取时间

 @param time -
 @return -
 */
+ (NSString *)timeFromStamp:(NSTimeInterval )time;

/**
 获取当前时间的时间戳

 @return -
 */
+ (NSString *)getCurrentTimeStamp;

/**
 时间转换为时间戳

 @param time -
 @return -
 */
+ (NSString *)stampFromTime:(NSString *)time;



@end
