//
//  XDSearchStoreTableView.m
//  B2B2C
//
//  Created by Celia on 2018/3/22.
//  Copyright © 2018年 HP. All rights reserved.
//

#import "XDSearchStoreTableView.h"
#import "XDSearchStoreCell.h"

//#import "ZHGoodsViewController.h"
//#import "ZHStoreViewController.h"

@interface XDSearchStoreTableView () <UITableViewDataSource, XDSearchStoreCellDelegate>

@end

@implementation XDSearchStoreTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        _dataArray = [NSArray array];
        [self createInterface];
    }
    return self;
}

#pragma mark - 内部逻辑实现

#pragma mark - 代理协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XDSearchStoreCell *cell = [XDSearchStoreCell cellWithTableView:tableView];
    cell.cellDelegate = self;
    return cell;
}

#pragma mark - ZHSearchStoreCellDelegate
- (void)tapGoodsIndex:(NSInteger)index currentCell:(XDSearchStoreCell *)currentCell {
    DEBUGLog(@"img index = %ld",index);
//    ZHGoodsViewController *goodsVC = [[ZHGoodsViewController alloc] init];
//    [self.belongViewController pushViewController:goodsVC];
}

- (void)collectStoreCurrentCell:(XDSearchStoreCell *)currentCell {
    DEBUGLog(@"收藏店铺");
    
}

- (void)enterStoreCurrentCell:(XDSearchStoreCell *)currentCell {
    DEBUGLog(@"进入店铺");
//    ZHStoreViewController *storeVC = [[ZHStoreViewController alloc] init];
//    [self.belongViewController pushViewController:storeVC];
}

#pragma mark - 数据请求 / 数据处理
- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self reloadData];
}

#pragma mark - 视图布局
- (void)createInterface {
    _dataArray = @[@"",@"",@"",@""];
    self.backgroundColor = kCOLOR_Gray_TableBG;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rowHeight = (HPScreenWidth-35)/4 + 165;
}

#pragma mark - 懒加载

@end
