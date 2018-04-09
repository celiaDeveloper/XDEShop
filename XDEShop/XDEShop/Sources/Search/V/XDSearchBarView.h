//
//  XDSearchBarView.h
//  B2B2C
//
//  Created by Celia on 2018/1/11.
//  Copyright © 2018年 HP. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SearchTypeGoods = 0,
    SearchTypeStore,
} SearchType;


@protocol XDSearchBarViewDelegate <NSObject>

- (void)XDSearchBarViewToSearch:(NSString *)keyword;

@end

@interface XDSearchBarView : UIView

@property (nonatomic, assign) SearchType searchType;

@property (nonatomic, strong) UITextField *searchTF;

@property (nonatomic, weak) id <XDSearchBarViewDelegate>delegate;

@end
