//
//  XDAttributeSelectionViewController.h
//  XDEShop
//
//  Created by Celia on 2018/4/23.
//  Copyright © 2018年 Hopex. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface XDAttributeSelectionViewController : UIViewController

/* 上一次选择的属性 */
@property (nonatomic, strong) NSMutableArray *lastSeleArray;
/* 上一次选择的数量 */
@property (nonatomic, assign) NSString *lastNum;

/** 选择的属性和数量 提交 */
@property (nonatomic, copy) void(^FeatureSelectionSubmitBlock)(NSDictionary *dic);

@end
