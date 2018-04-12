//
//  XDAutoresizeLabelFlow.m
//  XDAutoresizeLabelFlow
//
//  Created by Celia on 2018/4/11.
//  Copyright © 2018年 HP. All rights reserved.
//

#import "XDAutoresizeLabelFlow.h"
#import "XDAutoresizeLabelFlowLayout.h"
#import "XDAutoresizeLabelFlowCell.h"
#import "XDAutoresizeLabelFlowConfig.h"
#import "XDAutoresizeLabelFlowHeader.h"

static NSString *const cellId = @"cellId";
static NSString *const headerId = @"flowHeaderID";

@interface XDAutoresizeLabelFlow () <UICollectionViewDataSource, UICollectionViewDelegate, XDAutoresizeLabelFlowLayoutDataSource>

@property (nonatomic,strong) UICollectionView   *collection;
@property (nonatomic,strong) NSMutableArray     *data;
@property (nonatomic,strong) NSArray            *sectionData;
@property (nonatomic,assign) NSInteger numberCount;
@property (nonatomic,copy)   selectedHandler  handler;

@property (nonatomic,strong) NSIndexPath *selectIndex;     // 选中的item

@end

@implementation XDAutoresizeLabelFlow

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles sectionTitles:(NSArray *)secTitles selectedHandler:(selectedHandler)handler {
    self = [super initWithFrame:frame];

    if (self) {
        self.backgroundColor = [UIColor clearColor];
        if (!titles) {
           self.data = @[@[]].mutableCopy;
        }else if (!titles.count || ![titles[0] isKindOfClass:[NSArray class]]) {
            self.data = @[titles].mutableCopy;
        }else {
           self.data = [titles mutableCopy];
        }
        
        self.sectionData = secTitles;
        self.handler = handler;
        [self setup];
    }
    return self;
}

- (void)setup {
    XDAutoresizeLabelFlowLayout *layout = [[XDAutoresizeLabelFlowLayout alloc] init];
    layout.dataSource = self;
    self.collection = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collection.backgroundColor = [XDAutoresizeLabelFlowConfig shareConfig].backgroundColor;
    self.collection.allowsMultipleSelection = YES;
    self.collection.scrollEnabled = YES;
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.collection registerClass:[XDAutoresizeLabelFlowHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    [self.collection registerClass:[XDAutoresizeLabelFlowCell class] forCellWithReuseIdentifier:cellId];
    [self addSubview:self.collection];
    
}

- (void)reloadAllWithTitles:(NSArray *)titles {
    if (!titles.count || ![titles[0] isKindOfClass:[NSArray class]]) {
        self.data = @[titles].mutableCopy;
    }else {
        self.data = [titles mutableCopy];
    }
    [self.collection reloadData];
}


- (void)setSelectMark:(BOOL)selectMark {
    _selectMark = selectMark;
}

- (void)setSelectIndex:(NSIndexPath *)selectIndex {
    _selectIndex = selectIndex;
    [self.collection reloadData];
}

#pragma mark - collectionview 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.data.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *array = self.data[section];
    return array.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        XDAutoresizeLabelFlowHeader *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId forIndexPath:indexPath];
        headerV.indexPath = indexPath;
        headerV.haveDeleteBtn = indexPath.section == 0 ? YES : NO;

        headerV.titleString = [self.sectionData safeObjectAtIndex:indexPath.section] ? : @"";
        headerV.deleteActionBlock = ^(NSIndexPath *indexPath) {
            if (self.deleteHandler) {
                self.deleteHandler(indexPath);
            }
        };
        return headerV;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XDAutoresizeLabelFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    [cell configCellWithTitle:self.data[indexPath.section][indexPath.item]];
    if (self.selectMark) {
        if (indexPath.item == self.selectIndex.item && indexPath.section == self.selectIndex.section) {
            cell.beSelected = YES;
        }else {
           cell.beSelected = NO;
        }
    }else {
        cell.beSelected = NO;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.handler) {
        NSString *title = self.data[indexPath.section][indexPath.item];
        self.handler(indexPath, title);
    }
    if (self.selectMark) {
        self.selectIndex = indexPath;
    }
}

#pragma mark - MSSAutoresizeLabelFlowLayout 代理方法
- (NSString *)titleForLabelAtIndexPath:(NSIndexPath *)indexPath {
    return self.data[indexPath.section][indexPath.item];
}



- (void)insertLabelWithTitle:(NSString *)title atIndex:(NSUInteger)index animated:(BOOL)animated {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.data insertObject:title atIndex:index];
    [self performBatchUpdatesWithAction:UICollectionUpdateActionInsert indexPaths:@[indexPath] animated:animated];
}

- (void)insertLabelsWithTitles:(NSArray *)titles atIndexes:(NSIndexSet *)indexes animated:(BOOL)animated {
    NSArray *indexPaths = [self indexPathsWithIndexes:indexes];
    [self.data insertObjects:titles atIndexes:indexes];
    [self performBatchUpdatesWithAction:UICollectionUpdateActionInsert indexPaths:indexPaths animated:animated];
}

- (void)deleteLabelAtIndex:(NSUInteger)index animated:(BOOL)animated {
    [self deleteLabelsAtIndexes:[NSIndexSet indexSetWithIndex:index] animated:animated];
}

- (void)deleteLabelsAtIndexes:(NSIndexSet *)indexes animated:(BOOL)animated {
    NSArray *indexPaths = [self indexPathsWithIndexes:indexes];
    [self.data removeObjectsAtIndexes:indexes];
    [self performBatchUpdatesWithAction:UICollectionUpdateActionDelete indexPaths:indexPaths animated:animated];
}

- (void)performBatchUpdatesWithAction:(UICollectionUpdateAction)action indexPaths:(NSArray *)indexPaths animated:(BOOL)animated {
    if (!animated) {
        [UIView setAnimationsEnabled:NO];
    }
    [self.collection performBatchUpdates:^{
        switch (action) {
            case UICollectionUpdateActionInsert:
                [self.collection insertItemsAtIndexPaths:indexPaths];
                break;
            case UICollectionUpdateActionDelete:
                [self.collection deleteItemsAtIndexPaths:indexPaths];
            default:
                break;
        }
    } completion:^(BOOL finished) {
        if (!animated) {
            [UIView setAnimationsEnabled:YES];
        }
    }];
}

- (NSArray *)indexPathsWithIndexes:(NSIndexSet *)set {
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:set.count];
    [set enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        [indexPaths addObject:indexPath];
    }];
    return [indexPaths copy];
}


@end

