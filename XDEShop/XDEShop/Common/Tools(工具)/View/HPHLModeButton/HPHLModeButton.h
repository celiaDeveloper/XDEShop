//
//  XM_HLModeButton.h
//  ZJSC
//
//  Created by 秦正华 on 2017/6/28.
//  Copyright © 2017年 zhijianshangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HPHLModeButton;

typedef NS_ENUM(NSInteger, HPSortMode) {
    HPSortModeNone  = 0,//未选中状态
    HPSortModeHigh  = 1,//选中降序状态
    HPSortModeLow   = 2,//选中升序号状态
};

@protocol HPHLModeButtonDelegate <NSObject>

- (void)HPHLModeButton:(HPHLModeButton *)menu SortMode:(HPSortMode)sortModel;

@end
/**
 *自定义升序降序功能按钮
 */
@interface HPHLModeButton : UIButton
/**实现升序降序代理方法*/
@property (nonatomic,weak) id<HPHLModeButtonDelegate> delegate;
/**按钮的名称*/
@property (nonatomic,strong) NSString * menuName;
/**按钮的状态*/
@property (nonatomic,assign) HPSortMode sortMode;

@end
