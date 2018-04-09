//
//  UIFont+Font.m
//  HP_iOS_CommonFrame
//
//  Created by 秦正华 on 2017/8/28.
//  Copyright © 2017年 zhijianshangcheng. All rights reserved.
//

#import "UIFont+HPFont.h"
#import <objc/runtime.h>


@implementation UIFont (HPFont)

+ (void)load {
    
//    Method systimeFont = class_getClassMethod(self, @selector(systemFontOfSize:));
//
//    Method hp_systimeFont = class_getClassMethod(self, @selector(hp_systemFontOfSize:));
//    // 交换方法
//    method_exchangeImplementations(hp_systimeFont, systimeFont);
    
    // 交换以后，navigation title 字体大小会被改变
//    Method boldFont = class_getClassMethod(self, @selector(boldSystemFontOfSize:));
//    
//    Method hp_boldFont = class_getClassMethod(self, @selector(hp_boldSystemFontOfSize:));
//    // 交换方法
//    method_exchangeImplementations(hp_boldFont, boldFont);
}


+ (UIFont *)hp_systemFontOfSize:(CGFloat)pxSize{
    
    CGFloat pt = (pxSize/96)*72;
    UIFont *font = [UIFont systemFontOfSize:pt];
    return font;
}

+ (UIFont *)hp_boldSystemFontOfSize:(CGFloat)pxSize {
    
    CGFloat pt = (pxSize/96)*72;
    UIFont *font = [UIFont boldSystemFontOfSize:pt];
    return font;
}

@end
