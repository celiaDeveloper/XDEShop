//
//  JLRefreshGifFoot.m
//  Jia-li Liu
//
//  Created by KLIANS on 2017/4/27.
//  Copyright © 2017年 KLIANS. All rights reserved.
//

#import "HPRefreshGifFooter.h"

@implementation HPRefreshGifFooter

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        //自动改变透明度 （当控件被导航条挡住后不显示）
        self.automaticallyChangeAlpha = YES;
        
        // 设置各种状态下的刷新文字
        
        [self setTitle:@"松开刷新数据" forState:MJRefreshStatePulling];
        [self setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
        [self setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
        [self setTitle:@"没有更多了 " forState:MJRefreshStateNoMoreData];
        
        // 设置字体
        self.stateLabel.font = [UIFont systemFontOfSize:13];
        
        // 设置颜色
        self.stateLabel.textColor = [UIColor grayColor];
        
        //隐藏文字
//        self.stateLabel.hidden = YES;
        
        //设置动画
        NSMutableArray *headerImages = [NSMutableArray array];
        for (int i = 1; i <= 3; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refreshing_0%d",i]];
            [headerImages addObject:image];
        }
        [self setImages:@[[UIImage imageNamed:@"Pulling"]] forState:MJRefreshStatePulling];
        [self setImages:@[[UIImage imageNamed:@"normal"]] forState:MJRefreshStateIdle];
        [self setImages:headerImages forState:MJRefreshStateRefreshing];
        

        
    }
    return self;
}

@end
