//
//  XMDropDownChooseView.h
//  Created by Felix on 14-3-17.
//  Copyright (c) 2014年 xxyyzz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HPDropDownChooseView;
#define W_PATH  [UIScreen mainScreen].bounds.size.width
#define H_PATH  [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSInteger,HPChooseMode) {
    HPChooseModeNo             = 0,//未选中状态
    HPChooseModeSlectedHidden = 1,//选中-隐藏列表状态
    HPChooseModeSlectedShow   = 2,//选中打开列表状态
};

/**
 选择筛选器后执行代理方法
 */
@protocol HPDropDownChooseDelegate <NSObject>

- (void)choosedview:(HPDropDownChooseView *)view AtIndex:(NSInteger)index;

@end
/**
 *自定义筛选按钮以及筛选页面
 */
@interface HPDropDownChooseView : UIView<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, assign) id<HPDropDownChooseDelegate> chooseDelegate;
/**点击按钮后出现选择页面标题数组*/
@property (nonatomic,strong) NSArray * menuTitleArr;
/**筛选按钮*/
@property (nonatomic,strong) UIButton * menu;
/**条件清单列表容器*/
@property (nonatomic, strong) UITableView *ListTableView;
/**未选中文字、箭头展示颜色*/
@property(nonatomic,strong)UIColor  * no_selectColor;
/**选中文字、箭头展示颜色*/
@property(nonatomic,strong)UIColor * selectColor;
/** 字体大小 */
@property(nonatomic,strong)UIFont * font;

@property(nonatomic,assign)HPChooseMode  chooseMode;

@end
