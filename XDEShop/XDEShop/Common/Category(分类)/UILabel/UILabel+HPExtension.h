//
//  UILabel+extension.h
//  SLYP
//
//  Created by 秦正华 on 2016/11/18.
//  Copyright © 2016年 马晓明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (HPExtension)

/**
 创建标准标签
 */
+ (instancetype)initLabelTextFont:(CGFloat)font textColor:(UIColor *)textColor title:(NSString *)text;

- (void)setLabelTextFont:(CGFloat)font textColor:(UIColor *)textColor title:(NSString *)text;

/**
 创建属性标签
 */
+ (instancetype)initAttributeLabelAttributeFont:(CGFloat)font attributeColor:(UIColor *)textColor otherFont:(CGFloat)otherFont otherColor:(UIColor *)otherColor leftText:(NSString *)leftText middleText:(NSString *)middleText rightText:(NSString *)rightText;

- (void)setAttributeLabelAttributeFont:(CGFloat)font attributeColor:(UIColor *)textColor otherFont:(CGFloat)otherFont otherColor:(UIColor *)otherColor leftText:(NSString *)leftText middleText:(NSString *)middleText rightText:(NSString *)rightText;

/**
 创建删除线标签
 */
+ (instancetype)initStrikethroughLabelTextFont:(CGFloat)font textColor:(UIColor *)color text:(NSString *)text;

- (void)setStrikethroughLabelTextFont:(CGFloat)font textColor:(UIColor *)color text:(NSString *)text;



/**
 获取label的size  根据text、font和label最大宽度
 */
- (CGSize)getLableCGSizeWithString:(NSString *)text fontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth;


/**
 对某些文字加下划线

 @param color 下划线颜色
 @param text 加下划线的文字
 */
- (void)addUnderlineColor:(UIColor *)color toText:(NSString *)text;

/** 对某些文字加删除线 */
- (void)addDeletelineColor:(UIColor *)color toText:(NSString *)text;

/**
 改变某些文字的颜色
 */
- (void)changeTextColor:(UIColor *)color toText:(NSString *)text;

/** 改变某些文字的大小(字体默认为系统字体) */
- (void)changeTextFontSize:(CGFloat)fontSize toText:(NSString *)text;


/** 改变lable行间距 */
- (void)changeLineSpace:(float)space;
/** 改变label字间距 */
- (void)changeWordSpace:(float)space;
/**  */
-(void)alignTop;


/** 根据字符串算label高度*/
- (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(CGFloat)font;

@end
