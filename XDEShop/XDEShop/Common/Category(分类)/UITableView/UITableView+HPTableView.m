//
//  UITableView+HPTableView.m
//  HPCurrentFrameTest
//
//  Created by Celia on 2017/8/15.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "UITableView+HPTableView.h"

@implementation UITableView (HPTableView)

+ (instancetype)initFrame:(CGRect)frame style:(UITableViewStyle)style backgroundColor:(UIColor *)bgColor {
    
    UITableView *tableV = [[UITableView alloc] initWithFrame:frame style:style];
    tableV.backgroundColor = bgColor;
    
    return tableV;
}

+ (instancetype)initFrame:(CGRect)frame style:(UITableViewStyle)style backgroundColor:(UIColor *)bgColor separatorStyle:(UITableViewCellSeparatorStyle)sepStyle {
    
    UITableView *tableV = [UITableView initFrame:frame style:style backgroundColor:bgColor];
    tableV.separatorStyle = sepStyle;
    
    return tableV;
}

+ (instancetype)initFrame:(CGRect)frame style:(UITableViewStyle)style backgroundColor:(UIColor *)bgColor headerView:(UIView *)headerView {
    
    UITableView *tableV = [UITableView initFrame:frame style:style backgroundColor:bgColor];
    tableV.tableHeaderView = headerView;
    
    return tableV;
}

@end
