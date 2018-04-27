//
//  XDAttributeChoseTopCell.h
//  XDEShop
//
//  Created by Celia on 2018/4/23.
//  Copyright © 2018年 Hopex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDAttributeChoseTopCell : UITableViewCell

/** 取消点击回调 */
@property (nonatomic, copy) dispatch_block_t crossButtonClickBlock;

/* 图片 */
@property (nonatomic, strong) UIImageView *goodImageView;

/* 商品价格 */
@property (nonatomic, strong) UILabel *goodPriceLabel;
/* 选择属性 */
@property (nonatomic, strong) UILabel *chooseAttLabel;
/* 库存量 */
@property (nonatomic, strong) UILabel *storageLabel;

@end
