//
//  HPNetManager.h
//  项目初始化模板
//
//  Created by 秦正华 on 2017/8/24.
//  Copyright © 2017年 qinzhenghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define HPNetManagerShare [HPNetManager sharedHPNetManager]

#define HPWeak  __weak __typeof(self) weakSelf = self

/*! 过期属性或方法名提醒 */
#define HPNetManagerDeprecated(instead) __deprecated_msg(instead)


/*! 使用枚举NS_ENUM:区别可判断编译器是否支持新式枚举,支持就使用新的,否则使用旧的 */
typedef NS_ENUM(NSUInteger, HPNetworkStatus)
{
    /*! 未知网络 */
    HPNetworkStatusUnknown           = 0,
    /*! 没有网络 */
    HPNetworkStatusNotReachable,
    /*! 手机 3G/4G 网络 */
    HPNetworkStatusReachableViaWWAN,
    /*! wifi 网络 */
    HPNetworkStatusReachableViaWiFi
};

/*！定义请求类型的枚举 */
typedef NS_ENUM(NSUInteger, HPHttpRequestType)
{
    /*! get请求 */
    HPHttpRequestTypeGet = 0,
    /*! post请求 */
    HPHttpRequestTypePost,
    /*! put请求 */
    HPHttpRequestTypePut,
    /*! delete请求 */
    HPHttpRequestTypeDelete
};

typedef NS_ENUM(NSUInteger, HPHttpRequestSerializer) {
    /** 设置请求数据为JSON格式*/
    HPHttpRequestSerializerJSON,
    /** 设置请求数据为HTTP格式*/
    HPHttpRequestSerializerHTTP,
};

typedef NS_ENUM(NSUInteger, HPHttpResponseSerializer) {
    /** 设置响应数据为JSON格式*/
    HPHttpResponseSerializerJSON,
    /** 设置响应数据为HTTP格式*/
    HPHttpResponseSerializerHTTP,
};

/*! 实时监测网络状态的 block */
typedef void(^HPNetworkStatusBlock)(HPNetworkStatus status);

/*! 定义请求成功的 block */
typedef void( ^ HPResponseSuccessBlock)(id response);
/*! 定义请求失败的 block */
typedef void( ^ HPResponseFailBlock)(NSError *error);

/*! 定义上传进度 block */
typedef void( ^ HPUploadProgressBlock)(int64_t bytesProgress,
int64_t totalBytesProgress);
/*! 定义下载进度 block */
typedef void( ^ HPDownloadProgressBlock)(int64_t bytesProgress,
int64_t totalBytesProgress);

/*!
 *  方便管理请求任务。执行取消，暂停，继续等任务.
 *  - (void)cancel，取消任务
 *  - (void)suspend，暂停任务
 *  - (void)resume，继续任务
 */
typedef NSURLSessionTask HPURLSessionTask;


@interface HPNetManager : NSObject

/**
 创建的请求的超时间隔（以秒为单位），此设置为全局统一设置一次即可，默认超时时间间隔为30秒。
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**
 设置网络请求参数的格式，此设置为全局统一设置一次即可，默认：HPHttpRequestSerializerJSON
 */
@property (nonatomic, assign) HPHttpRequestSerializer requestSerializer;

/**
 设置服务器响应数据格式，此设置为全局统一设置一次即可，默认：HPHttpResponseSerializerJSON
 */
@property (nonatomic, assign) HPHttpResponseSerializer responseSerializer;

/**
 自定义请求头：httpHeaderField
 */
@property(nonatomic, strong) NSDictionary *httpHeaderFieldDictionary;

/*!
 *  获得全局唯一的网络请求实例单例方法
 *
 *  @return 网络请求类HPNetManager单例
 */
+ (instancetype)sharedHPNetManager;


#pragma mark - 网络请求的类方法 --- get / post / put / delete
/**
 网络请求的实例方法 get
 
 @param urlString 请求的地址
 @param isNeedCache 是否需要缓存，只有 get / post 请求有缓存配置
 @param parameters 请求的参数
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progressBlock 进度
 @return HPURLSessionTask
 */
+ (HPURLSessionTask *)GETWithUrlString:(NSString *)urlString
                                      isNeedCache:(BOOL)isNeedCache
                                       parameters:(NSDictionary *)parameters
                                     successBlock:(HPResponseSuccessBlock)successBlock
                                     failureBlock:(HPResponseFailBlock)failureBlock
                                    progressBlock:(HPDownloadProgressBlock)progressBlock;

/**
 网络请求的实例方法 post
 
 @param urlString 请求的地址
 @param isNeedCache 是否需要缓存，只有 get / post 请求有缓存配置
 @param parameters 请求的参数
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progressBlock 进度
 @return HPURLSessionTask
 */
+ (HPURLSessionTask *)POSTWithUrlString:(NSString *)urlString
                                       isNeedCache:(BOOL)isNeedCache
                                        parameters:(NSDictionary *)parameters
                                      successBlock:(HPResponseSuccessBlock)successBlock
                                      failureBlock:(HPResponseFailBlock)failureBlock
                                     progressBlock:(HPDownloadProgressBlock)progressBlock;

