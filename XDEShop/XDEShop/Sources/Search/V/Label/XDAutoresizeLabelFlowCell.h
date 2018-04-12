//
//  XDAutoresizeLabelFlowCell.h
//  XDAutoresizeLabelFlow
//
//  Created by Celia on 2018/4/11.
//  Copyright © 2018年 HP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDAutoresizeLabelFlowCell : UICollectionViewCell
/** 是否选中 */
@property (nonatomic, assign) BOOL beSelected;

- (void)configCellWithTitle:(NSString *)title;

@end



