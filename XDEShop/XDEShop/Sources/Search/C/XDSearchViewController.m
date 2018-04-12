//
//  XDSearchViewController.m
//  XDEShop
//
//  Created by Celia on 2018/4/4.
//  Copyright © 2018年 Hopex. All rights reserved.
//

#import "XDSearchViewController.h"
#import "XDSearchBarView.h"
#import "XDAutoresizeLabelFlow.h"
#import "XDAutoresizeLabelFlowHeader.h"
#import "XDDataBase.h"

#import "XDSearchStoreListViewController.h"

@interface XDSearchViewController () <XDSearchBarViewDelegate>
@property (nonatomic, strong) XDSearchBarView *searchBar;
@property (nonatomic, strong) XDAutoresizeLabelFlow *recordView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation XDSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    self.dataArray = @[@[],@[]].mutableCopy;
    [[XDDataBase sharedXDDataBase] openSearchRecordDataBase];
    [self createInterface];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.searchBar) {
        // 清除搜索框文字
        self.searchBar.searchTF.text = @"";
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 查询数据库数据 刷新搜索记录
    HPWeakSelf(self)
    [[XDDataBase sharedXDDataBase] querySearchRecord:^(NSArray *resultArray) {
        DEBUGLog(@"%@",resultArray);
        [weakself.dataArray replaceObjectAtIndex:0 withObject:resultArray];
        [weakself.recordView reloadAllWithTitles:weakself.dataArray];
    }];
}


#pragma mark - 内部逻辑实现
// 执行搜索
- (void)performSearchAction:(NSString *)keyword {
    DEBUGLog(@"搜索类型 == %lu",self.searchBar.searchType);
    DEBUGLog(@"搜索关键字 == %@",keyword);
    
    if (keyword.length) {
        [[XDDataBase sharedXDDataBase] addSearchRecordText:keyword];
    }    
    
    if (self.searchBar.searchType == SearchTypeGoods) {
        DEBUGLog(@"跳转搜索商品的结果");
    }else {
        DEBUGLog(@"跳转搜索店铺的结果");
        XDSearchStoreListViewController *storeVC = [[XDSearchStoreListViewController alloc] init];
        [self pushViewController:storeVC];
    }
    
}

#pragma mark - 代理协议
- (void)XDSearchBarViewToSearch:(NSString *)keyword {
    [self performSearchAction:keyword];
}

#pragma mark - 数据请求 / 数据处理
#pragma mark - 视图布局
- (void)createInterface {
    // 搜索框
    [self.view addSubview:self.searchBar];
    
    // 热门搜索数据
    NSArray *hotArray = @[@"兰芝",@"雅漾",@"雪肌精",@"雅诗兰黛",@"DHC",@"韩版女装",@"T恤",@"时尚男装"];
    [self.dataArray replaceObjectAtIndex:1 withObject:hotArray];
    
    // collectionview
    HPWeakSelf(self)
    self.recordView = [[XDAutoresizeLabelFlow alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchBar.frame) + 15, HPScreenWidth, HPScreenHeight - CGRectGetMaxY(self.searchBar.frame) - 15 - HPTabBarH) titles:self.dataArray sectionTitles:@[@"搜索记录",@"热门搜索"] selectedHandler:^(NSIndexPath *indexPath, NSString *title) {
        [weakself performSearchAction:title];
    }];
    
    self.recordView.deleteHandler = ^(NSIndexPath *indexPath) {
        DEBUGLog(@"删除搜索记录");
        [[XDDataBase sharedXDDataBase] deleteAllSearchRecord];
    };

    [self.view addSubview:self.recordView];
    
}

#pragma mark - 懒加载
- (XDSearchBarView *)searchBar {
    if (!_searchBar) {
        _searchBar = [[XDSearchBarView alloc] initWithFrame:CGRectMake(0, HPNavBarH + 30, HPScreenWidth, 80)];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

@end
