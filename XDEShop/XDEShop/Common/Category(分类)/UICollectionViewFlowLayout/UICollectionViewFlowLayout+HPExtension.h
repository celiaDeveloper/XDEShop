//
//  UICollectionViewFlowLayout+Extension.h
//  ZJSC
//
//  Created by 秦正华 on 2017/6/26.
//  Copyright © 2017年 zhijianshangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewFlowLayout (HPExtension)

+ (instancetype)initWithItemSize:(CGSize)itemsize SectionInset:(UIEdgeInsets)Insets InteritemSpacing:(CGFloat)spacing LineSpacing:(CGFloat)spacing_L;

@end
