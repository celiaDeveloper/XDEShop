//
//  MSSAutoresizeLabelFlowCell.m
//  XDAutoresizeLabelFlow
//
//  Created by Celia on 2018/4/11.
//  Copyright © 2018年 HP. All rights reserved.
//

#import "XDAutoresizeLabelFlowCell.h"
#import "XDAutoresizeLabelFlowConfig.h"
#define JKColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
@interface XDAutoresizeLabelFlowCell ()

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation XDAutoresizeLabelFlowCell

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = [XDAutoresizeLabelFlowConfig shareConfig].itemColor;
        _titleLabel.textColor = [XDAutoresizeLabelFlowConfig shareConfig].textColor;
        _titleLabel.font = [XDAutoresizeLabelFlowConfig shareConfig].textFont;
        _titleLabel.layer.cornerRadius = [XDAutoresizeLabelFlowConfig shareConfig].itemCornerRaius;
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.layer.borderColor = JKColor(180, 180, 180, 1.0).CGColor;
        _titleLabel.layer.borderWidth = 0.5;
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)configCellWithTitle:(NSString *)title {
    self.titleLabel.frame = self.bounds;
    self.titleLabel.text = title;
}

- (void)setBeSelected:(BOOL)beSelected {
    _beSelected = beSelected;
    if (beSelected) {
        self.titleLabel.backgroundColor = [XDAutoresizeLabelFlowConfig shareConfig].itemSelectedColor;
        self.titleLabel.textColor = [XDAutoresizeLabelFlowConfig shareConfig].textSelectedColor;
    }else {
       self.titleLabel.backgroundColor = [XDAutoresizeLabelFlowConfig shareConfig].itemColor;
        self.titleLabel.textColor = [XDAutoresizeLabelFlowConfig shareConfig].textColor;
    }
}

@end
