//
//  CustomTextField.m
//  CommonTools
//
//  Created by Celia on 2017/7/3.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
    }
    
    return self;
}

#pragma mark - delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (_limitInteger || _limitOnePoint) {
        textField.keyboardType = UIKeyboardTypeDecimalPad;
    }
    
    return YES;
}
//- (void)textFieldDidBeginEditing:(UITextField *)textField;
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
//- (void)textFieldDidEndEditing:(UITextField *)textField;
//- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason NS_AVAILABLE_IOS(10_0);

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (_limitOnePoint) {
        
        if (_lengthLimit) {
            if ([self validateTextLength:textField Text:string]) {
                return [self onePointFormat:textField Range:range Text:string];
            }else {
                return NO;
            }
        }
        
        return [self onePointFormat:textField Range:range Text:string];
    }else if (_limitInteger) {
        
        if (_lengthLimit) {
            if ([self validateTextLength:textField Text:string]) {
                return [self validateNumber:string];
            }else {
                return NO;
            }
        }
        
        return [self validateNumber:string];
    }
    
    return YES;
    
}


//- (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
//- (BOOL)textFieldShouldReturn:(UITextField *)textField;

#pragma mark - 限制输入的判断条件
//限制位数
- (BOOL)validateTextLength:(UITextField *)textView Text:(NSString *)text {
    
    //这个判断相当于是textfield中的点击return的代理方法
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    //在输入过程中 判断加上输入的字符 是否超过限定字数
    NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, text];
    if (str.length > _lengthLimit)
    {
        textView.text = [textView.text substringToIndex:_lengthLimit];
        return NO;
    }
    return YES;
    
}

//限制整数
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


//限制一位小数
- (BOOL)onePointFormat:(UITextField *)textView Range:(NSRange)range Text:(NSString *)text {
    //    限制只能输入数字
    BOOL isHaveDian = YES;
    if ([text isEqualToString:@" "]) {
        return NO;
    }
    
    if ([textView.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian = NO;
    }
    if ([text length] > 0) {
        
        unichar single = [text characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
            
            if([textView.text length] == 0){
                if(single == '.') {
                    NSLog(@"数据格式有误");
                    [textView.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            
            //输入的字符是否是小数点
            if (single == '.') {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian = YES;
                    return YES;
                    
                }else{
                    NSLog(@"数据格式有误");
                    [textView.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                if (isHaveDian) {//存在小数点
                    
                    //判断小数点的位数
                    NSRange ran = [textView.text rangeOfString:@"."];
                    if (range.location - ran.location <= 1) {
                        return YES;
                    }else{
                        NSLog(@"最多两位小数");
                        return NO;
                    }
                }else{
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            NSLog(@"数据格式有误");
            [textView.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
}

@end
