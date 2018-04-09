//
//  QZHProgressHUD.h
//  SLYP
//
//  Created by 秦正华 on 2016/11/25.
//  Copyright © 2016年 马晓明. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

typedef NS_ENUM(NSInteger, HPProgressHUDMode) {
    /** 成功 */
    HPProgressHUDModeSuccess,
    /** 失败 */
    HPProgressHUDModeError,
    /** 提示 */
    HPProgressHUDModeMessage,
    /** 等待 */
    HPProgressHUDModeWaitting,
    /** 进度 */
    HPProgressHUDModeProgress
};

@interface HPProgressHUD : NSObject

@property (nonatomic,strong) MBProgressHUD  *hud;

/** 是否正在显示 */
@property (nonatomic, assign, getter=isShowNow) BOOL showNow;

/** 进度的进展,从0.0到1.0。默认为0.0 */
@property (assign, nonatomic) float progress;

/** 返回一个 HUD 的单例 */
+(instancetype)shareHUD;

/** 立即隐藏 */
+(void)hide;

/** 多长时间后执行隐藏 */
+(void)hideAfter:(CGFloat)time;

#pragma mark - HUD show window上
/** 在 window 上添加一个只显示文字的 HUD */
+ (void)showMessage:(NSString *)text;

/** 在 window 上添加一个提示`失败`的 HUD */
+ (void)showFailure:(NSString *)text;

/** 在 window 上添加一个提示`成功`的 HUD */
+ (void)showSuccess:(NSString *)text;

/** 在 window 上添加一个提示`等待`的 HUD, 需要手动关闭 */
+ (void)showLoading:(NSString *)text;


#pragma mark - HUD show 指定view上
/** 在 指定view 上添加一个只显示文字的 HUD */
+ (void)showMessage:(NSString *)text inView:(UIView *)view;

/** 在 指定view 上添加一个提示`失败`的 HUD */
+ (void)showFailure:(NSString *)text inView:(UIView *)view;

/** 在 指定view 上添加一个提示`成功`的 HUD */
+ (void)showSuccess:(NSString *)text inView:(UIView *)view;

/** 在 指定view 上添加一个提示`等待`的 HUD, 需要手动关闭 */
+ (void)showLoading:(NSString *)text inView:(UIView *)view;

/** 在 指定view 上添加一个提示`进度`的 HUD */
+ (void)showProgress:(NSString *)text inView:(UIView *)view;


@end
