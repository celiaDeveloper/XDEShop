//
//  UIView+XM_UIImageToBase64.h
//  项目初始化模板(TableBarStyle)
//
//  Created by 秦正华 on 2017/6/20.
//  Copyright © 2017年 qinzhenghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HPImageToBase64)

/**
 UIImage转base64
 */
- (NSString *)encodeToBase64String:(UIImage *)image;


/**
 base64转UIImage
 */
- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;

@end
