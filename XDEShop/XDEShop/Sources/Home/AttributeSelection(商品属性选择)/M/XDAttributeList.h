//
//  XDAttributeList.h
//  XDEShop
//
//  Created by Celia on 2018/4/23.
//  Copyright © 2018年 Hopex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDAttributeList : NSObject

/** 类型名 */
@property (nonatomic, copy) NSString *infoname;
/** 额外价格 */
@property (nonatomic, copy) NSString *plusprice;

/** 是否点击 */
@property (nonatomic,assign) BOOL isSelect;

@end
