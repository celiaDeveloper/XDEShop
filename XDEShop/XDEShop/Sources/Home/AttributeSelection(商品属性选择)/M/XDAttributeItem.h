//
//  XDAttributeItem.h
//  XDEShop
//
//  Created by Celia on 2018/4/23.
//  Copyright © 2018年 Hopex. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XDAttributeTitleItem,XDAttributeList;
@interface XDAttributeItem : NSObject

/* 名字 */
@property (strong , nonatomic) XDAttributeTitleItem *attr;
/* 数组 */
@property (strong , nonatomic) NSArray<XDAttributeList *> *list;

@end
