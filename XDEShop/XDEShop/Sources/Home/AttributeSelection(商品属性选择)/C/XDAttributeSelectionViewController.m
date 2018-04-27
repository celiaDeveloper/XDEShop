//
//  XDAttributeSelectionViewController.m
//  XDEShop
//
//  Created by Celia on 2018/4/23.
//  Copyright © 2018年 Hopex. All rights reserved.
//

#import "XDAttributeSelectionViewController.h"
#import "XDAttributeSelectionView.h"
#import "XDAttributeItem.h"
#import <MJExtension/MJExtension.h>

@interface XDAttributeSelectionViewController ()

@property (nonatomic, strong) XDAttributeSelectionView *mainView;

@end


@implementation XDAttributeSelectionViewController

#pragma mark - LazyLoad
- (XDAttributeSelectionView *)mainView {
    if (!_mainView) {
        _mainView = [[XDAttributeSelectionView alloc] initWithFrame:self.view.bounds];
    }
    return _mainView;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mainView];
    self.mainView.goodImageView = @"http://img.mp.itc.cn/upload/20170712/6d755eaabdbf4308b986b12c73df7dd2_th.jpg";
    if (self.lastSeleArray) {
        self.mainView.lastSeleArray = self.lastSeleArray;
    }
    if (self.lastNum) {
        self.mainView.lastNum = self.lastNum;
    }
    
    self.mainView.featureAttr = [XDAttributeItem mj_objectArrayWithFilename:@"ShopItem.plist"]; //数据
    
    HPWeakSelf(self)
    self.mainView.AttributeSubmitBlock = ^(NSDictionary *dic) {
        // 区别是加入购物车还是立即购买，调用接口
        [HPProgressHUD showMessage:@"加入购物车成功"];
        [weakself dismissFeatureViewControllerWithDic:dic];
    };
    
    self.mainView.AttributeDismissBlock = ^(NSDictionary *dic) {
        [weakself dismissFeatureViewControllerWithDic:dic];
    };
}

#pragma mark - 退出当前界面
- (void)dismissFeatureViewControllerWithDic:(NSDictionary *)attributeDic {

    HPWeakSelf(self)
    [weakself dismissViewControllerAnimated:YES completion:^{
        // 确保选择了属性值，回调
        if (attributeDic && attributeDic.count) {
            if (weakself.FeatureSelectionSubmitBlock) {
                weakself.FeatureSelectionSubmitBlock(attributeDic);
            }
        }
    }];
}

@end
