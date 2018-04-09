//
//  AddandCutView.h
//  SLYP
//
//  Created by 秦正华 on 2017/3/17.
//  Copyright © 2017年 马晓明. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HPAddandCutViewDelegate <NSObject>
@optional
/**
 *1.点击增加/减少按钮改变数量
 *2.点击增加/减少按钮改变数量，获取输入框中的数量
 *3.修改输入框中的数量,并获取
 */
- (void)HPAddandCutView_getNumber:(NSString *)num;

- (void)HPAddandCutViewDelegateForCountButton:(UIButton *)countBtn withNumMark:(UITextField *)nummark;


- (void)HPAddandCutViewDelegateForNumberTextFiled:(UITextField *)numberFiled;

@end

/**
 *自定义购物车中增加减少数量控件
 */
@interface HPAddandCutView : UIView<UITextFieldDelegate>
/**点击按钮代理方法*/
@property (nonatomic,assign) id<HPAddandCutViewDelegate> delegate;
/**数量*/
@property (nonatomic,assign) NSInteger num;
/**最小数量*/
@property (nonatomic,assign) NSInteger min_num;
/**最大数量*/
@property (nonatomic,assign) NSInteger max_num;

@end
