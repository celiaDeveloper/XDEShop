//
//  HPTableView.m
//  ZHDJ
//
//  Created by 秦正华 on 2017/9/5.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import "HPTableView.h"

@implementation HPTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        
        self.backgroundColor = kCOLOR_Gray_TableBG;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.separatorColor = kCOLOR_LINE;
        self.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
    }
    return self;
}

-(void)setTableFooterHeight:(CGFloat)tableFooterHeight
{
    UIView *HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HPScreenWidth, tableFooterHeight)];
    HeaderView.backgroundColor = _HeaderAndFooterBackgroundColor ? : kCOLOR_Gray_TableBG;
    self.tableFooterView = HeaderView;
}

-(void)setTableHeaderHeight:(CGFloat)tableHeaderHeight
{
    UIView *HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HPScreenWidth, tableHeaderHeight)];
    HeaderView.backgroundColor = _HeaderAndFooterBackgroundColor ? : kCOLOR_Gray_TableBG;
    self.tableHeaderView = HeaderView;
}

-(void)endRefresh:(NSInteger)dataCount
{
    self.mj_header.state = MJRefreshStateIdle;
    self.mj_footer.state = dataCount == kPageSize ? MJRefreshStateIdle : MJRefreshStateNoMoreData;
}

@end
