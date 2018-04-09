//
//  ASBirthSelectSheet.m
//  ASBirthSheet
//
//  Created by Ashen on 15/12/8.
//  Copyright © 2015年 Ashen. All rights reserved.
//

#import "HPBirthDaySelectView.h"
#import <UIKit/UIKit.h>

static CGFloat MainScreenHeight = 0;
static CGFloat MainScreenWidth = 0;


@interface HPBirthDaySelectView()


@property (nonatomic, strong) UIView *containerView;        //主视图
@property (nonatomic, strong) UIDatePicker *datePicker;     //日期选择器
@property (nonatomic, strong) UIButton *doneBtn;            //确定按钮
@property (nonatomic, strong) UIButton *cancelBtn;          //取消按钮
@property (nonatomic, strong) NSDateFormatter *formatter;   //日期格式

@end
@implementation HPBirthDaySelectView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        MainScreenHeight = [UIScreen mainScreen].bounds.size.height;
        MainScreenWidth = [UIScreen mainScreen].bounds.size.width;
        [self setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmpty:)];
        [self addGestureRecognizer:tap];
        [self makeUI];
    }
    return self;
}

#pragma mark - 创建页面

- (void)makeUI {
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(10, MainScreenHeight - 290 - 70, MainScreenWidth - 20, 290)];
    _containerView.backgroundColor = [UIColor whiteColor];
    _containerView.layer.cornerRadius = 3;
    _containerView.layer.masksToBounds = YES;
    
    _datePicker =  [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 10, MainScreenWidth - 20, 200)];
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    _datePicker.locale = locale;
    [_datePicker setDate:[NSDate date] animated:YES];
    [_datePicker setMaximumDate:[NSDate date]];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    [_datePicker setMinimumDate:[self.formatter dateFromString:@"1970-01-01"]];
    [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [_containerView addSubview:_datePicker];
    
    
    _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _doneBtn.frame = CGRectMake(-0.4, CGRectGetMaxY(_datePicker.frame), MainScreenWidth - 19.2, 40);
    [_doneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_doneBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    _doneBtn.layer.borderWidth = 0.3;
    _doneBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [_containerView addSubview:_doneBtn];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(_doneBtn.frame), MainScreenWidth - 20, 40);
    [_cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_cancelBtn];
    
    [self addSubview:_containerView];
}

#pragma mark - private method
- (void)clickEmpty:(UITapGestureRecognizer *)tap {
    [self removeFromSuperview];
}
#pragma mark - Action
- (void)doneAction:(UIButton *)btn {
    if (self.GetSelectDate) {
        _GetSelectDate([self.formatter stringFromDate:_datePicker.date]);
        [self removeFromSuperview];
    }
}

- (void)cancelAction:(UIButton *)btn {
    [self removeFromSuperview];
}

- (void)dateChange:(id)datePicker {
    
}

#pragma mark - setter、getter
- (void)setSelectDate:(NSString *)selectDate {
    [_datePicker setDate:[self.formatter dateFromString:selectDate] animated:YES];
}
- (NSDateFormatter *)formatter {
    if (_formatter) {
        return _formatter;
    }
    _formatter =[[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    return _formatter;
    
}

@end
