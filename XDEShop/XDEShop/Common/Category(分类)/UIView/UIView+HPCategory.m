//
//  UIView+extension.m
//  NBWeiBo
//
//  Created by apple on 15/6/13.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIView+HPCategory.h"

@implementation UIView (HPCategory)

#pragma mark - 创建view
+ (instancetype)initViewBackColor:(UIColor *)color {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    return view;
}

+ (instancetype)initLineBackColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height maxY:(CGFloat)originY {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, originY, width, height)];
    view.backgroundColor = color;
    return view;
}

-(void) addToWindow
{
    id appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate respondsToSelector:@selector(window)])
    {
        UIWindow * window = (UIWindow *) [appDelegate performSelector:@selector(window)];
        [window addSubview:self];
    }
}


#pragma mark - 添加点击任务
- (void)addTarget:(id)target action:(SEL)action {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}


#pragma mark - layer
- (void)rounded:(CGFloat)cornerRadius {
    //    self.layer.cornerRadius = cornerRadius;
    //    self.layer.masksToBounds = YES;
    
    [self rounded:cornerRadius rectCorners:UIRectCornerAllCorners];
}

- (void)border:(CGFloat)borderWidth color:(UIColor *)borderColor {
    //    self.layer.borderWidth = borderWidth;
    //    self.layer.borderColor = [borderColor CGColor];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = [UIBezierPath bezierPathWithRect:maskLayer.bounds].CGPath;
    maskLayer.fillColor = [UIColor clearColor].CGColor;
    maskLayer.strokeColor = borderColor.CGColor;
    maskLayer.lineWidth = borderWidth;
    [self.layer addSublayer:maskLayer];
}

- (void)rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor {
    //    self.layer.cornerRadius = cornerRadius;
    //    self.layer.borderWidth = borderWidth;
    //    self.layer.borderColor = [borderColor CGColor];
    //    self.layer.masksToBounds = YES;
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius].CGPath;
    self.layer.mask = maskLayer;
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    layer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius].CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = borderColor.CGColor;
    layer.lineWidth = borderWidth;
    [self.layer addSublayer:layer];
}


- (void)rounded:(CGFloat)cornerRadius rectCorners:(UIRectCorner)rectCorner {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


- (void)shadow:(UIColor *)shadowColor opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset {
    
    //给Cell设置阴影效果
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
    self.layer.shadowOffset = offset;
}


#pragma mark - base
- (UIViewController *)belongViewController {
    
    for (UIView *next = [self superview]; next; next = next.superview) {
        
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}



@end
