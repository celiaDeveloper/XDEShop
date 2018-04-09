//
//  ImageCodeView.m
//  VerCodeView
//
//  Created by hpjr on 2016/12/22.
//  Copyright © 2016年 sands. All rights reserved.
//

#import "HPImageCodeView.h"

#define CODE_LENGTH 4
#define ARCNUMBER arc4random() % 100 / 100.0
#define ARC_COLOR [UIColor colorWithRed:ARCNUMBER green:ARCNUMBER blue:ARCNUMBER alpha:0.2]

@implementation HPImageCodeView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

//兼容nib使用
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

#pragma mark - 设置默认参数
- (void)setupUI {

    self.CodeArr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"];
    
    UITapGestureRecognizer* changeCode = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                action:@selector(changeCode)];
    [self addGestureRecognizer:changeCode];
    
    self.backgroundColor = ARC_COLOR;
    
    [self getStrCode];
}

#pragma mark - 随机生成验证码字符串
- (void)getStrCode {
    self.backgroundColor = ARC_COLOR;
    
    NSMutableString* tmpStr = [[NSMutableString alloc] initWithCapacity:5];;
    for (int i = 0; i < CODE_LENGTH; i++) {
        NSInteger index = arc4random() % (self.CodeArr.count-1);
        [tmpStr appendString:[self.CodeArr objectAtIndex:index]];
    }
    self.CodeStr = [NSString stringWithFormat:@"%@",tmpStr];
}

/**
 *刷新验证码
 */
- (void)changeCode {
    [self getStrCode];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGSize cSize = [@"A" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];//计算单个字所需空间
    int width = rect.size.width / self.CodeStr.length - cSize.width;//间距
    int height = rect.size.height - cSize.height;//可浮动高度
    CGPoint point;
    //绘码
    float pX, pY;
    for (int i = 0; i < self.CodeStr.length; i++)
    {
        pX = arc4random() % width + rect.size.width / self.CodeStr.length * i;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        unichar c = [self.CodeStr characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        [textC drawAtPoint:point withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    }
    
    //干扰线
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    for(int cout = 0; cout < 10; cout++)
    {
        CGContextSetStrokeColorWithColor(context, [ARC_COLOR CGColor]);
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextMoveToPoint(context, pX, pY);
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextAddLineToPoint(context, pX, pY);
        CGContextStrokePath(context);
    }
}


@end
