//
//  HPBaseWKWebViewController.h
//  ZHDJ
//
//  Created by 秦正华 on 2017/10/31.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPBaseWKWebViewController : UIViewController

//网页链接
@property(nonatomic,copy)NSString *urlStr;
//html内容
@property(nonatomic,copy)NSString *htmlStr;

@end
