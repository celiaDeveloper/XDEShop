//
//  XDAttributeHeaderView.h
//  XDEShop
//
//  Created by Celia on 2018/4/23.
//  Copyright © 2018年 Hopex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XDAttributeTitleItem;
@interface XDAttributeHeaderView : UICollectionReusableView

/** 标题数据 */
@property (nonatomic, strong) XDAttributeTitleItem *headTitle;

@end
