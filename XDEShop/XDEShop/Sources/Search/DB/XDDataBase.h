//
//  XDDataBase.h
//  XDEShop
//
//  Created by Celia on 2018/4/8.
//  Copyright © 2018年 Hopex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
#import "HPSingleton.h"

@interface XDDataBase : NSObject

HPSingleton_interface(XDDataBase)

- (void)openSearchRecordDataBase;
- (void)addSearchRecordText:(NSString *)text;
- (void)deleteAllSearchRecord;
- (void)querySearchRecord:(void(^)(NSArray *resultArray))resutlBlock;

@end
