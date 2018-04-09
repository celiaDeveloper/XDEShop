//
//  UIImageView+HPRotateImage.h
//  HP_iOS_CommonFrame
//
//  Created by Celia on 2017/8/22.
//  Copyright © 2017年 zhijianshangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (HPRotateImage)

/**
 360度旋转图片视图
 */
- (void)rotate360DegreeWithImageView;


/**
 停止旋转
 */
- (void)stopRotate;


@end
