//
//  AddandCutView.m
//  SLYP
//
//  Created by 秦正华 on 2017/3/17.
//  Copyright © 2017年 马晓明. All rights reserved.
//

#import "HPAddandCutView.h"

@implementation HPAddandCutView
{
    UIButton * addbtn;         //增加按钮
    UIButton * cutbtn;        //减少按钮
    UITextField * countfiled;//数量显示和输入框
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createInterface];
    }
    return self;
}

- (void)createInterface {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    self.layer.borderWidth = 1;
    
    cutbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cutbtn setTitle:@"➖" forState:UIControlStateNormal];
    [cutbtn setTitleColor:[UIColor darkGrayColor]  forState:UIControlStateNormal];
    [cutbtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    cutbtn.frame = CGRectMake(0, 0, self.bounds.size.width/3, self.bounds.size.height);
    cutbtn.tag = 101;
    [cutbtn addTarget:self action:@selector(goodsCountNumClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cutbtn];
    
    countfiled = [[UITextField alloc]init];
    [self addSubview:countfiled];
    countfiled.frame = CGRectMake(CGRectGetMaxX(cutbtn.frame), 0, self.bounds.size.width/3, self.bounds.size.height);
    countfiled.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    countfiled.layer.borderWidth = 1;
    countfiled.layer.cornerRadius = 0;
    
    countfiled.text = @"0";
    countfiled.font = [UIFont systemFontOfSize:12];
    countfiled.textAlignment = NSTextAlignmentCenter;
    countfiled.keyboardType = UIKeyboardTypeNumberPad;
    countfiled.delegate = self;
    
    addbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addbtn setTitle:@"➕" forState:UIControlStateNormal];
    [addbtn setTitleColor:[UIColor darkGrayColor]  forState:UIControlStateNormal];
    [addbtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self addSubview:addbtn];
    addbtn.frame = CGRectMake(CGRectGetMaxX(countfiled.frame), 0, self.bounds.size.width/3, self.bounds.size.height);
    addbtn.tag = 102;
    [addbtn addTarget:self action:@selector(goodsCountNumClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setNum:(NSInteger)num {
    _num = num;
    countfiled.text = [NSString stringWithFormat:@"%ld",(long)_num];
}
#pragma mark - 点击增加/减少按钮方法
- (void)goodsCountNumClick:(UIButton *)sender {
    
    if (sender.tag == 101) {
        if (self.num <= self.min_num) {
            return;
        }
        self.num --;
    }
    if (sender.tag == 102) {
        if (self.num >= self.max_num) {
            return;
        }
        self.num ++;
    }
    
    if ([self.delegate respondsToSelector:@selector(HPAddandCutView_getNumber:)]) {
        [self.delegate HPAddandCutView_getNumber:[NSString stringWithFormat:@"%ld",(long)_num]];
    }
    
    if ([self.delegate respondsToSelector:@selector(HPAddandCutViewDelegateForCountButton: withNumMark:)]) {
        [self.delegate HPAddandCutViewDelegateForCountButton:sender withNumMark:countfiled];
    }
}
#pragma mark -- 输入框完成输入代理方法
- (void)textFieldDidEndEditing:(UITextField *)textField {
    _num = textField.text.intValue;
    if ([self.delegate respondsToSelector:@selector(HPAddandCutView_getNumber:)]) {
        [self.delegate HPAddandCutView_getNumber:[NSString stringWithFormat:@"%ld",(long)_num]];
    }
    
    if ([self.delegate respondsToSelector:@selector(HPAddandCutViewDelegateForNumberTextFiled:)]) {
        [self.delegate HPAddandCutViewDelegateForNumberTextFiled:textField];
    }
}

-(NSInteger)max_num {
    if (_max_num == 0) {
        return 999;
    }
    
    return _max_num;
}

@end
