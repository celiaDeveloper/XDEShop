//
//  MSSAutoresizeLabelFlowLayout.m
//  XDAutoresizeLabelFlow
//
//  Created by Celia on 2018/4/11.
//  Copyright © 2018年 HP. All rights reserved.
//

#import "XDAutoresizeLabelFlowLayout.h"
#import "XDAutoresizeLabelFlowConfig.h"

typedef struct currentOrigin {
    CGFloat     lineX;
    NSInteger   lineNumber;
    NSInteger   section;    // 记录当前分组
    CGFloat     totalY;     // collectionView 内容的最大Y值
}currentOrigin;

@implementation XDAutoresizeLabelFlowLayout {
    UIEdgeInsets    contentInsets;
    CGFloat         sectionHeight;
    CGFloat         itemHeight;
    CGFloat         itemSpace;
    CGFloat         lineSpace;
    CGFloat         itemMargin;
    UIFont          *titleFont;
    NSInteger       itemCount;
    currentOrigin   orgin;
    NSMutableArray *attributesArray;
}

- (void)prepareLayout {
    [super prepareLayout];
    attributesArray = [NSMutableArray array];
    XDAutoresizeLabelFlowConfig *config = [XDAutoresizeLabelFlowConfig shareConfig];
    contentInsets = config.contentInsets;
    titleFont = config.textFont;
    lineSpace = config.lineSpace;
    itemHeight = config.itemHeight;
    itemSpace = config.itemSpace;
    itemCount = [self.collectionView numberOfItemsInSection:0];
    itemMargin = config.textMargin;
    orgin.lineNumber = 0;
    orgin.section = 0;
    orgin.lineX = contentInsets.left;
    orgin.totalY = contentInsets.top;
    sectionHeight = config.sectionHeight;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    // 清除之前布局属性
    [attributesArray removeAllObjects];
    NSInteger section = [self.collectionView numberOfSections];
    for (int i = 0; i < section; i++) {
        NSInteger item = [self.collectionView numberOfItemsInSection:i];
        if (item) {
            // 分组头视图的布局属性 加入数组中，才起作用
            UICollectionViewLayoutAttributes *sectionAtt = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]];
            [attributesArray addObject:sectionAtt];
        }
        for (int j = 0; j < item; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            // 每个cell的布局属性 加入数组中
            UICollectionViewLayoutAttributes *att = [self layoutAttributesForItemAtIndexPath:indexPath];
            [attributesArray addObject:att];
        }
    }
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    /*
     [super layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:indexPath];
     通过super 创建的对象是nill
     */

    if (orgin.lineX > contentInsets.left) {
        orgin.totalY += itemHeight+lineSpace;
    }
    attri.frame = CGRectMake(0, orgin.totalY, self.collectionView.width, sectionHeight);
    orgin.totalY += sectionHeight;
    
    return attri;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    
    // 进入下一个分组
    if (orgin.section != indexPath.section) {
        orgin.section = indexPath.section;
        orgin.lineNumber ++;
        orgin.lineX = contentInsets.left;
    }
    
    NSString *title = [self.dataSource titleForLabelAtIndexPath:indexPath];
    CGSize size = [self sizeWithTitle:title font:titleFont];
    NSLog(@"title - %@, width - %f",title, size.width);
    CGFloat itemWidth = size.width+itemMargin;
    if (itemWidth > CGRectGetWidth(self.collectionView.frame)-(contentInsets.left+contentInsets.right)) {
        itemWidth = CGRectGetWidth(self.collectionView.frame)-(contentInsets.left+contentInsets.right);
    }
    if (itemWidth > CGRectGetWidth(self.collectionView.frame)-contentInsets.right-orgin.lineX) {
        orgin.lineNumber ++;
        orgin.lineX = contentInsets.left;
        orgin.totalY += itemHeight+lineSpace;
    }
    
    CGFloat itemOrginX = orgin.lineX;
    CGFloat itemOrginY = orgin.totalY;
    
    attr.frame = CGRectMake(itemOrginX, itemOrginY, itemWidth, itemHeight);
    orgin.lineX += itemWidth+itemSpace;
    
    return attr;
}

- (CGSize)sizeWithTitle:(NSString *)title font:(UIFont *)font {
    CGRect rect = [title boundingRectWithSize:CGSizeMake(1000, itemHeight) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size;
}

- (CGSize)collectionViewContentSize {
    CGFloat sizeHeight = orgin.lineX > contentInsets.left ? orgin.totalY+ itemHeight+lineSpace : orgin.totalY;
    return CGSizeMake(self.collectionView.width, sizeHeight);
}

@end
