//
//  XDAttributeSelectionView.m
//  XDEShop
//
//  Created by Celia on 2018/4/23.
//  Copyright © 2018年 Hopex. All rights reserved.
//

#import "XDAttributeSelectionView.h"

// Models
#import "XDAttributeTitleItem.h"
#import "XDAttributeList.h"
// Views
#import "PPNumberButton.h"
#import "XDAttributeItemCell.h"
#import "XDAttributeHeaderView.h"
#import "XDCollectionHeaderLayout.h"
#import "XDAttributeChoseTopCell.h"
// Vendors
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>


#define NowScreenH HPScreenHeight * 0.8

static NSInteger num_;

static NSString *const DCFeatureHeaderViewID = @"DCFeatureHeaderView";
static NSString *const DCFeatureItemCellID = @"DCFeatureItemCell";
static NSString *const DCFeatureChoseTopCellID = @"DCFeatureChoseTopCell";

@interface XDAttributeSelectionView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HorizontalCollectionLayoutDelegate, PPNumberButtonDelegate, UITableViewDelegate, UITableViewDataSource>

/* collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;
/* tableView */
@property (nonatomic, strong) UITableView *tableView;

/* 选择属性 */
@property (nonatomic, strong) NSMutableArray *seleArray;
/* 商品选择结果Cell */
@property (nonatomic, weak) XDAttributeChoseTopCell *cell;

@end

@implementation XDAttributeSelectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
        [self createInterface];
    }
    return self;
}

#pragma mark - 内部逻辑实现
- (void)clearViewTapped {
    NSDictionary *tempDic = [self getSubmitDic];
    self.AttributeDismissBlock(tempDic ? tempDic:nil);
}

- (void)buttomButtonClick:(UIButton *)button {
    if (_seleArray.count != _featureAttr.count && _lastSeleArray.count != _featureAttr.count) {//未选择全属性警告
        [HPProgressHUD showMessage:@"请选择商品属性"];
        return;
    }
    
    NSDictionary *submitDic = [self getSubmitDic];
    if (submitDic) {
        self.AttributeSubmitBlock(submitDic);
    }else {
        self.AttributeSubmitBlock(nil);
    }
    
}

// 获得要提交的属性dic
- (NSDictionary *)getSubmitDic {
    NSMutableArray *tempArr;
    if (self.seleArray.count == 0) {
        tempArr = [NSMutableArray arrayWithArray:self.lastSeleArray];
    }else {
        tempArr = self.seleArray.copy;
    }
    if (tempArr.count == 0) {
        return nil;
    }
    NSDictionary *submitDic = @{@"Num" : [NSString
                                          stringWithFormat:@"%zd",num_],
                                @"Array" : tempArr};
    return submitDic;
}

#pragma mark - 代理协议
#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XDAttributeChoseTopCell *cell = [tableView dequeueReusableCellWithIdentifier:DCFeatureChoseTopCellID forIndexPath:indexPath];
    _cell = cell;
    
    [cell.goodImageView sd_setImageWithURL:[NSURL URLWithString:_goodImageView]];
    
    cell.goodPriceLabel.text = [NSString stringWithFormat:@"价格：%@",@"12"];
    
    cell.storageLabel.text = [NSString stringWithFormat:@"库存：%@",@"99"];
    
    if (_seleArray.count) {
        NSString *attString = [_seleArray componentsJoinedByString:@"，"];
        cell.chooseAttLabel.text = [NSString stringWithFormat:@"已选属性：%@",attString];
        
    }
    
    //    if (_seleArray.count != _featureAttr.count && _lastSeleArray.count != _featureAttr.count) {
    //        cell.chooseAttLabel.textColor = [UIColor redColor];
    //        cell.chooseAttLabel.text = @"有货";
    //    }else {
    //        cell.chooseAttLabel.textColor = [UIColor darkGrayColor];
    //        NSString *attString = (_seleArray.count == _featureAttr.count) ? [_seleArray componentsJoinedByString:@"，"] : [_lastSeleArray componentsJoinedByString:@"，"];
    //        cell.chooseAttLabel.text = [NSString stringWithFormat:@"已选属性：%@",attString];
    //    }
    
    HPWeakSelf(self)
    cell.crossButtonClickBlock = ^{
        [weakself clearViewTapped];
    };
    return cell;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _featureAttr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _featureAttr[section].list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XDAttributeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCFeatureItemCellID forIndexPath:indexPath];
    cell.content = _featureAttr[indexPath.section].list[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        XDAttributeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCFeatureHeaderViewID forIndexPath:indexPath];
        headerView.headTitle = _featureAttr[indexPath.section].attr;
        return headerView;
    }else {
        
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter" forIndexPath:indexPath];
        return footerView;
    }
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //限制每组内的Item只能选中一个(加入质数选择)
    if (_featureAttr[indexPath.section].list[indexPath.row].isSelect == NO) {
        for (NSInteger j = 0; j < _featureAttr[indexPath.section].list.count; j++) {
            _featureAttr[indexPath.section].list[j].isSelect = NO;
        }
    }
    _featureAttr[indexPath.section].list[indexPath.row].isSelect = !_featureAttr[indexPath.section].list[indexPath.row].isSelect;
    
    
    //section，item 循环讲选中的所有Item加入数组中 ，数组mutableCopy初始化
    _seleArray = [@[] mutableCopy];
    for (NSInteger i = 0; i < _featureAttr.count; i++) {
        for (NSInteger j = 0; j < _featureAttr[i].list.count; j++) {
            if (_featureAttr[i].list[j].isSelect == YES) {
                [_seleArray addObject:_featureAttr[i].list[j].infoname];
            }else{
                [_seleArray removeObject:_featureAttr[i].list[j].infoname];
                [_lastSeleArray removeAllObjects];
            }
        }
    }
    
    //刷新tableView和collectionView
    [self.collectionView reloadData];
    [self.tableView reloadData];
}