/**
 网络请求的实例方法 put
 
 @param urlString 请求的地址
 @param parameters 请求的参数
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progressBlock 进度
 @return HPURLSessionTask
 */
+ (HPURLSessionTask *)PUTWithUrlString:(NSString *)urlString
                                       parameters:(NSDictionary *)parameters
                                     successBlock:(HPResponseSuccessBlock)successBlock
                                     failureBlock:(HPResponseFailBlock)failureBlock
                                    progressBlock:(HPDownloadProgressBlock)progressBlock;

/**
 网络请求的实例方法 delete
 
 @param urlString 请求的地址
 @param parameters 请求的参数
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progressBlock 进度
 @return HPURLSessionTask
 */
+ (HPURLSessionTask *)DELETEWithUrlString:(NSString *)urlString
                                          parameters:(NSDictionary *)parameters
                                        successBlock:(HPResponseSuccessBlock)successBlock
                                        failureBlock:(HPResponseFailBlock)failureBlock
                                       progressBlock:(HPDownloadProgressBlock)progressBlock;

/**
 上传图片(多图)
 
 @param urlString urlString description
 @param parameters 上传图片预留参数---视具体情况而定 可为空
 @param imageArray 上传的图片数组
 @param fileNames 上传的图片数组 fileName
 @param imageType 图片类型，如：png、jpg、gif
 @param imageScale 图片压缩比率（0~1.0）
 @param successBlock 上传成功的回调
 @param failureBlock 上传失败的回调
 @param progressBlock 上传进度
 @return HPURLSessionTask
 */
+ (HPURLSessionTask *)uploadImageWithUrlString:(NSString *)urlString
                                       parameters:(NSDictionary *)parameters
                                       imageArray:(NSArray *)imageArray
                                        fileNames:(NSArray <NSString *>*)fileNames
                                        imageType:(NSString *)imageType
                                       imageScale:(CGFloat)imageScale
                                     successBlock:(HPResponseSuccessBlock)successBlock
                                      failurBlock:(HPResponseFailBlock)failureBlock
                                    progressBlock:(HPUploadProgressBlock)progressBlock;

/**
 视频上传
 
 @param urlString 上传的url
 @param parameters 上传视频预留参数---视具体情况而定 可移除
 @param videoPath 上传视频的本地沙河路径
 @param successBlock 成功的回调
 @param failureBlock 失败的回调
 @param progressBlock 上传的进度
 */
+ (void)uploadVideoWithUrlString:(NSString *)urlString
                         parameters:(NSDictionary *)parameters
                          videoPath:(NSString *)videoPath
                       successBlock:(HPResponseSuccessBlock)successBlock
                       failureBlock:(HPResponseFailBlock)failureBlock
                      progressBlock:(HPUploadProgressBlock)progressBlock;

/**
 文件下载
 
 @param urlString 请求的url
 @param parameters 文件下载预留参数---视具体情况而定 可移除
 @param savePath 下载文件保存路径
 @param successBlock 下载文件成功的回调
 @param failureBlock 下载文件失败的回调
 @param progressBlock 下载文件的进度显示
 @return HPURLSessionTask
 */
+ (HPURLSessionTask *)downLoadFileWithUrlString:(NSString *)urlString
                                        parameters:(NSDictionary *)parameters
                                          savaPath:(NSString *)savePath
                                      successBlock:(HPResponseSuccessBlock)successBlock
                                      failureBlock:(HPResponseFailBlock)failureBlock
                                     progressBlock:(HPDownloadProgressBlock)progressBlock;

/**
 文件上传
 
 @param urlString urlString description
 @param parameters parameters description
 @param fileName fileName description
 @param filePath filePath description
 @param successBlock successBlock description
 @param failureBlock failureBlock description
 @param progressBlock progressBlock description
 @return HPURLSessionTask
 */
+ (HPURLSessionTask *)uploadFileWithUrlString:(NSString *)urlString
                                      parameters:(NSDictionary *)parameters
                                        fileName:(NSString *)fileName
                                        filePath:(NSString *)filePath
                                    successBlock:(HPResponseSuccessBlock)successBlock
                                    failureBlock:(HPResponseFailBlock)failureBlock
                                   progressBlock:(HPUploadProgressBlock)progressBlock;

#pragma mark - 网络状态监测
/*!
 *  开启实时网络状态监测，通过Block回调实时获取(此方法可多次调用)
 */
+ (void)startNetWorkMonitoringWithBlock:(HPNetworkStatusBlock)networkStatus;

#pragma mark - 自定义请求头
/**
 *  自定义请求头
 */
+ (void)setValue:(NSString *)value forHTTPHeaderKey:(NSString *)HTTPHeaderKey;

/**
 删除所有请求头
 */
+ (void)clearAuthorizationHeader;

#pragma mark - 取消 Http 请求
/*!
 *  取消所有 Http 请求
 */
+ (void)cancelAllRequest;

/*!
 *  取消指定 URL 的 Http 请求
 */
+ (void)cancelRequestWithURL:(NSString *)URL;

/**
 清空缓存：此方法可能会阻止调用线程，直到文件删除完成。
 */
- (void)clearAllHttpCache;

@end
