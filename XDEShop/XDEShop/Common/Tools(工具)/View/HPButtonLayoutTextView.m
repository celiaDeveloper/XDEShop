//
//  XMButtonLayoutTextView.m
//  SLYP
//
//  Created by 秦正华 on 2017/3/8.
//  Copyright © 2017年 马晓明. All rights reserved.
//

#import "HPButtonLayoutTextView.h"
#define HPMW  [UIScreen mainScreen].bounds.size.width
#define HPMH  [UIScreen mainScreen].bounds.size.height
@implementation HPButtonLayoutTextView

{
    UIButton * lastselectBtn;//点击的按钮
    
    CGFloat totalHeight;    //需要View的高度
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setTextArr:(NSArray *)textArr {
    [self createInterface:textArr];
}

- (void)createInterface:(NSArray *)arr {
    
    _buttonTextFont = _buttonTextFont ? : 13;
    _buttonTextColor = _buttonTextColor ? : [UIColor darkGrayColor];
    _buttonBackgroundColor = _buttonBackgroundColor ? : [UIColor groupTableViewBackgroundColor];
    _buttonSelectColor = _buttonSelectColor ? : [UIColor blueColor];
    _buttonPadding = _buttonPadding ? : 20;
    _buttonHeight = _buttonHeight ? : 30;
    _buttonBetween = _buttonBetween ? : 10;
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 0;//用来控制button距离父视图的高
    for (int i = 0; i < arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:_buttonTextFont ? : 13];
        [button setTitleColor:_buttonTextColor forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setBackgroundImage:[self imageWithColor:_buttonBackgroundColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[self imageWithColor:_buttonSelectColor] forState:UIControlStateSelected];
        button.layer.cornerRadius = 2.5;
        button.layer.masksToBounds = YES;
        //根据计算文字的大小
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:_buttonTextFont]};
        CGFloat length = [arr[i] boundingRectWithSize:CGSizeMake(self.bounds.size.width, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        //为button赋值
        [button setTitle:arr[i] forState:UIControlStateNormal];
        //设置button的frame
        button.frame = CGRectMake(w, h, length + _buttonPadding, _buttonHeight);
        //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
        if(w + length + _buttonPadding > self.bounds.size.width){
            w = 0; //换行时将w置为0
            h = h + button.bounds.size.height + _buttonBetween;//距离父视图也变化
            button.frame = CGRectMake(w, h, length + _buttonPadding, _buttonHeight);//重设button的frame
        }
        w = button.bounds.size.width + button.frame.origin.x + _buttonBetween;
        
        totalHeight = CGRectGetMaxY(button.frame);
        self.height = totalHeight;
    }
}

-(void)setSameWidthButtonTitles:(NSArray *)titles
{
    _buttonTextFont = _buttonTextFont ? : 15;
    _buttonTextColor = _buttonTextColor ? : [UIColor darkGrayColor];
    _buttonBackgroundColor = _buttonBackgroundColor ? : [UIColor groupTableViewBackgroundColor];
    _buttonSelectColor = _buttonSelectColor ? : [UIColor blueColor];
    _buttonHeight = _buttonHeight ? : 25;
    _buttonBetween = _buttonBetween ? : 1;
    
    CGFloat button_w = (self.bounds.size.width - 3*_buttonBetween)/4;
    for (int i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:_buttonTextFont ? : 15];
        [button setTitleColor:_buttonTextColor forState:UIControlStateNormal];
        [button setTitleColor:[_buttonTextColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        button.backgroundColor = _buttonBackgroundColor;
        //为button赋值
        [button setTitle:titles[i] forState:UIControlStateNormal];
        //设置button的frame
        button.frame = CGRectMake(i%4*(button_w + _buttonBetween),i/4 * (_buttonBetween + _buttonHeight), button_w, _buttonHeight);
        
        self.height = CGRectGetMaxY(button.frame);
    }
}

#pragma mark - 点击按钮方法
- (void)handleClick:(UIButton *)btn {
    if (lastselectBtn != btn) {
        btn.selected = YES;
        lastselectBtn.selected = NO;
        lastselectBtn = btn;
    }
    
    if ([self.delegate respondsToSelector:@selector(HPButtonLayoutTextViewDelegate:btnIndex:)]) {
        [self.delegate HPButtonLayoutTextViewDelegate:btn btnIndex:btn.tag-100];
    }

}
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
