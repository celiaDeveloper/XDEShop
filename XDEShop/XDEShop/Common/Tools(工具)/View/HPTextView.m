//
//  XMTextView.m
//  SLYP
//
//  Created by 秦正华 on 2017/3/20.
//  Copyright © 2017年 马晓明. All rights reserved.
//

#import "HPTextView.h"

@implementation HPTextView

{
    UILabel * _textViewPlaceHolderLanel; //提示文字标签
    UILabel * _lenghLabel;               //提示文字数量标签
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createInterface];
    }
    return self;
}

- (void)createInterface {
    self.backgroundColor = [UIColor whiteColor];
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, self.bounds.size.width - 20 ,self.bounds.size.height - 20)];
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _textView.delegate = self;
    [self addSubview:_textView];
    
    _textViewPlaceHolderLanel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(_textView.frame), 20)];
    _textViewPlaceHolderLanel.textColor = [UIColor lightGrayColor];
    _textViewPlaceHolderLanel.text = @"请输入您需要填写的内容？";
    _textViewPlaceHolderLanel.numberOfLines = 0;
    _textViewPlaceHolderLanel.font = [UIFont systemFontOfSize:14];
    [_textView addSubview:_textViewPlaceHolderLanel];
    

    _lenghLabel = [[UILabel alloc]init];
    _lenghLabel.textColor = [UIColor redColor];
    _lenghLabel.font = [UIFont systemFontOfSize:11];
    [_textView addSubview:_lenghLabel];
    _lenghLabel.textAlignment = NSTextAlignmentRight;
    _lenghLabel.frame = CGRectMake(_textView.bounds.size.width-55, _textView.bounds.size.height-15, 50, 10);
}

- (void)setPlaceholdertext:(NSString *)Placeholdertext {
     _textViewPlaceHolderLanel.text = Placeholdertext;
    CGSize titleSize = [Placeholdertext boundingRectWithSize:CGSizeMake(_textViewPlaceHolderLanel.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.fontSize ? : 14]} context:nil].size;
    _textViewPlaceHolderLanel.frame = CGRectMake(5, 5, CGRectGetWidth(_textView.frame), titleSize.height);
}

-(void)setTextTips:(BOOL)textTips
{
    _textTips = textTips;
    _lenghLabel.hidden = !_textTips;
}

-(void)setMaxTextLength:(NSInteger)maxTextLength
{
    _maxTextLength = maxTextLength;
    
    _lenghLabel.text = [NSString stringWithFormat:@"0/%ld",_maxTextLength];
}

-(void)setContentBackgroundColor:(UIColor *)contentBackgroundColor
{
    _contentBackgroundColor = contentBackgroundColor;
    
    _textView.backgroundColor = _contentBackgroundColor;
}

-(void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    _textView.font = [UIFont systemFontOfSize:_fontSize];
    _textViewPlaceHolderLanel.font = [UIFont systemFontOfSize:_fontSize];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView; {
    
    _lenghLabel.text = [NSString stringWithFormat:@"%ld/%ld",(unsigned long)_textView.text.length,_maxTextLength];
    
    if (textView.text.length) {
        _textViewPlaceHolderLanel.hidden = YES;
    }
    //TODO:限制开关为true,执行限制字数代码
    if (_textTips) {
        if (textView.text.length >= _maxTextLength/2) {
            textView.text = [textView.text substringToIndex:_maxTextLength/2];
            _lenghLabel.text = [NSString stringWithFormat:@"%ld/%ld",_maxTextLength,_maxTextLength];
        }
    }
    
    
    if (textView.text.length == 0) {
        _textViewPlaceHolderLanel.hidden = false;
    }
    
    self.contentText = textView.text;
}


@end
