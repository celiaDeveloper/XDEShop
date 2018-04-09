//
//  UITextField+extension.m
//  SLYP
//
//  Created by 秦正华 on 2016/11/21.
//  Copyright © 2016年 马晓明. All rights reserved.
//

#import "UITextField+HPExtension.h"

@implementation UITextField (HPExtension)

+ (UITextField *)initTextFieldFont:(CGFloat)font LeftImageName:(NSString *)imagename Placeholder:(NSString *)placeholder {
    
    UITextField *textField = [[UITextField alloc]init];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.font = [UIFont hp_systemFontOfSize:font];
    textField.textColor = [UIColor darkGrayColor];
    textField.borderStyle = UITextBorderStyleNone;
    textField.placeholder = placeholder;
    if (imagename != nil) {
        textField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imagename]];
        textField.leftViewMode = UITextFieldViewModeAlways;
    }
    return textField;
}


// 继承UITextView重写这个方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    // 返回NO为禁用，YES为开启
    // 粘贴
    if (action == @selector(paste:)) return NO;
    // 剪切
    if (action == @selector(cut:)) return NO;
    // 复制
    if (action == @selector(copy:)) return NO;
    // 选择
    if (action == @selector(select:)) return NO;
    // 选中全部
    if (action == @selector(selectAll:)) return NO;
    // 删除
    if (action == @selector(delete:)) return NO;
    // 分享
    if (action == @selector(share)) return NO;
    return [super canPerformAction:action withSender:sender];
}


@end
