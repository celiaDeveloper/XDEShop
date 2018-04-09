//
//  UITableView+HPTableView.h
//  HPCurrentFrameTest
//
//  Created by Celia on 2017/8/15.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (HPTableView)

/**
 类方法创建一个TableView
 */
+ (instancetype)initFrame:(CGRect)frame style:(UITableViewStyle)style backgroundColor:(UIColor *)bgColor;

/**
 类方法创建一个TableView
 frame + style + bgColor + separatorStyle
 */
+ (instancetype)initFrame:(CGRect)frame style:(UITableViewStyle)style backgroundColor:(UIColor *)bgColor separatorStyle:(UITableViewCellSeparatorStyle)sepStyle;

/**
 类方法创建一个TableView
 frame + style + bgColor + headerView
 */
+ (instancetype)initFrame:(CGRect)frame style:(UITableViewStyle)style backgroundColor:(UIColor *)bgColor headerView:(UIView *)headerView;



@end
