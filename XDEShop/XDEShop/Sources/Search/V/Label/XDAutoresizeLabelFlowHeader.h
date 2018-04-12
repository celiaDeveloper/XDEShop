//
//  XDAutoresizeLabelFlowHeader.h
//  XDAutoresizeLabelFlow
//
//  Created by Celia on 2018/4/11.
//  Copyright © 2018年 HP. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol XDAutoresizeLabelFlowHeaderDelegate <NSObject>
//
///** 删除按钮响应 */
//- (void)XDAutoresizeLabelFlowHeaderDeleteAction;
//
//@end

@interface XDAutoresizeLabelFlowHeader : UICollectionReusableView

@property (nonatomic, assign) BOOL haveDeleteBtn;
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, strong) NSIndexPath *indexPath;

//@property (nonatomic, weak) id <XDAutoresizeLabelFlowHeaderDelegate>delegate;
@property (nonatomic, copy) void (^deleteActionBlock)(NSIndexPath *indexPath);

@end
