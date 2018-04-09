//
//  HPApiSender.h
//  HP_iOS_CommonFrame
//
//  Created by 秦正华 on 2017/8/24.
//  Copyright © 2017年 zhijianshangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPNetManager.h"
#import "HPRequestCenter.h"

/** 发送相关接口参数 */
typedef void(^sendBlock)(HPRequestCenter *request);

/** 请求完成的Block */
typedef void(^finishedBlock)(id JSON);

/** 请求成功的Block */
typedef void(^successBlock)(id JSON,int error);

/*! 请求失败的 block */
typedef void( ^failureBlock)(HPRequestCenter *request,NSError *error);

@interface HPApiSender : NSObject

/** 相当于变量,重新连接用此变量,非重新连接重新创建对象 */
@property(nonatomic,strong)HPRequestCenter *request;

/** 单例,用于调用此对象属性 */
+(instancetype)shareApiSender;

/**  */
/**
 网络请求调用方法

 @param commit 传递设置参数block
 @param finished 回调数据block
 */
+(void)commit:(sendBlock)commit finished:(finishedBlock)finished;


/**
 网络请求调用方法(返回多参数)

 @param commit 提交参数request
 @param success 请求成功的block(return JSON和接口error)
 @param failure 请求失败的block(failure为nil默认显示重新加载视图,否则return request类和NSError),一般接口错误,服务器错误,网络问题
 */
+ (void)commit:(sendBlock)commit success:(successBlock)success failure:(failureBlock)failure;



@end
