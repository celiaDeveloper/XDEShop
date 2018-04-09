//
//  XDSearchBarView.m
//  B2B2C
//
//  Created by Celia on 2018/1/11.
//  Copyright © 2018年 HP. All rights reserved.
//

#import "XDSearchBarView.h"

@interface XDSearchBarView () <UITextFieldDelegate>
@property (nonatomic, strong) UIButton *goodsBtn;
@property (nonatomic, strong) UIButton *storeBtn;
@property (nonatomic, strong) UIView *searchBackView;
@property (nonatomic, strong) UIButton *searchBtn;
@end

@implementation XDSearchBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createInterface];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setConstraints];
}

#pragma mark - 内部逻辑实现
- (void)topButtonClicked:(UIButton *)btn {
    btn.selected = YES;
    if (btn == self.goodsBtn && self.searchType == SearchTypeStore) {
        self.goodsBtn.backgroundColor = kCOLOR_M;
        self.storeBtn.backgroundColor = [UIColor whiteColor];
        self.storeBtn.selected = NO;
        self.searchType = SearchTypeGoods;
    }
    
    if (btn == self.storeBtn && self.searchType == SearchTypeGoods) {
        self.goodsBtn.backgroundColor = [UIColor whiteColor];
        self.goodsBtn.selected = NO;
        self.storeBtn.backgroundColor = kCOLOR_M;
        self.searchType = SearchTypeStore;
    }
}

- (void)searchButtonClicked:(UIButton *)btn {
    if (self.searchTF.text.length == 0) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(XDSearchBarViewToSearch:)]) {
        [self.delegate XDSearchBarViewToSearch:self.searchTF.text];
    }
}

#pragma mark - 代理协议
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(XDSearchBarViewToSearch:)]) {
        [self.delegate XDSearchBarViewToSearch:self.searchTF.text];
    }
    return YES;
}

#pragma mark - 数据请求 / 数据处理


#pragma mark - 视图布局
- (void)createInterface {
    // 宝贝
    self.goodsBtn = [UIButton initButtonTitleFont:22 titleColor:[UIColor whiteColor] titleName:@"宝贝"];
    self.goodsBtn.backgroundColor = kCOLOR_M;
    [self.goodsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.goodsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.goodsBtn];
    
    // 默认搜索宝贝
    self.goodsBtn.selected = YES;
    self.searchType = SearchTypeGoods;
    
    // 店铺
    self.storeBtn = [UIButton initButtonTitleFont:22 titleColor:[UIColor blackColor] titleName:@"店铺"];
    self.storeBtn.backgroundColor = [UIColor whiteColor];
    [self.storeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.storeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.storeBtn];
    
    // 点击
    [self.goodsBtn addTarget:self action:@selector(topButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.storeBtn addTarget:self action:@selector(topButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // 搜索容器
    self.searchBackView = [UIView initViewBackColor:[UIColor whiteColor]];
    self.searchBackView.layer.borderColor = kCOLOR_M.CGColor;
    self.searchBackView.layer.borderWidth = 2.0;
    [self addSubview:self.searchBackView];
    
    // 搜索框
    [self.searchBackView addSubview:self.searchTF];
    
    // 搜索按钮
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.searchBtn setImage:GetImage(@"search_icon") forState:UIControlStateNormal];
    self.searchBtn.backgroundColor = [UIColor whiteColor];
    [self.searchBackView addSubview:self.searchBtn];
    
    [self.searchBtn addTarget:self action:@selector(searchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setConstraints {
    [self.goodsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_centerY);
        make.width.mas_equalTo(80);
    }];
    
    [self.storeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsBtn.mas_right);
        make.top.bottom.equalTo(self.goodsBtn);
        make.width.equalTo(self.goodsBtn);
    }];
    
    [self.searchBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsBtn);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.goodsBtn.mas_bottom);
        make.bottom.equalTo(self);
    }];
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.searchBackView).offset(-2);
        make.top.equalTo(self.searchBackView).offset(2);
        make.bottom.equalTo(self.searchBackView).offset(-2);
        make.width.mas_equalTo(40);
    }];
    
    [self.searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchBackView).offset(5);
        make.right.equalTo(self.searchBtn.mas_left).offset(-5);
        make.top.bottom.equalTo(self.searchBtn);
    }];
    
    
}

#pragma mark - 懒加载
- (UITextField *)searchTF {
    if (!_searchTF) {
        _searchTF = [UITextField initTextFieldFont:20 LeftImageName:@"" Placeholder:@"请输入关键词"];
        _searchTF.borderStyle = UITextBorderStyleNone;
        _searchTF.returnKeyType = UIReturnKeySearch;
        _searchTF.enablesReturnKeyAutomatically = YES; //这里设置为无文字就灰色不可点
        _searchTF.clearButtonMode = UITextFieldViewModeNever;
        
        _searchTF.delegate = self;
    }
    return _searchTF;
}

@end
