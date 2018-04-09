//
//  HPApiRequest.h
//  HP_iOS_CommonFrame
//
//  Created by 秦正华 on 2017/8/10.
//  Copyright © 2017年 zhijianshangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPReconnectView.h"
#import "HPProgressHUD.h"
#import "HPNetManager.h"

typedef NS_ENUM(NSUInteger, HPRequestResultStatus) {
    
    HPRequestResultNoNet,        //请求中无网络
    
    HPRequestResultReturnError,  //请求失败
    
    HPRequestResultSuccess,      //请求成功
};

@interface HPRequestCenter : NSObject

/** 提交请求类型 */
@property(nonatomic,assign)HPHttpRequestType type;

/** 提交接口参数 */
@property(nonatomic,strong)NSDictionary * parameter;

/** 接口地址 */
@property(nonatomic,strong)NSString * url;

/** 是否需要缓存 */
@property(nonatomic,assign)BOOL isNeedCache;

/** 数据呈现的视图 */
@property(nonatomic,strong)UIView * contentView;

/** 请求状态 */
@property(nonatomic,assign)HPRequestResultStatus status;

/** 后台返回的error信息 */
@property(nonatomic,strong)NSString * errorInfo;

/** 重新连接视图 */
@property(nonatomic,strong)HPReconnectView * reconnectView;

@end



