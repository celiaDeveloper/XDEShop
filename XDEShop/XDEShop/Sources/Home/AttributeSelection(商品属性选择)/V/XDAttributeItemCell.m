//
//  XDAttributeItemCell.m
//  XDEShop
//
//  Created by Celia on 2018/4/23.
//  Copyright © 2018年 Hopex. All rights reserved.
//

#import "XDAttributeItemCell.h"

#import "XDAttributeItem.h"
#import "XDAttributeList.h"

@interface XDAttributeItemCell ()

/* 属性 */
@property (nonatomic, strong) UILabel *attLabel;

@end

@implementation XDAttributeItemCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI {
    _attLabel = [[UILabel alloc] init];
    _attLabel.textAlignment = NSTextAlignmentCenter;
    _attLabel.font = [UIFont hp_systemFontOfSize:18];
    [self addSubview:_attLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_attLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}


#pragma mark - Setter Getter Methods

- (void)setContent:(XDAttributeList *)content {
    _content = content;
    _attLabel.text = content.infoname;
    
    if (content.isSelect) {
        _attLabel.textColor = [UIColor redColor];
        _attLabel.layer.borderColor = [UIColor redColor].CGColor;
        _attLabel.layer.borderWidth = 1.0;
        _attLabel.layer.cornerRadius = 5.0;
        _attLabel.layer.masksToBounds = YES;
        
    }else{
        _attLabel.textColor = [UIColor blackColor];
        _attLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _attLabel.layer.borderWidth = 1.0;
        _attLabel.layer.cornerRadius = 5.0;
        _attLabel.layer.masksToBounds = YES;
       
    }
}

@end
