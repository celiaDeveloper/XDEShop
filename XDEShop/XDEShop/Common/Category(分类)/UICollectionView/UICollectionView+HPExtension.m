//
//  UICollectionView+HPExtension.m
//  HP_iOS_CommonFrame
//
//  Created by Celia on 2017/8/17.
//  Copyright © 2017年 zhijianshangcheng. All rights reserved.
//

#import "UICollectionView+HPExtension.h"

@implementation UICollectionView (HPExtension)


- (void)scrollToSection:(NSUInteger)section animated:(BOOL)animated {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    
    UICollectionViewLayout *layout = (UICollectionViewLayout *)self.collectionViewLayout;
    
    //这个分组的头部
    UICollectionViewLayoutAttributes *layoutAttributes = [layout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
    
    CGFloat offsetY = layoutAttributes.frame.origin.y;
    
    [self setContentOffset:CGPointMake(self.contentOffset.x, offsetY) animated:animated];
}


@end
