//
//  UIButton+Badge.m
//  SLYP
//
//  Created by 秦正华 on 2017/2/22.
//  Copyright © 2017年 马晓明. All rights reserved.
//

#import "UIView+Badge.h"
#import <objc/runtime.h>

NSString const *badgeKey                 = @"badgeKey";
NSString const *badgeStyleKey            = @"badgeStyleKey";
NSString const *badgeBGColorKey          = @"badgeBGColorKey";
NSString const *badgeTextColorKey        = @"badgeTextColorKey";
NSString const *badgeFontKey             = @"badgeFontKey";
NSString const *badgePaddingKey          = @"badgePaddingKey";
NSString const *badgeMinSizeKey          = @"badgeMinSizeKey";
NSString const *badgeOriginXKey          = @"badgeOriginXKey";
NSString const *badgeOriginYKey          = @"badgeOriginYKey";
NSString const *shouldHideBadgeAtZeroKey = @"shouldHideBadgeAtZeroKey";
NSString const *shouldAnimateBadgeKey    = @"shouldAnimateBadgeKey";
NSString const *badgeValueKey            = @"badgeValueKey";

@implementation UIButton (Badge)

- (void)badgeInit
{
    // 初始化，设定默认值
    self.badgeBGColor   = [UIColor redColor];
    self.badgeTextColor = [UIColor whiteColor];
    self.badgeFont      = [UIFont systemFontOfSize:14];
    self.badgePadding   = 0;
    self.badgeMinSize   = 0;
    self.badgeOriginX   = self.frame.size.width - 4;
    self.badgeOriginY   = -4;
    self.shouldHideBadgeAtZero = YES;
    self.shouldAnimateBadge = YES;
    // 避免角标被裁剪
    self.clipsToBounds = NO;
}

-(void)initBage:(BadgeStyle)badgeStyle
{
    [self badgeInit];
    self.badge = [[UILabel alloc]init];
    [self addSubview:self.badge];
    self.badge.hidden = true;
    switch (badgeStyle) {
        case BadgeStyleNumber:
        {
            self.badge.frame = CGRectMake(self.badgeOriginX, self.badgeOriginY, 18, 18);
            self.badge.textColor            = self.badgeTextColor;
            self.badge.backgroundColor      = self.badgeBGColor;
            self.badge.font                 = self.badgeFont;
            self.badge.textAlignment        = NSTextAlignmentCenter;
        }
            break;
            
        case BadgeStylePoint:
        {
            self.badge.frame = CGRectMake(self.badgeOriginX, self.badgeOriginY, 10, 10);
            self.badge.textColor            = self.badgeBGColor;
            self.badge.backgroundColor      = self.badgeBGColor;
            self.badge.layer.cornerRadius = 10 / 2;
            self.badge.layer.masksToBounds = YES;
        }
            break;
            
        default:
            break;
    }

}

#pragma mark - Utility methods

// 当角标的属性改变时，调用此方法
- (void)refreshBadge
{
    // 更新属性
    self.badge.textColor        = self.badgeTextColor;
    self.badge.backgroundColor  = self.badgeBGColor;
    self.badge.font             = self.badgeFont;
}

- (CGSize) badgeExpectedSize
{
    // 自适应角标
    UILabel *frameLabel = [self duplicateLabel:self.badge];
    [frameLabel sizeToFit];
    
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
}
/**
 *  更新角标的frame
 */
- (void)updateBadgeFrame
{
    if (self.badgeStyle == BadgeStylePoint) {
        
        CGRect bageFrame = self.badge.frame;
        bageFrame.origin.x = self.badgeOriginX;
        bageFrame.origin.y = self.badgeOriginY;
        self.badge.frame = bageFrame;
        return;
    }
    
    CGSize expectedLabelSize = [self badgeExpectedSize];
    
    CGFloat minHeight = expectedLabelSize.height;
    
    // 判断如果小于最小size，则为最小size
    minHeight = (minHeight < self.badgeMinSize) ? self.badgeMinSize : expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    CGFloat padding = self.badgePadding;
    
    // 填充边界
    minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width + 6;
    self.badge.frame = CGRectMake(self.badgeOriginX, self.badgeOriginY, minWidth + padding, minHeight + padding);
    self.badge.layer.cornerRadius = self.badge.frame.size.height / 2;
    self.badge.layer.masksToBounds = YES;
}

