//
//  AddressPickerView.h
//  testUTF8
//
//  Created by rhcf_wujh on 16/7/14.
//  Copyright © 2016年 wjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HPPickerViewDelegate <NSObject>

/** 取消按钮点击事件*/
- (void)cancelBtnClick;

/**
 *  完成按钮点击事件
 */
- (void)sureBtnClickReturnContent:(NSString *)content;

@end
/**
 *自定义选择器
 */
@interface HPPickerView : UIView
/**需要选择数据的数组*/
@property(nonatomic,strong)NSArray * dataArr;
/** 实现点击按钮代理*/
@property (nonatomic ,weak) id<HPPickerViewDelegate> delegate;

@end
