//
//  UITabBar+HPBage.h
//  ZHDJ
//
//  Created by 秦正华 on 2017/10/18.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (HPBage)

/** 显示红点 */
- (void)showBadgeOnItmIndex:(int)index;

/** 隐藏红点 */
- (void)hideBadgeOnItemIndex:(int)index;

@end
