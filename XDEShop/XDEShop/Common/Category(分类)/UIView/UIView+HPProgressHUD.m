//
//  UIView+HPProgressHUD.m
//  ZHDJ
//
//  Created by 秦正华 on 2017/9/21.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import "UIView+HPProgressHUD.h"

@implementation UIView (HPProgressHUD)

-(void)showProgress:(NSString *)text
{
    [HPProgressHUD showProgress:text inView:self];
}

-(void)showFailure:(NSString *)text
{
    [HPProgressHUD showFailure:text inView:self];
}

-(void)showLoading:(NSString *)text
{
    [HPProgressHUD showLoading:text inView:self];
}

-(void)showMessage:(NSString *)text
{
    [HPProgressHUD showMessage:text inView:self];
}

-(void)showSuccess:(NSString *)text
{
    [HPProgressHUD showSuccess:text inView:self];
}

-(void)hide
{
    [HPProgressHUD hide];
}

-(void)hideAfter:(CGFloat)time
{
    [HPProgressHUD hideAfter:time];
}

@end
