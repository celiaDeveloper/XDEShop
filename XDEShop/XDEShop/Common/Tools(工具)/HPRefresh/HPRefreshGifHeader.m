//
//  JLRefreshGifHeader.m
//  Jia-li Liu
//
//  Created by KLIANS on 2017/4/27.
//  Copyright © 2017年 KLIANS. All rights reserved.
//

#import "HPRefreshGifHeader.h"

@implementation HPRefreshGifHeader

-(instancetype)init{
    self = [super init];
    if (self) {
        
        //自动改变透明度 （当控件被导航条挡住后不显示）
        self.automaticallyChangeAlpha = YES;
        
        // 设置各种状态下的刷新文字
        [self setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
        [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
        [self setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
        
        
        // 设置字体
        self.stateLabel.font = [UIFont systemFontOfSize:13];
        self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:13];
        
        // 设置颜色
        self.stateLabel.textColor = [UIColor grayColor];
        self.lastUpdatedTimeLabel.textColor = [UIColor grayColor];
        
        //隐藏文字
//        self.stateLabel.hidden = YES;
//        self.lastUpdatedTimeLabel.hidden = YES;
        
        //设置动画
        NSMutableArray *headerImages = [NSMutableArray array];
        for (int i = 1; i <= 3; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refreshing_0%d",i]];
            [headerImages addObject:image];
        }
        [self setImages:@[[UIImage imageNamed:@"Pulling"]] forState:MJRefreshStatePulling];
        [self setImages:@[[UIImage imageNamed:@"normal"]] forState:MJRefreshStateIdle];
        [self setImages:headerImages forState:MJRefreshStateRefreshing];
        
        //初始化时开始刷新
        [self beginRefreshing];
        
    }
    return self;
}

@end
