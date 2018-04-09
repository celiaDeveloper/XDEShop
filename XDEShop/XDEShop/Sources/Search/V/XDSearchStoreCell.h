//
//  ZHSearchStoreCell.h
//  B2B2C
//
//  Created by Celia on 2018/3/22.
//  Copyright © 2018年 HP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XDSearchStoreCell;
@protocol XDSearchStoreCellDelegate <NSObject>

- (void)tapGoodsIndex:(NSInteger)index currentCell:(XDSearchStoreCell *)currentCell;

- (void)collectStoreCurrentCell:(XDSearchStoreCell *)currentCell;

- (void)enterStoreCurrentCell:(XDSearchStoreCell *)currentCell;

@end

@interface XDSearchStoreCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) id <XDSearchStoreCellDelegate>cellDelegate;

@end
