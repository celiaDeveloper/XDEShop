//
//  PK-ios
//
//  Created by peikua on 15/9/15.
//  Copyright (c) 2015年 peikua. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface NSString (HPCategory)

/**
 UTF8->解码
 */
- (NSString *)decodeUTF8;

/**
 编码->UTF8
 */
- (NSString *)codeUTF8;

/**
 电话号码中间4位*显示

 @param phoneNum 电话号码
 @return 135*****262
 */
+ (NSString*)getSecrectStringWithPhoneNumber:(NSString*)phoneNum;


/**
 银行卡号中间8位*显示

 @param accountNo 银行卡号
 @return -
 */
+ (NSString*)getSecrectStringWithAccountNo:(NSString*)accountNo;


/**
 转为手机格式，默认为 181-1881-8106
 
 @param mobile 手机号码
 @return -
 */
+ (NSString*)stringMobileFormat:(NSString*)mobile;

/**
 金额数字添加单位（暂时写了万和亿，有更多的需求请参考写法来自行添加）
 
 @param value 金额
 @return -
 */
+ (NSString*)stringChineseFormat:(double)value;


/**
 添加数字的千位符

 @param num -
 @return -
 */
+ (NSString*)countNumAndChangeformat:(NSString *)num;

/**
 *  NSString转为NSNumber
 *
 *  @return NSNumber
 */
- (NSNumber*)toNumber;

/**
 计算文字高度
 
 @param fontSize 字体
 @param width 最大宽度
 @return -
 */
- (CGFloat  )heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width;

/**
 计算文字宽度

 @param fontSize 字体
 @param maxHeight 最大高度
 @return -
 */
- (CGFloat  )widthWithFontSize:(CGFloat)fontSize height:(CGFloat)maxHeight;

/**
 抹除小数末尾的0

 @return -
 */
- (NSString*)removeUnwantedZero;

/**
 //去掉前后空格

 @return -
 */
- (NSString*)trimmedString;

/**
 从字符串中获取数字
 */
- (float)getNumberCharacters;

#pragma mark - 文件夹目录拼接

/**
 将当前字符串拼接到cache目录后面
 */
- (NSString *)cacheDir;

/**
 将当前字符串拼接到doc目录后面
 */
- (NSString *)docDir;

/**
 将当前字符串拼接到tmp目录后面
 */
- (NSString *)tmpDir;

#pragma mark - 判断图片类型
/**
 根据image的data 判断图片类型
 
 @param data 图片data
 @return 图片类型(png、jpg...)
 */
+ (NSString *)contentTypeWithImageData: (NSData *)data;


#pragma mark - html转义
- (NSString *)htmlStringTransform;

/**
 *  汉字的拼音
 *
 *  @return 拼音
 */
- (NSString *)pinyin;

@end
