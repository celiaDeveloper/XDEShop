//
//  UIView+XM_UIImageToBase64.m
//  项目初始化模板(TableBarStyle)
//
//  Created by 秦正华 on 2017/6/20.
//  Copyright © 2017年 qinzhenghua. All rights reserved.
//

#import "UIView+HPImageToBase64.h"

@implementation UIView (HPImageToBase64)

- (NSString *)encodeToBase64String:(UIImage *)image {
    
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

@end
