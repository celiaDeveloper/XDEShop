//
//  XHStarRateView.h
//  XHStarRateView
//
//  Created by 江欣华 on 16/4/1.
//  Copyright © 2016年 jxh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HPStarRateView;

typedef void(^finishBlock)(CGFloat currentScore);

typedef NS_ENUM(NSInteger, RateStyle)
{
    WholeStar = 0, //只能整星评论
    HalfStar = 1,  //允许半星评论
    IncompleteStar = 2  //允许不完整星评论
};

@protocol HPStarRateViewDelegate <NSObject>

-(void)starRateView:(HPStarRateView *)starRateView currentScore:(CGFloat)currentScore;

@end
/**
 *自定义点星评价视图
 */
@interface HPStarRateView : UIView
/**是否动画显示，默认NO*/
@property (nonatomic,assign) BOOL isAnimation;
/**评分样式    默认是WholeStar*/
@property (nonatomic,assign) RateStyle rateStyle;
/**实现点击评分星星页面的代理方法*/
@property (nonatomic, weak) id<HPStarRateViewDelegate>delegate;
/**当前评分：0-5  默认0*/
@property (nonatomic,assign) CGFloat currentScore;

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation delegate:(id)delegate;


- (instancetype)initWithFrame:(CGRect)frame finish:(finishBlock)finish;
- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation finish:(finishBlock)finish;

@end
