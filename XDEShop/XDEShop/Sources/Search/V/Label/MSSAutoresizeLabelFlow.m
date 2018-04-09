//
//  MSSAutoresizeLabelFlow.m
//  MSSAutoresizeLabelFlow
//
//  Created by Mrss on 15/12/26.
//  Copyright © 2015年 expai. All rights reserved.
//

#import "MSSAutoresizeLabelFlow.h"
#import "MSSAutoresizeLabelFlowLayout.h"
#import "MSSAutoresizeLabelFlowCell.h"
#import "MSSAutoresizeLabelFlowConfig.h"

static NSString *const cellId = @"cellId";

@interface MSSAutoresizeLabelFlow () <UICollectionViewDataSource,UICollectionViewDelegate,MSSAutoresizeLabelFlowLayoutDataSource,MSSAutoresizeLabelFlowLayoutDelegate>
@property (nonatomic,strong) UICollectionView *collection;
@property (nonatomic,strong) NSMutableArray   *data;
@property (nonatomic,  copy) selectedHandler  handler;
@property (nonatomic, assign) NSInteger numberCount;

@property (nonatomic, assign) NSInteger selectItem;     // 选中的item
@end

@implementation MSSAutoresizeLabelFlow

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles selectedHandler:(selectedHandler)handler {
    self = [super initWithFrame:frame];
//    if (!titles.count) {
//        return self;
//    }
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.data = [titles mutableCopy];
        self.handler = handler;
        [self setup];
    }
    return self;
}

- (void)setup {
    MSSAutoresizeLabelFlowLayout *layout = [[MSSAutoresizeLabelFlowLayout alloc] init];
    layout.delegate = self;
    layout.dataSource = self;
    self.collection = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collection.backgroundColor = [MSSAutoresizeLabelFlowConfig shareConfig].backgroundColor;
    self.collection.allowsMultipleSelection = YES;
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.collection registerClass:[MSSAutoresizeLabelFlowCell class] forCellWithReuseIdentifier:cellId];
    [self addSubview:self.collection];
    
}

- (void)setSelectMark:(BOOL)selectMark {
    _selectMark = selectMark;
    if (selectMark) {
        self.selectItem = 0;
    }
}

- (void)setSelectItem:(NSInteger)selectItem {
    _selectItem = selectItem;
    [self.collection reloadData];
}


#pragma mark - collectionview 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSSAutoresizeLabelFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    [cell configCellWithTitle:self.data[indexPath.item]];
    if (self.selectMark) {
        if (indexPath.item == self.selectItem) {
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
        NSUInteger index = indexPath.item;
        NSString *title = self.data[index];
        self.handler(index,title);
    }
    if (self.selectMark) {
        self.selectItem = indexPath.item;
    }
}

- (NSString *)titleForLabelAtIndexPath:(NSIndexPath *)indexPath {
    return self.data[indexPath.item];
}

- (void)layoutFinishWithNumberOfline:(NSInteger)number {

    DEBUGLog(@"旧新 number == %ld,%ld",self.numberCount, number);
    if (self.numberCount == number) {
        return;
    }
    self.numberCount = number;
    MSSAutoresizeLabelFlowConfig *config = [MSSAutoresizeLabelFlowConfig shareConfig];
    CGFloat h = config.contentInsets.top+config.contentInsets.bottom+config.itemHeight*number+config.lineSpace*(number-1);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, h);
    DEBUGLog(@"final h == %f",h);
    [UIView animateWithDuration:0.1 animations:^{
        self.collection.frame = self.bounds;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // block回调 把新的高度传回去
        if (self.contentSizeChangedHandler) {
            self.contentSizeChangedHandler(self, h);
        }
    });
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

- (void)reloadAllWithTitles:(NSArray *)titles {
    self.data = [titles mutableCopy];
    [self.collection reloadData];
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

