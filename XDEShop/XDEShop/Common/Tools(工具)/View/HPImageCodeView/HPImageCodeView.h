//
//  ImageCodeView.h
//  VerCodeView
//
//  Created by hpjr on 2016/12/22.
//  Copyright © 2016年 sands. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *自定义图片验证码页面
 */
@interface HPImageCodeView : UIView
/**验证码字符串数组*/
@property (nonatomic,copy) NSArray* CodeArr;
/**随机生成的*/
@property (nonatomic,copy) NSString* CodeStr;

@end
