//
//  UIImageView+extension.h
//  SLYP
//
//  Created by 秦正华 on 2016/11/18.
//  Copyright © 2016年 马晓明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (HPExtension)


/**
 创建UIImageView，图片填充模式是UIViewContentModeScaleAspectFill

 @param imagename 图片名称
 @return UIImageView
 */
+ (instancetype)initImageView:(NSString *)imagename;


- (void)setImageView:(NSString *)imagename;



@end
