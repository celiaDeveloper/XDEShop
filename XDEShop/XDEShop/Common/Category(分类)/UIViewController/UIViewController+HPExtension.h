//
//  UIViewController+extension.h
//  SLYP
//
//  Created by 秦正华 on 2016/11/17.
//  Copyright © 2016年 马晓明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HPExtension)


/**
 push时设置方法
 */
-(void)pushViewController:(UIViewController *_Nonnull)controller;


/**
 拨打电话
 */
- (void)callPhoneString:(NSString *_Nonnull)phoneNum;

-(void)presentTelPhone;
NS_ASSUME_NONNULL_BEGIN
/**
 快速创建AlertController：包括Alert 和 ActionSheet
 
 @param title       标题文字
 @param message     消息体文字
 @param actions     可选择点击的按钮（不包括取消）
 @param cancelTitle 取消按钮（可自定义按钮文字）
 @param style       类型：Alert 或者 ActionSheet
 @param completion  完成点击按钮之后的回调（不包括取消）
 */
+ (void)showAlertWithTitle: (NSString *)title message: (NSString *)message actionTitles: (NSArray<NSString *> *)actions cancelTitle: (NSString *)cancelTitle style: (UIAlertControllerStyle)style completion: (void(^)(NSInteger index))completion;
NS_ASSUME_NONNULL_END

@end
