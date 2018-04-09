//
//  XMButtonLayoutTextView.h
//  SLYP
//
//  Created by 秦正华 on 2017/3/8.
//  Copyright © 2017年 马晓明. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HPButtonLayoutTextViewDelegate <NSObject>

/**
 *获取被点击按钮代理方法
 */
-(void)HPButtonLayoutTextViewDelegate:(UIButton *)sender btnIndex:(NSInteger )index;

@end

/**
 *根据数组textArr的元素个数循环创建按钮
 */
@interface HPButtonLayoutTextView : UIView

/**创建按钮名字的数组*/
@property(nonatomic,strong)NSArray * textArr;

/** 按钮间距 */
@property(nonatomic,assign)CGFloat buttonBetween;

/** 单个按钮文字左右距离 */
@property(nonatomic,assign)CGFloat buttonPadding;

/** 按钮背景颜色 */
@property(nonatomic,strong)UIColor * buttonBackgroundColor;

/** 按钮文字颜色 */
@property(nonatomic,strong)UIColor * buttonTextColor;

/** 按钮选中颜色 */
@property(nonatomic,strong)UIColor * buttonSelectColor;

/** 按钮高度 */
@property(nonatomic,assign)CGFloat buttonHeight;

/** 按钮字体大小 */
@property(nonatomic,assign)CGFloat buttonTextFont;

/**实现按钮点击的代理方法*/
@property(nonatomic,weak)id<HPButtonLayoutTextViewDelegate> delegate;

-(void)setSameWidthButtonTitles:(NSArray *)titles;

@end
