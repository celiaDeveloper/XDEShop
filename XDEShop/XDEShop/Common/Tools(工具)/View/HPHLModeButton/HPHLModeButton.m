//
//  XM_HLModeButton.m
//  ZJSC
//
//  Created by 秦正华 on 2017/6/28.
//  Copyright © 2017年 zhijianshangcheng. All rights reserved.
//

#import "HPHLModeButton.h"

@implementation HPHLModeButton
#define COLOR_M [UIColor blueColor]
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createInterface];
    }
    return self;
}

-(void)createInterface
{
    [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
    self.adjustsImageWhenHighlighted = NO;
    self.sortMode = HPSortModeNone;
    
    
    [self addTarget:self action:@selector(sortBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 点击按钮实现方法
-(void)sortBtnClick
{
    
    if (_sortMode == HPSortModeNone) {
        self.sortMode = HPSortModeHigh;
        
        if ([self.delegate respondsToSelector:@selector(HPHLModeButton:SortMode:)]) {
            [self.delegate HPHLModeButton:self SortMode:self.sortMode];
        }
        return;
    }
    if (_sortMode == HPSortModeHigh) {
        self.sortMode = HPSortModeLow;
        
        if ([self.delegate respondsToSelector:@selector(HPHLModeButton:SortMode:)]) {
            [self.delegate HPHLModeButton:self SortMode:self.sortMode];
        }
        return;
    }
    if (_sortMode == HPSortModeLow) {
        self.sortMode = HPSortModeHigh;
        
        if ([self.delegate respondsToSelector:@selector(HPHLModeButton:SortMode:)]) {
            [self.delegate HPHLModeButton:self SortMode:self.sortMode];
        }
        return;
    }
}

-(void)setMenuName:(NSString *)menuName
{
    _menuName = menuName;
    [self setTitle:_menuName forState:0];
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.intrinsicContentSize.width, 0, -self.titleLabel.intrinsicContentSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.frame.size.width, 0, self.imageView.frame.size.width);
}

/**
 *根据按钮的状态改变按钮的图片
 */
-(void)setSortMode:(HPSortMode)sortMode
{
    _sortMode = sortMode;
    
    switch (_sortMode) {
        case HPSortModeNone:
            [self setImage:[UIImage imageNamed:@"HP_default"] forState:0];
            [self setTitleColor:[UIColor darkGrayColor] forState:0];
            break;
            
        case HPSortModeHigh:
            [self setImage:[UIImage imageNamed:@"HP_high"] forState:0];
            [self setTitleColor:COLOR_M forState:0];
            break;
            
        case HPSortModeLow:
            [self setImage:[UIImage imageNamed:@"HP_low"] forState:0];
            [self setTitleColor:COLOR_M forState:0];
            break;
            
        default:
            break;
    }
    

}


@end
