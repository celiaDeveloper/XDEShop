//
//  XDAttributeHeaderView.m
//  XDEShop
//
//  Created by Celia on 2018/4/23.
//  Copyright © 2018年 Hopex. All rights reserved.
//

#import "XDAttributeHeaderView.h"

#import "XDAttributeTitleItem.h"

@interface XDAttributeHeaderView ()
/* 属性标题 */
@property (strong , nonatomic) UILabel *headerLabel;
/* 灰色线条 */
@property (strong , nonatomic) UIView *bottomView;

@end

@implementation XDAttributeHeaderView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    _headerLabel = [[UILabel alloc] init];
    _headerLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:_headerLabel];
    
    
    _bottomView = [UIView new];
    _bottomView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
    [self addSubview:_bottomView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:10];
        make.centerY.mas_equalTo(self);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - Setter Getter Methods
- (void)setHeadTitle:(XDAttributeTitleItem *)headTitle {
    _headTitle = headTitle;
    _headerLabel.text = headTitle.attrname;
}

@end
