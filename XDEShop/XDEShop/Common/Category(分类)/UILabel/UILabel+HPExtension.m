//
//  UILabel+extension.m
//  SLYP
//
//  Created by 秦正华 on 2016/11/18.
//  Copyright © 2016年 马晓明. All rights reserved.
//

#import "UILabel+HPExtension.h"

@implementation UILabel (HPExtension)

+ (instancetype)initLabelTextFont:(CGFloat)font textColor:(UIColor *)textColor title:(NSString *)text {
    
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.font = [UIFont hp_systemFontOfSize:font];
    label.textColor = textColor;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    return label;
}

- (void)setLabelTextFont:(CGFloat)font textColor:(UIColor *)textColor title:(NSString *)text {
    
    self.text = text;
    self.font = [UIFont hp_systemFontOfSize:font];
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.textColor = textColor;
}

+ (instancetype)initAttributeLabelAttributeFont:(CGFloat)font attributeColor:(UIColor *)textColor otherFont:(CGFloat)otherFont otherColor:(UIColor *)otherColor leftText:(NSString *)leftText middleText:(NSString *)middleText rightText:(NSString *)rightText {
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = otherColor;
    label.font = [UIFont hp_systemFontOfSize:otherFont];
    NSString *str = [NSString stringWithFormat:@"%@%@%@",leftText,middleText,rightText];
    long leftLength = [leftText length];
    long middleLength = [middleText length];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(leftLength,middleLength)];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont hp_systemFontOfSize:font] range:NSMakeRange(leftLength,middleLength)];
    label.attributedText = attributeStr;
    return label;
}

- (void)setAttributeLabelAttributeFont:(CGFloat)font attributeColor:(UIColor *)textColor otherFont:(CGFloat)otherFont otherColor:(UIColor *)otherColor leftText:(NSString *)leftText middleText:(NSString *)middleText rightText:(NSString *)rightText {
    
    self.textColor = otherColor;
    self.font = [UIFont hp_systemFontOfSize:otherFont];
    NSString *str = [NSString stringWithFormat:@"%@%@%@",leftText,middleText,rightText];
    long leftLength = [leftText length];
    long middleLength = [middleText length];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(leftLength,middleLength)];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont hp_systemFontOfSize:font] range:NSMakeRange(leftLength,middleLength)];
    self.attributedText = attributeStr;
}

+ (instancetype)initStrikethroughLabelTextFont:(CGFloat)font textColor:(UIColor *)color text:(NSString *)text {
    
    UILabel *label = [[UILabel alloc]init];
    NSString *tmp = text == nil ? @"" : text;
    long length = [tmp length];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSDictionary *dict = @{NSFontAttributeName : [UIFont hp_systemFontOfSize:font],
                           NSStrikethroughColorAttributeName : [UIColor blackColor],
                           NSStrikethroughStyleAttributeName :@(NSUnderlineStyleSingle),
                           NSForegroundColorAttributeName:color,
                           NSBaselineOffsetAttributeName:@(0)};
    [attributeStr addAttributes:dict range:NSMakeRange(0, length)];
    label.attributedText = attributeStr;
    return label;
}

- (void)setStrikethroughLabelTextFont:(CGFloat)font textColor:(UIColor *)color text:(NSString *)text {
    
    NSString *tmp = text == nil ? @"" : text;
    
    long length = [tmp length];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:tmp];
    
    NSDictionary *dict = @{NSFontAttributeName : [UIFont hp_systemFontOfSize:font],
                           NSStrikethroughColorAttributeName : [UIColor blackColor],
                           NSStrikethroughStyleAttributeName :@(NSUnderlineStyleSingle),
                           NSForegroundColorAttributeName:color,
                           NSBaselineOffsetAttributeName:@(0)};
    
    [attributeStr addAttributes:dict range:NSMakeRange(0, length)];
    
    self.attributedText = attributeStr;
}


- (CGSize)getLableCGSizeWithString:(NSString *)text fontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth {
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary * attributes = @{NSFontAttributeName:[UIFont hp_systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    return labelSize;
}

- (void)addUnderlineColor:(UIColor *)color toText:(NSString *)text {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    
    if (text) {
        NSRange itemRange = [self.text rangeOfString:text];
        [attributedString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:itemRange];
        if (color) {
            [attributedString addAttribute:NSUnderlineColorAttributeName value:color range:itemRange];
        }
    }
    
    self.attributedText = attributedString;
}

- (void)addDeletelineColor:(UIColor *)color toText:(NSString *)text {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    
    if (text) {
        NSRange itemRange = [self.text rangeOfString:text];
        color = color ? : [UIColor blackColor];
        NSDictionary *AttributeDict = @{NSStrikethroughColorAttributeName : color,
                               NSStrikethroughStyleAttributeName :@(NSUnderlineStyleSingle),
                               NSBaselineOffsetAttributeName:@(0)};
        [attributedString addAttributes:AttributeDict range:itemRange];
    }
    
    self.attributedText = attributedString;
}

- (void)changeTextColor:(UIColor *)color toText:(NSString *)text {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    
    if (text && color) {
        NSRange itemRange = [self.text rangeOfString:text];
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:itemRange];
    }
    self.attributedText = attributedString;
}

- (void)changeTextFontSize:(CGFloat)fontSize toText:(NSString *)text {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    
    if (text && fontSize) {
        NSRange itemRange = [self.text rangeOfString:text];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont hp_systemFontOfSize:fontSize] range:itemRange];
    }
    
    self.attributedText = attributedString;
}

- (void)changeLineSpace:(float)space {
    
    NSString *labelText = self.text;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSParagraphStyleAttributeName: paragraphStyle}];
    self.attributedText = attributedString;
//    [self sizeToFit];
}

- (void)changeWordSpace:(float)space {
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}




+ (float) heightForString:(NSString *)value andWidth:(float)width{
    //获取当前文本的属性
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:value];
    //_activityText.attributedText = attrStr;
    NSRange range = NSMakeRange(0, attrStr.length);
    // 获取该段attributedString的属性字典
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    // 计算文本的大小
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width - 16.0, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:dic        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.height + 16.0;
}



- (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(CGFloat)font {
    
    //1.1最大允许绘制的文本范围
    CGSize size = CGSizeMake(width, 2000);
    //1.2配置计算时的行截取方法,和contentLabel对应
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:10];
    //1.3配置计算时的字体的大小
    //1.4配置属性字典
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:style};
    //2.计算
    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    
    return height;
}


@end
