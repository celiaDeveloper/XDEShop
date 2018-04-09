//
//  CustomTextView.h
//  CommonTools
//
//  Created by Celia on 2017/7/3.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomTextView : UITextView <UITextViewDelegate>

@property (nonatomic, strong) NSString *defaultPlace;   //默认显示文字
@property (nonatomic, assign) BOOL limitOnePoint;       //限制一位小数
@property (nonatomic, assign) BOOL limitInteger;        //限制整数

@property (nonatomic, assign) NSInteger lengthLimit;    //限制位数

@property (nonatomic, copy) void (^RemainCountBlock)(NSInteger count);

@property (nonatomic, assign) BOOL observeKeyboard;     //是否监听键盘

@end
