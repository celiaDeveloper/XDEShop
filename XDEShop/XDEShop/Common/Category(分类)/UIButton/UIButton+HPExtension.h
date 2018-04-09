//
//  UIButton+extension.h
//  SLYP
//
//  Created by 秦正华 on 2016/11/16.
//  Copyright © 2016年 马晓明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (HPExtension)


/**
 创建文字btn
 */
+ (instancetype)initButtonTitleFont:(CGFloat)font titleColor:(UIColor *)color titleName:(NSString *)name;

- (void)setButtonTitleFont:(CGFloat)font titleColor:(UIColor *)color titleName:(NSString *)name;

/**
 创建文字图片btn
 */
+ (instancetype)initButtonTitleFont:(CGFloat)font titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backColor imageName:(NSString *)imageName titleName:(NSString *)titleName;

- (void)setButtonTitleFont:(CGFloat)font titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backColor imageName:(NSString *)imageName titleName:(NSString *)titleName;


/**
 创建文字圆角btn
 */
+ (instancetype)initButtonTitleFont:(CGFloat)font titleColor:(UIColor *)titleColor titleName:(NSString *)titleName backgroundColor:(UIColor *)backColor radius:(CGFloat)radius;

- (void)setButtonTitleFont:(CGFloat)font titleColor:(UIColor *)titleColor titleName:(NSString *)titleName backgroundColor:(UIColor *)backColor radius:(CGFloat)radius;

/**
 UIButton：自定义 button 点击事件，默认：UIControlEventTouchUpInside
 
 @param target target
 @param tag tag
 @param action action
 */
- (void)addTarget:(id)target tag:(NSInteger)tag action:(SEL)action;

@end

@interface UIButton (EnlargeTouchArea)

/**
 *  扩大 UIButton 的點擊範圍
 *  控制上下左右的延長範圍
 *
 *  @param top    -
 *  @param right  -
 *  @param bottom -
 *  @param left   -
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end
