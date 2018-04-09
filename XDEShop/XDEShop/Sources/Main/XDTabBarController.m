//
//  XDTabBarController.m
//  XDEShop
//
//  Created by Celia on 2018/4/3.
//  Copyright © 2018年 Hopex. All rights reserved.
//

#import "XDTabBarController.h"
#import "XDNavigationController.h"
#import "XDHomeViewController.h"
#import "XDSearchViewController.h"
#import "XDPersonalViewController.h"

@interface XDTabBarController ()

@end

@implementation XDTabBarController

/**
 初始化类：
 1.appearance：只要一个类遵守UIAppearance协议，就能获取全局的外观，如：UIView。
 2.获取项目中所有的tabBarItem外观标识（推荐，不会改变别人的）：
 UITabBarItem *item = [UITabBarItem appearance];
 3.获取当前类下面的所有tabBarItem外观标识：
 UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
 */
+ (void)initialize {
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createInterface];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)createInterface {
    // 设置顶部状态栏为白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置TabBarItem选中文字颜色
    UITabBarItem *bar = [UITabBarItem appearance];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor hex:@"1296db"], NSFontAttributeName: [UIFont hp_systemFontOfSize:14]} forState:UIControlStateSelected];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor hex:@"707070"], NSFontAttributeName:[UIFont hp_systemFontOfSize:14]} forState:UIControlStateNormal];
    
    
    XDHomeViewController *homeVC = [[XDHomeViewController alloc] init];
    XDSearchViewController *searchVC = [[XDSearchViewController alloc] init];
    XDPersonalViewController *personalVC = [[XDPersonalViewController alloc] init];
    
    
    [self setVC:homeVC tabBarItemTitle:@"首页" image:@"foota" selectedImage:@"foota_pressed"];
    [self setVC:searchVC tabBarItemTitle:@"搜索" image:@"footb" selectedImage:@"footb_pressed"];
    [self setVC:personalVC tabBarItemTitle:@"我的" image:@"footc" selectedImage:@"footc_pressed"];
}

- (void)setVC:(UIViewController *)vc tabBarItemTitle:(NSString *)title image:(NSString *)img selectedImage:(NSString *)selectedImg {
    vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage originalImageNamed:img] selectedImage:[UIImage originalImageNamed:selectedImg]];
    XDNavigationController *nav = [[XDNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


@end
