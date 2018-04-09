//
//  UIView+extension.h
//  NBWeiBo
//
//  Created by apple on 15/6/13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HPCategory)

#pragma mark - 创建View
/**
 创建view

 @param color view背景颜色
 @return view
 */
+ (instancetype)initViewBackColor:(UIColor *)color;


/**
 创建line

 @param color 颜色
 @param width 宽度
 @param height 高度
 @param originY Y值
 @return view
 */
+ (instancetype)initLineBackColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height maxY:(CGFloat)originY;

//把View加在Window上
- (void) addToWindow;

#pragma mark - 添加点击任务
/** 添加点击手势 */
- (void)addTarget:(id)target action:(SEL)action;



#pragma mark - layer

/** 设置圆角 */
- (void)rounded:(CGFloat)cornerRadius;

/** 设置边框 */
- (void)border:(CGFloat)borderWidth color:(UIColor *)borderColor;

/** 设置圆角和边框 */
- (void)rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor;

/** 给哪几个角设置圆角 */
- (void)rounded:(CGFloat)cornerRadius rectCorners:(UIRectCorner)rectCorner;

/** 设置阴影 */
- (void)shadow:(UIColor *)shadowColor opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset;


#pragma mark - 获取View所属的控制器
/**
 获取view所属控制器
 
 @return 控制器
 */
- (UIViewController *)belongViewController;


@end
