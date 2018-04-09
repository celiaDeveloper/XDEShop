//
//  UIButton+HPImageTitleSpacing.h
//  HP_iOS_CommonFrame
//
//  Created by Celia on 2017/8/22.
//  Copyright © 2017年 zhijianshangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HPButtonEdgeInsetsStyle) {
    HPButtonEdgeInsetsStyleTop,     // image在上，label在下
    HPButtonEdgeInsetsStyleLeft,    // image在左，label在右
    HPButtonEdgeInsetsStyleBottom,  // image在下，label在上
    HPButtonEdgeInsetsStyleRight    // image在右，label在左
};

@interface UIButton (HPImageTitleSpacing)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(HPButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;

@end
