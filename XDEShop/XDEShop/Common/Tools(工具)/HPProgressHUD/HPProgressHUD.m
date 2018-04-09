//
//  QZHProgressHUD.m
//  SLYP
//
//  Created by 秦正华 on 2016/11/25.
//  Copyright © 2016年 马晓明. All rights reserved.
//

#import "HPProgressHUD.h"

// 文字大小
#define TEXT_SIZE    16.0f

@implementation HPProgressHUD

+(instancetype)shareHUD{
    static HPProgressHUD *HUD;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HUD =[[HPProgressHUD alloc]init];
    });
    return HUD;
}

+(void)initHUDWithshow:(NSString *)text inView:(UIView *)view{
    //如果已有弹框，先消失
    if ([HPProgressHUD shareHUD].hud != nil) {
        [[HPProgressHUD shareHUD].hud hideAnimated:YES];
        [HPProgressHUD shareHUD].hud = nil;
    }
    
    //4\4s屏幕避免键盘存在时遮挡
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [view endEditing:YES];
    }
    
    [HPProgressHUD shareHUD].hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    [QZHProgressHUD shareHUD].hud.dimBackground = YES;    //是否显示透明背景
    //是否设置黑色背景，这两句配合使用
    [HPProgressHUD shareHUD].hud.bezelView.color = [UIColor blackColor];
    [HPProgressHUD shareHUD].hud.contentColor = [UIColor whiteColor];
    [[HPProgressHUD shareHUD].hud setMargin:10];
    [[HPProgressHUD shareHUD].hud setRemoveFromSuperViewOnHide:YES];
    [HPProgressHUD shareHUD].hud.animationType = MBProgressHUDAnimationZoom;
    [HPProgressHUD shareHUD].hud.detailsLabel.text = text;
    [HPProgressHUD shareHUD].hud.detailsLabel.font = [UIFont systemFontOfSize:TEXT_SIZE];
}

+ (void)showMode:(HPProgressHUDMode)mode text:(NSString *)text inView:(UIView *)view{

    [self initHUDWithshow:text inView:view];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"HPProgressHUD" ofType:@"bundle"];
    
    switch (mode) {
            
        case HPProgressHUDModeSuccess: {
            
            NSString *sucPath = [bundlePath stringByAppendingPathComponent:@"hud_success@2x.png"];
            UIImage *sucImage = [UIImage imageWithContentsOfFile:sucPath];
            
            [HPProgressHUD shareHUD].hud.mode = MBProgressHUDModeCustomView;
            UIImageView *sucView = [[UIImageView alloc] initWithImage:sucImage];
            [HPProgressHUD shareHUD].hud.customView = sucView;
        }
            break;
            
        case HPProgressHUDModeError: {
            
            NSString *errPath = [bundlePath stringByAppendingPathComponent:@"hud_error@2x.png"];
            UIImage *errImage = [UIImage imageWithContentsOfFile:errPath];
            
            [HPProgressHUD shareHUD].hud.mode = MBProgressHUDModeCustomView;
            UIImageView *errView = [[UIImageView alloc] initWithImage:errImage];
            [HPProgressHUD shareHUD].hud.customView = errView;
        }
            break;
            
        case HPProgressHUDModeWaitting: {
            
            [HPProgressHUD shareHUD].hud.mode = MBProgressHUDModeIndeterminate;
        }
            break;
            
        case HPProgressHUDModeMessage: {
            
            [HPProgressHUD shareHUD].hud.mode = MBProgressHUDModeText;
        }
            break;
            
        case HPProgressHUDModeProgress:{
            [HPProgressHUD shareHUD].hud.mode = MBProgressHUDModeDeterminate;
        }
            
        default:
            break;
    }
}

#pragma mark - HUD隐藏方法
+(void)hide
{
    if ([HPProgressHUD shareHUD].hud != nil) {
        [[HPProgressHUD shareHUD].hud hideAnimated:YES];
    }
}

+(void)hideAfter:(CGFloat)time
{
    if ([HPProgressHUD shareHUD].hud != nil) {
        [[HPProgressHUD shareHUD].hud hideAnimated:YES afterDelay:time];
    }
}

#pragma mark - HUD show window上
+ (void)showMessage:(NSString *)text {
    
    [self showMode:HPProgressHUDModeMessage text:text inView:[UIApplication sharedApplication].keyWindow];
    [self hideAfter:2.0];
}

+ (void)showFailure:(NSString *)text {
    
    [self showMode:HPProgressHUDModeError text:text inView:[UIApplication sharedApplication].keyWindow];
    [self hideAfter:2.0];
}

+ (void)showSuccess:(NSString *)text {
    
    [self showMode:HPProgressHUDModeSuccess text:text inView:[UIApplication sharedApplication].keyWindow];
    [self hideAfter:2.0];
}

+ (void)showLoading:(NSString *)text {
    
    [self showMode:HPProgressHUDModeWaitting text:text inView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark - HUD show 指定view上
+ (void)showMessage:(NSString *)text inView:(UIView *)view{
    
    [self showMode:HPProgressHUDModeMessage text:text inView:view];
    [self hideAfter:2.0];
}

+ (void)showFailure:(NSString *)text inView:(UIView *)view{
    
    [self showMode:HPProgressHUDModeError text:text inView:view];
    [self hideAfter:2.0];
}

+ (void)showSuccess:(NSString *)text inView:(UIView *)view{
    
    [self showMode:HPProgressHUDModeSuccess text:text inView:view];
    [self hideAfter:2.0];
}

+ (void)showLoading:(NSString *)text inView:(UIView *)view{
    
    [self showMode:HPProgressHUDModeWaitting text:text inView:view];
}

+ (void)showProgress:(NSString *)text inView:(UIView *)view{
    
    [self showMode:HPProgressHUDModeProgress text:text inView:view];
}

/** 监听progress */
-(void)setProgress:(float)progress
{
    _progress = progress;
    
    self.hud.progress = _progress;
}

@end
