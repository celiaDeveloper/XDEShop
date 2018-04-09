//
//  XMRequestTools.m
//  项目初始化模板(TableBarStyle)
//
//  Created by ** on 2017/6/20.
//  Copyright © 2017年 qinzhenghua. All rights reserved.
//

#import "XMNetWorkTools.h"
#import <AFNetworking.h>
#import "UIView+HPProgressHUD.h"
#import "NSString+HPCategory.h"

static XMNetWorkTools *tools = nil;

static AFHTTPSessionManager *manager = nil;

static NetworkStatus _status;

@implementation XMNetWorkTools

#pragma mark - 实现声明单例方法 GCD
//+(instancetype)shareManager{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        tools = [[XMNetWorkTools alloc]init];
//    });
//    return tools;
//}

HPSingleton_implementation(XMNetWorkTools)

#pragma mark - 设置AFHTTPSessionManager相关属性
+ (AFHTTPSessionManager *)createAFHTTPSessionManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];

        //设置请求参数的类型:HTTP (AFJSONRequestSerializer,AFHTTPRequestSerializer)
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //设置请求的超时时间
        manager.requestSerializer.timeoutInterval = 30.f;
        //设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        /**
         *  请求队列的最大并发数
         */
        //    manager.operationQueue.maxConcurrentOperationCount = 5;
        
        /*! 打开状态栏的等待菊花 */
//        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        
        /*! 设置相应的缓存策略：此处选择不用加载也可以使用自动缓存【注：只有get方法才能用此缓存策略，NSURLRequestReturnCacheDataDontLoad】 */
//        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;

        /*! 设置响应数据的基本类型 */
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/xml",@"text/plain", @"application/javascript", @"image/*", nil];
    });
    return manager;
}

#pragma mark - 开始监听网络
+ (void)startMonitoringNetwork
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
                _status(XMNetworkStatusUnknown);
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                _status(XMNetworkStatusNotReachable);
                NSLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                _status(XMNetworkStatusReachableViaWWAN);
                NSLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                _status(XMNetworkStatusReachableViaWiFi);
                NSLog(@"WIFI");
                break;
        }
    }];
    [manager startMonitoring];
}

+ (void)networkStatusWithBlock:(NetworkStatus)status
{
    _status = status;
}

+(void)request:(NSString *)URL method:(XM_Method)method parameters:(NSDictionary *)parameters tipsShow:(UIView *)view finished:(netFinishedBlock)finished
{
    [view showProgress:nil];
    switch (method) {
        case XM_GET:
        {
            [XMNetWorkTools GET:URL parameters:parameters finished:^(id JSON, NSError *error) {
                NSLog(@"%@",JSON);
                if ([JSON[@"error"] intValue] != 0) {
                    [view showMessage:[JSON[@"msg"] decodeUTF8]];
                    return ;
                }
                [view hide];
                finished(JSON,error);
                
            }];
        }
            break;
            
        case XM_POST:
        {
            [XMNetWorkTools POST:URL parameters:parameters finished:^(id JSON, NSError *error) {
                NSLog(@"%@",JSON);
                if ([JSON[@"error"] intValue] != 0) {
                    [view showMessage:[JSON[@"msg"] decodeUTF8]];
                    return ;
                }
                [view hide];
                finished(JSON,error);
                
            }];
        }
            
        default:
            break;
    }
}

#pragma mark - GET请求
+ (XMSessionTask *)GET:(NSString *)URL parameters:(NSDictionary *)parameters finished:(netFinishedBlock)finished
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    manager = [self createAFHTTPSessionManager];
    
    return [manager GET:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if(responseObject){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            finished(dict,nil);
        } else {
            finished(@{@"msg":@"暂无数据"}, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        finished(nil,error);
    }];
}

#pragma mark - POST请求
+ (XMSessionTask *)POST:(NSString *)URL parameters:(NSDictionary *)parameters finished:(netFinishedBlock)finished
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    manager = [self createAFHTTPSessionManager];
    
    return [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if(responseObject){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            finished(dict,nil);
        } else {
            finished(@{@"msg":@"暂无数据"}, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        finished(nil,error);
    }];
}

#pragma mark - 上传图片文件
+ (XMSessionTask *)uploadWithURL:(NSString *)URL parameters:(NSDictionary *)parameters images:(NSArray<UIImage *> *)images name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType progress:(XMProgress)progress finished:(netFinishedBlock)finished
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    manager = [self createAFHTTPSessionManager];
    return [manager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //压缩-添加-上传图片
        
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *imageData = [NSData data];
            if (UIImagePNGRepresentation(image) == nil) {
                imageData = UIImageJPEGRepresentation(image, 1);
            } else {
                imageData = UIImagePNGRepresentation(image);
            }
            
            [formData appendPartWithFileData:imageData name:name fileName:[NSString stringWithFormat:@"%@%ld.%@",fileName,idx,mimeType?mimeType:@"jpeg"] mimeType:[NSString stringWithFormat:@"image/%@",mimeType?mimeType:@"jpeg"]];
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        progress ? progress(uploadProgress) : nil;
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        finished(dict,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        finished(nil,error);
    }];
}

#pragma mark - 下载文件
+ (XMSessionTask *)downloadWithURL:(NSString *)URL fileDir:(NSString *)fileDir progress:(XMProgress)progress finished:(netFinishedBlock)finished
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    manager = [self createAFHTTPSessionManager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        progress ? progress(downloadProgress) : nil;
        NSLog(@"下载进度:%.2f%%",100.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        error ? finished(filePath.absoluteString,nil) : finished(nil,error);;
    }];
    
    //开始下载
    [downloadTask resume];
    
    return downloadTask;
}





@end
