//
//  HPTableView.h
//  ZHDJ
//
//  Created by 秦正华 on 2017/9/5.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HPTableViewDelegate <NSObject>

/** 选中cell代理方法 */
-(void)HPTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HPTableView : UITableView

@property(nonatomic,assign)CGFloat tableHeaderHeight;

@property(nonatomic,assign)CGFloat tableFooterHeight;

@property(nonatomic,strong)UIColor * HeaderAndFooterBackgroundColor;

@property(nonatomic,weak)id<HPTableViewDelegate> HPTableViewDelegate;

/** 改变上拉和下拉状态,dataCount为请求当前页数据数量比对配置的分页数据kPAGE_SIZE */
-(void)endRefresh:(NSInteger)dataCount;

@end
