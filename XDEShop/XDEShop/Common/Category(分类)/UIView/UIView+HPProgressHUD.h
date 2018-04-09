//
//  UIView+HPProgressHUD.h
//  ZHDJ
//
//  Created by 秦正华 on 2017/9/21.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPProgressHUD.h"

@interface UIView (HPProgressHUD)

-(void)showMessage:(NSString *)text;

-(void)showSuccess:(NSString *)text;

-(void)showFailure:(NSString *)text;

-(void)showLoading:(NSString *)text;

-(void)showProgress:(NSString *)text;

-(void)hideAfter:(CGFloat)time;

-(void)hide;



@end
