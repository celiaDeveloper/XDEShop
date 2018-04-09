//
//  XDSearchStoreListViewController.m
//  B2B2C
//
//  Created by Celia on 2018/3/22.
//  Copyright © 2018年 HP. All rights reserved.
//

#import "XDSearchStoreListViewController.h"
#import "XDSearchStoreTableView.h"

@interface XDSearchStoreListViewController ()
@property (nonatomic, strong) XDSearchStoreTableView *listView;
@end

@implementation XDSearchStoreListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createInterface];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 内部逻辑实现
#pragma mark - 代理协议
#pragma mark - 数据请求 / 数据处理
#pragma mark - 视图布局
- (void)createInterface {
    self.title = @"搜索结果";
    
    [self.view addSubview:self.listView];
}

#pragma mark - 懒加载
- (XDSearchStoreTableView *)listView {
    if (!_listView) {
        _listView = [[XDSearchStoreTableView alloc] initWithFrame:CGRectMake(0, 0, HPScreenWidth, HPScreenHeight) style:UITableViewStylePlain];
    }
    return _listView;
}


@end
