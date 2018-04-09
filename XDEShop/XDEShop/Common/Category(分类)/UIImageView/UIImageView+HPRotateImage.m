//
//  UIImageView+HPRotateImage.m
//  HP_iOS_CommonFrame
//
//  Created by Celia on 2017/8/22.
//  Copyright © 2017年 zhijianshangcheng. All rights reserved.
//

#import "UIImageView+HPRotateImage.h"

@implementation UIImageView (HPRotateImage)

- (void)rotate360DegreeWithImageView {
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1;
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopRotate {
    
    [self.layer removeAllAnimations];
}


@end
