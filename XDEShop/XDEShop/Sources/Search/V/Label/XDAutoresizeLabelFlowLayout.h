//
//  XDAutoresizeLabelFlowLayout.h
//  XDAutoresizeLabelFlow
//
//  Created by Celia on 2018/4/11.
//  Copyright © 2018年 HP. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XDAutoresizeLabelFlowLayoutDataSource <NSObject>

- (NSString *)titleForLabelAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface XDAutoresizeLabelFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,weak) id <XDAutoresizeLabelFlowLayoutDataSource> dataSource;

@end
