//
//  SearchButtonView.m
//  SLYP
//
//  Created by 秦正华 on 2017/2/21.
//  Copyright © 2017年 马晓明. All rights reserved.
//

#import "HPSearchButtonView.h"

@implementation HPSearchButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createInterface];
    }
    return self;
}

- (void)createInterface {
    [self setImage:[UIImage imageNamed:@"search_gray"] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:18]];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    [self addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleLeft imageTitleSpace:6.5];
}

- (void)setPlaceholdertext:(NSString *)Placeholdertext {
    _Placeholdertext = Placeholdertext;
    [self setTitle:_Placeholdertext forState:UIControlStateNormal];
    
}
#pragma mark - 实现点击按钮方法
-(void)btnClick {
    if ([self.delegate respondsToSelector:@selector(HPSearchButtonViewDelegate)]) {
        [self.delegate HPSearchButtonViewDelegate];
    }
}



@end