// 角标值变化
- (void)updateBadgeValueAnimated:(BOOL)animated
{
    // 动画效果
    if (animated && self.shouldAnimateBadge && ![self.badge.text isEqualToString:self.badgeValue]) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.4f :1.3f :1.f :1.f]];
        [self.badge.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    self.badge.text = self.badgeValue;
    [self updateBadgeFrame];
//    // 动画时间
//    NSTimeInterval duration = animated ? 0.2 : 0;
//    [UIView animateWithDuration:duration animations:^{
//        [self updateBadgeFrame];
//    }];
}

- (UILabel *)duplicateLabel:(UILabel *)labelToCopy
{
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:labelToCopy.frame];
    duplicateLabel.text = labelToCopy.text;
    duplicateLabel.font = labelToCopy.font;
    
    return duplicateLabel;
}

- (void)removeBadge
{
    // 移除角标
    [UIView animateWithDuration:0.2 animations:^{
        self.badge.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.badge removeFromSuperview];
        self.badge = nil;
    }];
}

#pragma mark - getters/setters
-(BadgeStyle)badgeStyle
{
    NSNumber *number = objc_getAssociatedObject(self, &badgeStyleKey);
    return number.integerValue;
}
-(void)setBadgeStyle:(BadgeStyle)badgeStyle
{
    NSNumber *number = [NSNumber numberWithInteger:badgeStyle];
    objc_setAssociatedObject(self, &badgeStyleKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (!self.badge) {
        [self initBage:badgeStyle];
    }
}

-(UILabel*) badge {
    return objc_getAssociatedObject(self, &badgeKey);
}
-(void)setBadge:(UILabel *)badgeLabel
{
    objc_setAssociatedObject(self, &badgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 显示角标
-(NSString *)badgeValue {
    return objc_getAssociatedObject(self, &badgeValueKey);
}

-(void) setBadgeValue:(NSString *)badgeValue
{
    objc_setAssociatedObject(self, &badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 当角标信息不存在，或者为空，则移除
    if (!badgeValue || [badgeValue isEqualToString:@""] || ([badgeValue isEqualToString:@"0"] && self.shouldHideBadgeAtZero)) {
        self.badge.hidden = true;
    } else {
        self.badge.hidden = false;
        [self updateBadgeValueAnimated:YES];
    }
}

//进行关联
-(UIColor *)badgeBGColor {
    return objc_getAssociatedObject(self, &badgeBGColorKey);
}
//获取关联
-(void)setBadgeBGColor:(UIColor *)badgeBGColor
{
    objc_setAssociatedObject(self, &badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

-(UIColor *)badgeTextColor {
    return objc_getAssociatedObject(self, &badgeTextColorKey);
}
-(void)setBadgeTextColor:(UIColor *)badgeTextColor
{
    objc_setAssociatedObject(self, &badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

-(UIFont *)badgeFont {
    return objc_getAssociatedObject(self, &badgeFontKey);
}
-(void)setBadgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, &badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

-(CGFloat) badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &badgePaddingKey);
    return number.floatValue;
}
-(void) setBadgePadding:(CGFloat)badgePadding
{
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

-(CGFloat) badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &badgeMinSizeKey);
    return number.floatValue;
}
-(void) setBadgeMinSize:(CGFloat)badgeMinSize
{
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

-(CGFloat) badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &badgeOriginXKey);
    return number.floatValue;
}
-(void) setBadgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

-(CGFloat) badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &badgeOriginYKey);
    return number.floatValue;
}
-(void) setBadgeOriginY:(CGFloat)badgeOriginY
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

-(BOOL) shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &shouldHideBadgeAtZeroKey);
    return number.boolValue;
}
- (void)setShouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero
{
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL) shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &shouldAnimateBadgeKey);
    return number.boolValue;
}
- (void)setShouldAnimateBadge:(BOOL)shouldAnimateBadge
{
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

