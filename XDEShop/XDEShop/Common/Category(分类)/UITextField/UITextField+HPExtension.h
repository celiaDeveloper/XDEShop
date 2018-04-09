//
//  UITextField+extension.h
//  SLYP
//
//  Created by 秦正华 on 2016/11/21.
//  Copyright © 2016年 马晓明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (HPExtension)

+ (UITextField *)initTextFieldFont:(CGFloat)font LeftImageName:(NSString *)imagename Placeholder:(NSString *)placeholder;


/**
 UITextView中打开或禁用复制，剪切，选择，全选等功能
 
 @param action 功能
 @param sender -
 @return -
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender;


@end
