//
//  UIImageView+extension.m
//  SLYP
//
//  Created by 秦正华 on 2016/11/18.
//  Copyright © 2016年 马晓明. All rights reserved.
//

#import "UIImageView+HPExtension.h"

@implementation UIImageView (HPExtension)

+ (instancetype)initImageView:(NSString *)imagename {
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imagename]];
    image.contentMode = UIViewContentModeScaleAspectFill;
    image.layer.masksToBounds = YES;
    return image;
}

- (void)setImageView:(NSString *)imagename {
    
    self.image = [UIImage imageNamed:imagename];
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.layer.masksToBounds = YES;
}

//- (void)touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event
//{
//    self.highlighted = YES;
//    DEBUGLog(@"touchesBegan");
//    
//}
//- (void)touchesMoved:(NSSet *) touches withEvent:(UIEvent *) event
//{
//    DEBUGLog(@"touchesMoved");
//}
//
//- (void)touchesEnded:(NSSet *) touches withEvent:(UIEvent *) event
//{
//    DEBUGLog(@"touchesEnded");
//}
//
//- (void)touchesCancelled:(NSSet *) touches withEvent:(UIEvent *) event
//{
//    self.highlighted = NO;
//    DEBUGLog(@"touchesCancelled");
//}


@end
