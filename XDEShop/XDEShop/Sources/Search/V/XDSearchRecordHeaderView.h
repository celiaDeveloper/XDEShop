//
//  XDSearchRecordHeaderView.h
//  B2B2C
//
//  Created by Celia on 2018/1/11.
//  Copyright © 2018年 HP. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XDSearchRecordHeaderViewDelegate <NSObject>

/** 删除按钮响应 */
- (void)XDSearchRecordHeaderViewDeleteAction;

@end

@interface XDSearchRecordHeaderView : UIView

@property (nonatomic, assign) BOOL haveDeleteBtn;
@property (nonatomic, copy) NSString *titleString;

@property (nonatomic, weak) id <XDSearchRecordHeaderViewDelegate>delegate;

@end
