//
//  HPSettingCenter.h
//  ZHDJ
//
//  Created by 秦正华 on 2017/10/26.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPSettingCenter : NSObject

/** 判定通知状态是否开启 */
+(BOOL)notificationIsOpen;

/** 前往当前应用通知系统设置页面 */
+(void)toNoticatonSetCenter;

/** 获取app缓存大小(M) completion回调计算大小 */
+(void)getCacheSizeCompletion:(void(^__nullable)(CGFloat cacheSize))completion;

/** 清除app缓存 completion清除完成后回调 */
+(void)clearCacheSizeCompletion:(void(^__nullable)(void))completion;

/** 获取应用Verison */
+(NSString *_Nullable)getVerisonNum;

/** 获取应用Build */
+(NSString *_Nullable)getBuildNum;

/** 获取应用BuildID */
+(NSString *_Nullable)getBuilderID;

/** 开始时间 */
+(CFAbsoluteTime)startTime;
/** 总共耗时 */
+(CFAbsoluteTime)expendTime:(CFAbsoluteTime)startTime;


@end
