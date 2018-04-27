//
//  XDAttributeChoseTopCell.m
//  XDEShop
//
//  Created by Celia on 2018/4/23.
//  Copyright © 2018年 Hopex. All rights reserved.
//

#import "XDAttributeChoseTopCell.h"

@interface XDAttributeChoseTopCell ()

/* 取消 */
@property (nonatomic, strong) UIButton *crossButton;

@end

@implementation XDAttributeChoseTopCell

#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpUI {
    _crossButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_crossButton setImage:[UIImage imageNamed:@"icon_cha"] forState:0];
    [_crossButton addTarget:self action:@selector(crossButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_crossButton];
    
    _goodImageView = [UIImageView new];
    [self.contentView addSubview:_goodImageView];
    
    _goodPriceLabel = [UILabel initLabelTextFont:22 textColor:[UIColor darkGrayColor] title:@""];
    [self.contentView addSubview:_goodPriceLabel];
    
    _storageLabel = [UILabel initLabelTextFont:20 textColor:[UIColor darkGrayColor] title:@""];
    [self.contentView addSubview:_storageLabel];
    
    _chooseAttLabel = [UILabel initLabelTextFont:20 textColor:[UIColor darkGrayColor] title:@""];
    _chooseAttLabel.numberOfLines = 2;
    [self.contentView addSubview:_chooseAttLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_crossButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self.contentView)setOffset:-10];
        [make.top.mas_equalTo(self.contentView)setOffset:10];
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    [_goodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.contentView)setOffset:10];
        [make.top.mas_equalTo(self.contentView)setOffset:10];
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [_goodPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_goodImageView.mas_right)setOffset:10];
        make.top.mas_equalTo(_goodImageView).offset(3);
    }];
    
    [_storageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodPriceLabel);
        [make.top.mas_equalTo(_goodPriceLabel.mas_bottom)setOffset:5];
    }];
    
    [_chooseAttLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodPriceLabel);
        make.right.mas_equalTo(_crossButton.mas_left);
        [make.top.mas_equalTo(_storageLabel.mas_bottom)setOffset:5];
    }];
    
}


- (void)crossButtonClick {
    !_crossButtonClickBlock ?: _crossButtonClickBlock();
}

#pragma mark - Setter Getter Methods


@end
