//
//  UICollectionViewFlowLayout+Extension.m
//  ZJSC
//
//  Created by 秦正华 on 2017/6/26.
//  Copyright © 2017年 zhijianshangcheng. All rights reserved.
//

#import "UICollectionViewFlowLayout+HPExtension.h"

@implementation UICollectionViewFlowLayout (HPExtension)

+ (instancetype)initWithItemSize:(CGSize)itemsize SectionInset:(UIEdgeInsets)Insets InteritemSpacing:(CGFloat)spacing LineSpacing:(CGFloat)spacing_L {
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    //设置滚动方向
    layout.sectionInset = Insets;
    
    //设置间距
    layout.minimumInteritemSpacing = spacing;  //最小列间距
    layout.minimumLineSpacing = spacing_L;     //最小行间距
    layout.itemSize = itemsize;
    return layout;
}

@end
