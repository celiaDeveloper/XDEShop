//
//  CustomTextView.m
//  CommonTools
//
//  Created by Celia on 2017/7/3.
//  Copyright © 2017年 skyApple. All rights reserved.
//

#import "CustomTextView.h"

@interface CustomTextView ()

@property (nonatomic, strong) UILabel *placeHolder;     //占位label

@end

@implementation CustomTextView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        [self setupPlaceHolder];
    }
    
    return self;
}

// 给textView添加一个UILabel子控件
- (void)setupPlaceHolder
{
    UILabel *placeHolder = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.frame.size.width - 10, 30)];
    self.placeHolder = placeHolder;
    
    placeHolder.text = @"";
    placeHolder.textColor = [UIColor lightGrayColor];
    placeHolder.numberOfLines = 0;
    placeHolder.contentMode = UIViewContentModeTop;
    [self addSubview:placeHolder];
}

#pragma mark - set 方法
- (void)setDefaultPlace:(NSString *)defaultPlace {
    _defaultPlace = defaultPlace;
    
    _placeHolder.text = defaultPlace;
    _placeHolder.alpha = 1.0;
}



#pragma mark - delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if (_limitOnePoint || _limitInteger) {
        textView.keyboardType = UIKeyboardTypeDecimalPad;
    }
    
    return YES;
}
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView;
//
//- (void)textViewDidBeginEditing:(UITextView *)textView;
//- (void)textViewDidEndEditing:(UITextView *)textView;
//
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if (_limitOnePoint) {
        
        if (_lengthLimit) {
            if ([self validateTextLength:textView Text:text]) {
                return [self onePointFormat:textView Range:range Text:text];
            }else {
                return NO;
            }
        }
        
        return [self onePointFormat:textView Range:range Text:text];
    }else if (_limitInteger) {
        
        if (_lengthLimit) {
            if ([self validateTextLength:textView Text:text]) {
                return [self validateNumber:text];
            }else {
                return NO;
            }
        }
        
        return [self validateNumber:text];
    }else if (_lengthLimit) {
        
        return [self validateTextLength:textView Text:text];
        
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    
    //    对占位符的显示和隐藏做判断
    
    if (textView.text.length == 0) {
        
        self.placeHolder.alpha = 1;
        
    }else {
        
        self.placeHolder.alpha = 0;
        
    }
    
}



//- (void)textViewDidChangeSelection:(UITextView *)textView;


#pragma mark - 限制输入的判断条件
//限制位数
- (BOOL)validateTextLength:(UITextView *)textView Text:(NSString *)text {
    
    //这个判断相当于是textfield中的点击return的代理方法
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    //在输入过程中 判断加上输入的字符 是否超过限定字数
    NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, text];
    if (str.length > _lengthLimit)
    {
        textView.text = [str substringToIndex:_lengthLimit];
        
        if (self.RemainCountBlock) {
            self.RemainCountBlock(0);
        }
        
        return NO;
    }
    
    if (self.RemainCountBlock) {
        self.RemainCountBlock(_lengthLimit - str.length);
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
- (BOOL)onePointFormat:(UITextView *)textView Range:(NSRange)range Text:(NSString *)text {
    //限制只能输入数字
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
                        NSLog(@"最多一位小数");
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


#pragma mark - 键盘监听
- (void)addKeyboardObserver {
    
    //监听键盘通知
    [HPNOTIF addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
}

- (void)removeKeyboardObserver {
    [HPNOTIF removeObserver:self];
}

- (void)keyboardFrameChange:(NSNotification *)notice {
    //获取键盘弹出前的Rect
    NSValue *keyBoardBeginBounds=[[notice userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect=[keyBoardBeginBounds CGRectValue];
    
    //获取键盘弹出后的Rect
    NSValue *keyBoardEndBounds=[[notice userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  endRect=[keyBoardEndBounds CGRectValue];
    
    //获取键盘位置变化前后纵坐标Y的变化值
    CGFloat deltaY=endRect.origin.y-beginRect.origin.y;
    NSLog(@"键盘弹出 Y值的变化:%f",deltaY);
    
    if (self.frame.origin.y + deltaY <= 0) {
        //在0.25s内完成self.view的Frame的变化，等于是给self.view添加一个向上移动deltaY的动画
        [UIView animateWithDuration:0.1f animations:^{
            [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y+deltaY, self.frame.size.width, self.frame.size.height)];
        }];
    }
    
}

@end
