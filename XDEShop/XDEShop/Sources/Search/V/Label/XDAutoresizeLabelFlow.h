//
//  XDAutoresizeLabelFlow.h
//  XDAutoresizeLabelFlow
//
//  Created by Celia on 2018/4/11.
//  Copyright © 2018年 HP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XDAutoresizeLabelFlow;
typedef void(^selectedHandler)(NSIndexPath *indexPath,NSString *title);
typedef void (^deleteActionHandler)(NSIndexPath *indexPath);

@interface XDAutoresizeLabelFlow : UIView

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
                sectionTitles:(NSArray *)secTitles
              selectedHandler:(selectedHandler)handler;

- (void)insertLabelWithTitle:(NSString *)title
                     atIndex:(NSUInteger)index
                    animated:(BOOL)animated;

- (void)insertLabelsWithTitles:(NSArray *)titles
                     atIndexes:(NSIndexSet *)indexes
                      animated:(BOOL)animated;

- (void)deleteLabelAtIndex:(NSUInteger)index
                  animated:(BOOL)animated;

- (void)deleteLabelsAtIndexes:(NSIndexSet *)indexes
                     animated:(BOOL)animated;

- (void)reloadAllWithTitles:(NSArray *)titles;

@property (nonatomic, assign) BOOL selectMark;  // 选中标记
@property (nonatomic, copy) deleteActionHandler deleteHandler;//删除block

@end




