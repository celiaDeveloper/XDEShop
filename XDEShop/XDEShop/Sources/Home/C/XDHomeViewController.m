//
//  XDHomeViewController.m
//  XDEShop
//
//  Created by Celia on 2018/4/4.
//  Copyright © 2018年 Hopex. All rights reserved.
//

#import "XDHomeViewController.h"
#import "XDDetailViewController.h"

@interface XDHomeViewController ()

@end

@implementation XDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *detailB = [UIButton initButtonTitleFont:18 titleColor:[UIColor whiteColor] titleName:@"商品详情" backgroundColor:kCOLOR_M radius:5.0];
    detailB.frame = CGRectMake(HPScreenWidth / 2 - 50, 100, 100, 44);
    [self.view addSubview:detailB];
    [detailB addTarget:self action:@selector(detailButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)detailButtonAction:(UIButton *)btn {
    XDDetailViewController *vc = [[XDDetailViewController alloc] init];
    [self pushViewController:vc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
