//
//  HPNetManagerCache.h
//  项目初始化模板
//
//  Created by 秦正华 on 2017/8/24.
//  Copyright © 2017年 qinzhenghua. All rights reserved.
//
// 此缓存框架采用网络开源缓存框架


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HPNetManagerCache : NSObject

/**
 异步缓存网络数据,根据请求的 url 与 parameters
 
 @param httpData 服务器返回的数据
 @param urlString 请求的 URL 地址
 @param parameters 请求的参数
 */
+ (void)setHttpCache:(id)httpData
              urlString:(NSString *)urlString
             parameters:(NSDictionary *)parameters;

/**
 根据请求的 URL 与 parameters 异步取出缓存数据
 
 @param urlString 请求的URL
 @param parameters 请求的参数
 @return 缓存的服务器数据
 */
+ (id)httpCacheWithUrlString:(NSString *)urlString
                     parameters:(NSDictionary *)parameters;

/**
 根据请求的 URL 与 parameters 异步取出缓存数据
 
 @param urlString 请求的URL
 @param parameters 请求的参数
 @param block 异步回调缓存的数据
 */
+ (void)httpCacheWithUrlString:(NSString *)urlString
                       parameters:(NSDictionary *)parameters block:(void(^)(id <NSCoding> responseObject))block;

+ (NSString *)cacheWithUrlString:(NSString *)urlString
                         parameters:(NSDictionary *)parameters;

/**
 返回此缓存中对象的总成本（以M为单位）。
   此方法可能阻止调用线程，直到文件读取完成。
 
 @return 总对象的大小（以M为单位）。
 */
+ (CGFloat)getAllHttpCacheSize;

/**
 清空缓存：此方法可能会阻止调用线程，直到文件删除完成。
 */
+ (void)clearAllHttpCache;

@end
