//
//  UICollectionView+HPExtension.h
//  HP_iOS_CommonFrame
//
//  Created by Celia on 2017/8/17.
//  Copyright © 2017年 zhijianshangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (HPExtension)

/** 滚动到某一分组 */
- (void)scrollToSection:(NSUInteger)section animated:(BOOL)animated;

@end
