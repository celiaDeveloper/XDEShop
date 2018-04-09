//
//  XMRequestTools.h
//  项目初始化模板(TableBarStyle)
//
//  Created by ** on 2017/6/20.
//  Copyright © 2017年 qinzhenghua. All rights reserved.
//
/*! 过期属性或方法名提醒 */
#define XDNetManagerDeprecated(instead) __deprecated_msg(instead)

#import <Foundation/Foundation.h>
#import "HPSingleton.h"

typedef NS_ENUM(NSUInteger, XM_Method) {
    XM_GET = 0,
    XM_POST = 1,
};

typedef NS_ENUM(NSUInteger, XMNetworkStatus) {
    /** 未知网络*/
    XMNetworkStatusUnknown,
    /** 无网络*/
    XMNetworkStatusNotReachable,
    /** 手机网络*/
    XMNetworkStatusReachableViaWWAN,
    /** WIFI网络*/
    XMNetworkStatusReachableViaWiFi
};

/** 请求成功的Block */
typedef void(^netFinishedBlock)(id JSON,NSError *error);

/** 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小*/
typedef void (^XMProgress)(NSProgress *progress);

/** 网络状态的Block*/
typedef void(^NetworkStatus)(XMNetworkStatus status);

/** 请求任务 */
typedef NSURLSessionTask XMSessionTask;


@interface XMNetWorkTools : NSObject

/**
 *  声明单例方法
 */
//+(instancetype)shareManager;

HPSingleton_interface(XMNetWorkTools)
/**
 *  开始监听网络状态
 */
+ (void)startMonitoringNetwork;

/**
 *  实时获取网络状态回调
 */
+ (void)networkStatusWithBlock:(NetworkStatus)status;


/**
 针对接口error != 0 时的提示并return 否则block将数据带走
 */
+(void)request:(NSString *)URL method:(XM_Method)method parameters:(NSDictionary *)parameters tipsShow:(UIView *)view finished:(netFinishedBlock)finished;


+ (XMSessionTask *)GET:(NSString *)URL parameters:(NSDictionary *)parameters finished:(netFinishedBlock)finished;

+ (XMSessionTask *)POST:(NSString *)URL parameters:(NSDictionary *)parameters finished:(netFinishedBlock)finished;

+ (XMSessionTask *)uploadWithURL:(NSString *)URL parameters:(NSDictionary *)parameters images:(NSArray<UIImage *> *)images name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType progress:(XMProgress)progress finished:(netFinishedBlock)finished;

+ (XMSessionTask *)downloadWithURL:(NSString *)URL fileDir:(NSString *)fileDir progress:(XMProgress)progress finished:(netFinishedBlock)finished;

@end
