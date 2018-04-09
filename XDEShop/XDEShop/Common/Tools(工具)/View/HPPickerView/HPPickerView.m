//
//  AddressPickerView.m
//  testUTF8
//
//  Created by rhcf_wujh on 16/7/14.
//  Copyright © 2016年 wjh. All rights reserved.
//

#import "HPPickerView.h"


@interface HPPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
/**标题栏背景*/
@property (nonatomic ,strong) UIView   * titleBackgroundView;
/**取消按钮*/
@property (nonatomic ,strong) UIButton * cancelBtn;
/**完成按钮*/
@property (nonatomic, strong) UIButton * sureBtn;
/**选择器*/
@property (nonatomic ,strong) UIPickerView   * selectPickerView;

@end
@implementation HPPickerView

static CGFloat const TITLEHEIGHT = 40.0;
static CGFloat const TITLEBUTTONWIDTH = 75.0;



- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    [self.selectPickerView reloadAllComponents];
    for (int i = 0; i < _dataArr.count; i++) {
        [self.selectPickerView selectRow:([_dataArr[i] count]/2.0-0.5) inComponent:i animated:YES];
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createrInterface];
    }
    return self;
}

- (void)createrInterface {
    [self addSubview:self.titleBackgroundView];
    [self.titleBackgroundView addSubview:self.cancelBtn];
    [self.titleBackgroundView addSubview:self.sureBtn];
    [self addSubview:self.selectPickerView];
}

#pragma mark - UIPickerDatasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return _dataArr.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [_dataArr[component] count];
    
}

#pragma mark - UIPickerViewDelegate
#pragma mark 填充文字
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _dataArr[component][row];
}

#pragma mark pickerView被选中
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textColor = [UIColor grayColor];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark - AddressPickerViewDelegate
- (void)cancelBtnClicked {
    if ([_delegate respondsToSelector:@selector(cancelBtnClick)])
    {
        [_delegate cancelBtnClick];
    }
}

- (void)sureBtnClicked {
    if ([_delegate respondsToSelector:@selector(sureBtnClickReturnContent:)])
    {
        NSMutableString *content = [NSMutableString string];
        for (int i = 0; i<_dataArr.count; i++) {
            NSInteger row = [self.selectPickerView selectedRowInComponent:i];
            NSString *str = _dataArr[i][row];
            if (i > 0 && i < _dataArr.count) {
                str = [NSString stringWithFormat:@"-%@",str];
            }
            [content appendString:str];
        }
        [self.delegate sureBtnClickReturnContent:content];
        [_delegate cancelBtnClick];
    }
}

#pragma mark - 懒加载
- (UIView *)titleBackgroundView {
    if (!_titleBackgroundView)
    {
        _titleBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, TITLEHEIGHT)];
        _titleBackgroundView.backgroundColor = [UIColor lightGrayColor];
    }
    return _titleBackgroundView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn)
    {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, TITLEBUTTONWIDTH, TITLEHEIGHT)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClicked)
             forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn {
    if (!_sureBtn)
    {
        _sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - TITLEBUTTONWIDTH, 0, TITLEBUTTONWIDTH, TITLEHEIGHT)];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
- (UIPickerView *)selectPickerView {
    if (!_selectPickerView)
    {
        _selectPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, TITLEHEIGHT, self.bounds.size.width, 160)];
        _selectPickerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _selectPickerView.delegate = self;
        _selectPickerView.dataSource = self;
    }
    return _selectPickerView;
}

@end
