//
//  UIButton+extension.m
//  SLYP
//
//  Created by 秦正华 on 2016/11/16.
//  Copyright © 2016年 马晓明. All rights reserved.
//


#import "UIButton+HPExtension.h"
#import <objc/runtime.h>

@implementation UIButton (HPExtension)


+ (instancetype)initButtonTitleFont:(CGFloat)font titleColor:(UIColor *)color titleName:(NSString *)name {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:[color colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    [btn.titleLabel setFont:[UIFont hp_systemFontOfSize:font]];
    return btn;
}

- (void)setButtonTitleFont:(CGFloat)font titleColor:(UIColor *)color titleName:(NSString *)name {
    
    [self setTitle:name forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont hp_systemFontOfSize:font]];
}


// 创建文字图片btn
+ (instancetype)initButtonTitleFont:(CGFloat)font titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backColor imageName:(NSString *)imageName titleName:(NSString *)titleName {
    
    titleName = titleName == nil ? @"" : titleName;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitle:titleName forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont hp_systemFontOfSize:font]];
    btn.backgroundColor = backColor;
    return btn;
}

- (void)setButtonTitleFont:(CGFloat)font titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backColor imageName:(NSString *)imageName titleName:(NSString *)titleName {
    
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self setTitle:titleName forState:UIControlStateNormal];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont hp_systemFontOfSize:font]];
}


// 创建文字圆角btn
+ (instancetype)initButtonTitleFont:(CGFloat)font titleColor:(UIColor *)titleColor titleName:(NSString *)titleName backgroundColor:(UIColor *)backColor radius:(CGFloat)radius {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:titleName forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont hp_systemFontOfSize:font]];
    btn.backgroundColor = backColor;
    if (radius > 0) {
        btn.layer.cornerRadius = radius;
        btn.layer.masksToBounds = YES;
    }
    return btn;
}

- (void)setButtonTitleFont:(CGFloat)font titleColor:(UIColor *)titleColor titleName:(NSString *)titleName backgroundColor:(UIColor *)backColor radius:(CGFloat)radius {
    
    [self setTitle:titleName forState:UIControlStateNormal];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont hp_systemFontOfSize:font]];
    self.backgroundColor = backColor;
    if (radius > 0) {
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = YES;
    }
}

- (void)addTarget:(nullable id)target tag:(NSInteger)tag action:(SEL)action
{
    self.tag = tag;
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end



@implementation UIButton (EnlargeTouchArea)

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect
{
    NSNumber *topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber *rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber *bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber *leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else
    {
        return self.bounds;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}

@end
