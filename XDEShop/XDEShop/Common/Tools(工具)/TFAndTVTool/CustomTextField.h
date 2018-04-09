//
//  CustomTextField.h
//  CommonTools
//
//  Created by Celia on 2017/7/3.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextField : UITextField <UITextFieldDelegate>

@property (nonatomic, assign) BOOL limitOnePoint;       //限制一位小数
@property (nonatomic, assign) BOOL limitInteger;        //限制整数

@property (nonatomic, assign) NSInteger lengthLimit;     //限制位数

@end