#pragma mark - <HorizontalCollectionLayoutDelegate>
#pragma mark - 自定义layout必须实现的方法
- (NSString *)collectionViewItemSizeWithIndexPath:(NSIndexPath *)indexPath {
    return _featureAttr[indexPath.section].list[indexPath.row].infoname;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

#pragma mark - 数据请求 / 数据处理
- (void)setFeatureAttr:(NSMutableArray<XDAttributeItem *> *)featureAttr {
    _featureAttr = featureAttr;
    
    if (_lastSeleArray.count == 0) return;
    for (NSString *str in _lastSeleArray) {//反向遍历（赋值）
        for (NSInteger i = 0; i < _featureAttr.count; i++) {
            for (NSInteger j = 0; j < _featureAttr[i].list.count; j++) {
                if ([_featureAttr[i].list[j].infoname isEqualToString:str]) {
                    _featureAttr[i].list[j].isSelect = YES;
                    [self.collectionView reloadData];
                }
            }
        }
    }
}

#pragma mark - 视图布局
- (void)createInterface {
    
    // 顶部透明视图
    UIView *clearView = [UIView initViewBackColor:[UIColor clearColor]];
    clearView.frame = CGRectMake(0, 0, HPScreenWidth, HPScreenHeight - NowScreenH);
    [self addSubview:clearView];
    [clearView addTarget:self action:@selector(clearViewTapped)];
    
    // 白背景
    UIView *whiteBack = [UIView initViewBackColor:[UIColor whiteColor]];
    whiteBack.frame = CGRectMake(0, HPScreenHeight - NowScreenH, HPScreenWidth, NowScreenH);
    [self addSubview:whiteBack];
    
    self.tableView.frame = CGRectMake(0, (HPScreenHeight - NowScreenH), HPScreenWidth, 100);
    self.tableView.rowHeight = 100;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.frame = CGRectMake(0, self.tableView.bottom ,HPScreenWidth , NowScreenH - 200 - _bottomSpace);
    
    [self setupBottomView];
}

- (void)setupBottomView {
    NSArray *titles = @[@"确 定"];
    CGFloat buttonH = 50;
    CGFloat buttonW = HPScreenWidth / titles.count;
    CGFloat buttonY = HPScreenHeight - _bottomSpace - buttonH;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *buttton = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttton setTitle:titles[i] forState:0];
        buttton.backgroundColor = (i == 0) ? [UIColor redColor] : [UIColor orangeColor];
        CGFloat buttonX = buttonW * i;
        buttton.tag = i;
        buttton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [self addSubview:buttton];
        [buttton addTarget:self action:@selector(buttomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UILabel *numLabel = [UILabel new];
    numLabel.text = @"购买数量";
    numLabel.font = [UIFont hp_systemFontOfSize:20];
    [self addSubview:numLabel];
    numLabel.frame = CGRectMake(10, HPScreenHeight - _bottomSpace - 90, 70, 35);
    
    PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(CGRectGetMaxX(numLabel.frame), numLabel.top, 110, numLabel.height)];
    numberButton.shakeAnimation = YES;
    numberButton.minValue = 1;
    numberButton.inputFieldFont = 23;
    numberButton.increaseTitle = @"＋";
    numberButton.decreaseTitle = @"－";
    numberButton.increaseBackColor = [UIColor hex:@"f2f2f2"];
    numberButton.decreaseBackColor = [UIColor hex:@"f2f2f2"];
    num_ = (_lastNum == 0) ?  1 : [_lastNum integerValue];
    numberButton.currentNumber = num_;
    numberButton.delegate = self;
    
    numberButton.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
        num_ = num;
    };
    [self addSubview:numberButton];
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        XDCollectionHeaderLayout *layout = [XDCollectionHeaderLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        //自定义layout初始化
        layout.delegate = self;
        layout.lineSpacing = 8.0;
        layout.interitemSpacing = 10;
        layout.headerViewHeight = 35;
        layout.footerViewHeight = 5;
        layout.itemInset = UIEdgeInsetsMake(0, 10, 0, 10);
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        
        [_collectionView registerClass:[XDAttributeItemCell class] forCellWithReuseIdentifier:DCFeatureItemCellID];//cell
        [_collectionView registerClass:[XDAttributeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCFeatureHeaderViewID]; //头部
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"]; //尾部
        
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[XDAttributeChoseTopCell class] forCellReuseIdentifier:DCFeatureChoseTopCellID];
        
        [self addSubview:_tableView];
    }
    return _tableView;
}

@end
