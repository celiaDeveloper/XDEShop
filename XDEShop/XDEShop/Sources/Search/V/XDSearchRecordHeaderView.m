//
//  XDSearchRecordHeaderView.m
//  B2B2C
//
//  Created by Celia on 2018/1/11.
//  Copyright © 2018年 HP. All rights reserved.
//

#import "XDSearchRecordHeaderView.h"

@interface XDSearchRecordHeaderView ()
@property (nonatomic, strong) UIImageView *leftIV;
@property (nonatomic, strong) UILabel *title;
@end

@implementation XDSearchRecordHeaderView

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
- (void)deleteButtonClicked:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(XDSearchRecordHeaderViewDeleteAction)]) {
        [self.delegate XDSearchRecordHeaderViewDeleteAction];
    }
}


#pragma mark - 代理协议
#pragma mark - 数据请求 / 数据处理
- (void)setHaveDeleteBtn:(BOOL)haveDeleteBtn {
    _haveDeleteBtn = haveDeleteBtn;
    if (haveDeleteBtn) {
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setImage:GetImage(@"delete_icon") forState:UIControlStateNormal];
        deleteBtn.frame = CGRectMake(self.width - 60, 5, 50, self.height - 10);
        [deleteBtn addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:deleteBtn];
    }
}

- (void)setTitleString:(NSString *)titleString {
    _titleString = titleString;
    _title.text = titleString;
}

#pragma mark - 视图布局
- (void)createInterface {
    // 图片
    self.leftIV = [UIImageView initImageView:@"fire_icon"];
    [self addSubview:self.leftIV];
    
    // 标题
    self.title = [UILabel initLabelTextFont:20 textColor:[UIColor blackColor] title:@""];
    [self addSubview:self.title];
    
}

- (void)setConstraints {
    [self.leftIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(6);
        make.centerY.equalTo(self);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(28);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self).offset(-80);
    }];
}

#pragma mark - 懒加载

@end
