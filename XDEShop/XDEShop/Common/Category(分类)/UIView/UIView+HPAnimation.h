//
//  UIView+XMAnimation.h
//  项目初始化模板(TableBarStyle)
//
//  Created by 秦正华 on 2017/5/17.
//  Copyright © 2017年 qinzhenghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HPAnimation)

/** 两边延伸动画 */
- (void)animationMiddleToSides;

/** 左右抖动动画 */
- (void) shakeAnimation;

/** 旋转180度 */
- (void) trans180DegreeAnimation;

@end
