//
//  HPApiSender.m
//  HP_iOS_CommonFrame
//
//  Created by 秦正华 on 2017/8/24.
//  Copyright © 2017年 zhijianshangcheng. All rights reserved.
//

#import "HPApiSender.h"
#import <objc/runtime.h>
NSString const *requestKey                 = @"requestKey";
#define sender [HPApiSender shareApiSender]

@implementation HPApiSender

+(instancetype)shareApiSender{
    
    static HPApiSender *ApiSender;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        ApiSender =[[HPApiSender alloc]init];

    });
    
    return ApiSender;
}

+ (void)commit:(sendBlock)commit finished:(finishedBlock)finished
{
    HPRequestCenter *request = [[HPRequestCenter alloc] init];
    !commit ? : commit(request);
    !request.contentView ? : [HPProgressHUD showLoading:nil inView:request.contentView];
    
    switch (request.type) {
            
        case HPHttpRequestTypeGet:
        {
            [HPNetManager GETWithUrlString:request.url isNeedCache:request.isNeedCache parameters:request.parameter successBlock:^(id response) {
                
                !request.contentView ? : [HPProgressHUD hide];
                
                //TODO:接口请求成功,后台返回error信息的判定
                if ([response[@"error"] intValue] != 0) {
                    request.errorInfo = response[@"info"];
                    request.status = HPRequestResultReturnError;
                    return ;
                }
                request.status = HPRequestResultSuccess;
                //TODO:请求成功,回调数据
                finished(response);
                
            } failureBlock:^(NSError *error) {
                !request.contentView ? : [HPProgressHUD hide];
                request.status = HPRequestResultNoNet;
                __block HPRequestCenter *blockRequest = request;
                request.reconnectView.reconnectBlock = ^{
                    blockRequest.status = HPRequestResultSuccess;
                    [self commit:commit finished:finished];
                };

            } progressBlock:nil];
        }
            break;
            
        case HPHttpRequestTypePost:
        {
            [HPNetManager POSTWithUrlString:request.url isNeedCache:request.isNeedCache parameters:request.parameter successBlock:^(id response) {
                
                !request.contentView ? : [HPProgressHUD hide];
                
                //TODO:接口请求成功,后台返回error信息的判定
                if ([response[@"error"] intValue] != 0) {
                    !request.contentView ? : [HPProgressHUD showMessage:response[@"info"] inView:request.contentView];
                    return ;
                }
                request.status = HPRequestResultSuccess;
                //TODO:请求成功,回调数据
                finished(response);
                
            } failureBlock:^(NSError *error) {
                !request.contentView ? : [HPProgressHUD hide];
                request.status = HPRequestResultNoNet;
                __block HPRequestCenter *blockRequest = request;
                request.reconnectView.reconnectBlock = ^{
                    blockRequest.status = HPRequestResultSuccess;
                    [self commit:commit finished:finished];
                };
                
            } progressBlock:nil];
        }
            break;
            
        default:
            break;
    }
}


+ (void)commit:(sendBlock)commit success:(successBlock)success failure:(failureBlock)failure
{
    HPRequestCenter *request = [[HPRequestCenter alloc] init];
    
    !commit ? : commit(request);
    
    !request.contentView ? : [HPProgressHUD showLoading:nil inView:request.contentView];
    
    switch (request.type) {
            
        case HPHttpRequestTypeGet:
        {
            [HPNetManager GETWithUrlString:request.url isNeedCache:request.isNeedCache parameters:request.parameter successBlock:^(id response) {
                
                !request.contentView ? : [HPProgressHUD hide];
                
                //TODO:请求成功,回调数据
                success(response,[response[@"error"] intValue]);
                
                //TODO:接口请求成功,后台返回error信息的判定
                if ([response[@"error"] intValue] != 0) {
                    request.errorInfo = response[@"info"];
                    request.status = HPRequestResultReturnError;
                    return ;
                }
                request.status = HPRequestResultSuccess;
                
            } failureBlock:^(NSError *error) {
                !request.contentView ? : [HPProgressHUD hide];
                if (failure) {
                    failure(request,error);
                }else{
                    request.status = HPRequestResultNoNet;
                    __block HPRequestCenter *blockRequest = request;
                    request.reconnectView.reconnectBlock = ^{
                        blockRequest.status = HPRequestResultSuccess;
                        [self commit:commit success:success failure:failure];
                    };
                }
            } progressBlock:nil];
        }
            break;
            
        case HPHttpRequestTypePost:
        {
            [HPNetManager POSTWithUrlString:request.url isNeedCache:request.isNeedCache parameters:request.parameter successBlock:^(id response) {
                
                !request.contentView ? : [HPProgressHUD hide];
                
                //TODO:请求成功,回调数据
                success(response,[response[@"error"] intValue]);
                
                //TODO:接口请求成功,后台返回error信息的判定
                if ([response[@"error"] intValue] != 0) {
                    request.errorInfo = response[@"info"];
                    request.status = HPRequestResultReturnError;
                    return ;
                }
                request.status = HPRequestResultSuccess;

            } failureBlock:^(NSError *error) {
                
                !request.contentView ? : [HPProgressHUD hide];
                if (failure) {
                    failure(request,error);
                }else{
                    request.status = HPRequestResultNoNet;
                    __block HPRequestCenter *blockRequest = request;
                    request.reconnectView.reconnectBlock = ^{
                        blockRequest.status = HPRequestResultSuccess;
                        [self commit:commit success:success failure:failure];
                    };
                }
                
            } progressBlock:nil];
        }
            break;
            
        default:
            break;
    }
}


@end
