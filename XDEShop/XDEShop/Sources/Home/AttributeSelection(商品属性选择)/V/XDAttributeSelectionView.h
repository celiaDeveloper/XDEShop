//
//  XDAttributeSelectionView.h
//  XDEShop
//
//  Created by Celia on 2018/4/23.
//  Copyright © 2018年 Hopex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDAttributeItem.h"

@interface XDAttributeSelectionView : UIView

/* 底部空隙 */
@property (nonatomic, assign) CGFloat bottomSpace;

/* 商品图片 */
@property (nonatomic, strong) NSString *goodImageView;
/* 上一次选择的属性 */
@property (nonatomic, strong) NSMutableArray *lastSeleArray;
/* 上一次选择的数量 */
@property (nonatomic, assign) NSString *lastNum;

/* 数据 */
@property (nonatomic, strong) NSMutableArray <XDAttributeItem *> *featureAttr;

/** 选择的属性和数量 提交 */
@property (nonatomic, copy) void(^AttributeSubmitBlock)(NSDictionary *dic);

/** 点空白或“×”，视图消失 */
@property (nonatomic, copy) void(^AttributeDismissBlock)(NSDictionary *dic);

@end
