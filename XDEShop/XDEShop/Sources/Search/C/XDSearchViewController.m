//
//  XDSearchViewController.m
//  XDEShop
//
//  Created by Celia on 2018/4/4.
//  Copyright © 2018年 Hopex. All rights reserved.
//

#import "XDSearchViewController.h"
#import "XDSearchBarView.h"
#import "MSSAutoresizeLabelFlow.h"
#import "XDSearchRecordHeaderView.h"
#import "XDDataBase.h"

#import "XDSearchStoreListViewController.h"

@interface XDSearchViewController () <XDSearchBarViewDelegate, XDSearchRecordHeaderViewDelegate>
@property (nonatomic, strong) XDSearchBarView *searchBar;
@property (nonatomic, strong) MSSAutoresizeLabelFlow *recordView;
@property (nonatomic, strong) XDSearchRecordHeaderView *hotHeader;
@property (nonatomic, strong) MSSAutoresizeLabelFlow *hotView;
@end

@implementation XDSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
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
        [weakself.recordView reloadAllWithTitles:resultArray];
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

- (void)XDSearchRecordHeaderViewDeleteAction {
    DEBUGLog(@"删除搜索记录");
    [[XDDataBase sharedXDDataBase] deleteAllSearchRecord];
}

#pragma mark - 数据请求 / 数据处理
#pragma mark - 视图布局
- (void)createInterface {
    // 搜索框
    [self.view addSubview:self.searchBar];
    
    // 搜索记录头
    XDSearchRecordHeaderView *recordHeader = [[XDSearchRecordHeaderView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchBar.frame) + 30, HPScreenWidth, 40)];
    recordHeader.titleString = @"搜索记录";
    recordHeader.haveDeleteBtn = YES;
    recordHeader.delegate = self;
    [self.view addSubview:recordHeader];
    
    // 搜索记录选项
    HPWeakSelf(self)
    [[XDDataBase sharedXDDataBase] querySearchRecord:^(NSArray *resultArray) {
        DEBUGLog(@"%@",resultArray);
        weakself.recordView = [[MSSAutoresizeLabelFlow alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(recordHeader.frame), HPScreenWidth, 30) titles:resultArray selectedHandler:^(NSUInteger index, NSString *title) {
            [weakself performSearchAction:title];
        }];
    }];
    [self.view addSubview:self.recordView];
    
    // 搜索记录位置改变 调整热门搜索位置
    self.recordView.contentSizeChangedHandler = ^(MSSAutoresizeLabelFlow *labelFlow, CGFloat newH) {
        
        CGRect hhFrame = weakself.hotHeader.frame;
        hhFrame.origin.y = CGRectGetMaxY(weakself.recordView.frame) + 10;
        weakself.hotHeader.frame = hhFrame;
        
        CGRect hvFrame = weakself.hotView.frame;
        hvFrame.origin.y = CGRectGetMaxY(hhFrame);
        hvFrame.size.height = HPScreenHeight - (weakself.recordView.top + newH + 10 + hhFrame.size.height) - 10;
        weakself.hotView.frame = hvFrame;
    };
    
    
    // 热门搜索头
    _hotHeader = [[XDSearchRecordHeaderView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.recordView.frame) + 10, HPScreenWidth, 40)];
    _hotHeader.titleString = @"热门搜索";
    [self.view addSubview:_hotHeader];
    
    // 热门搜索选项
    NSArray *hotArray = @[@"兰芝",@"雅漾",@"雪肌精",@"雅诗兰黛",@"DHC",@"韩版女装",@"T恤",@"时尚男装"];
    self.hotView = [[MSSAutoresizeLabelFlow alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_hotHeader.frame), HPScreenWidth, HPScreenHeight - CGRectGetMaxY(_hotHeader.frame) - 10) titles:hotArray selectedHandler:^(NSUInteger index, NSString *title) {
        [self performSearchAction:title];
    }];
    [self.view addSubview:self.hotView];
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
