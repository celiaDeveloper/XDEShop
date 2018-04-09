//
//  SearchButtonView.h
//  SLYP
//
//  Created by 秦正华 on 2017/2/21.
//  Copyright © 2017年 马晓明. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HPSearchButtonViewDelegate <NSObject>
/**
 *实现点击代理
 */
-(void)HPSearchButtonViewDelegate;

@end
/**
 *自定义一个搜索按钮
 */
@interface HPSearchButtonView : UIButton
/**提示文字*/
@property (nonatomic,strong) NSString * Placeholdertext;
/**点击按钮代理方法*/
@property (nonatomic,weak) id<HPSearchButtonViewDelegate> delegate;


@end

