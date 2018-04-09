//
//  XMCountdownButton.h
//  SLYP
//
//  Created by 秦正华 on 2017/2/8.
//

#import <UIKit/UIKit.h>
@class HPCountdownButton;
#define BacColor [UIColor lightGrayColor]
#define SelColor [UIColor lightGrayColor]
#define TitleColor [UIColor whiteColor]

typedef void(^CountingBlock)(HPCountdownButton *codeTimeButton);
typedef void(^CdCompleteBlock)(void);
static CGFloat const countFontSize = 14;

typedef NS_ENUM(NSInteger,HPTimeModel) {
    HPTimeModelTimeDown  = 0,//倒计时
    HPTimeModelTimeUp    = 1,//计时器
};
/**
 *自定义倒计时按钮
 */
@interface HPCountdownButton : UIButton
/**开始时间*/
@property (nonatomic,assign) NSTimeInterval starTime;
/**结束时间*/
@property (nonatomic,assign) NSTimeInterval endTime;

@property(nonatomic,assign)BOOL startRun;



#pragma mark - 验证码倒计时
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title startTime:(NSInteger)startTime tapEvent:(CountingBlock)tapBlock callBack:(CdCompleteBlock)completeBlock;

#pragma mark - 天数倒计时
- (instancetype)initWithFrame:(CGRect)frame;


#pragma mark - 必须在viewDidDisappear里停掉计时器
- (void)stopTimer;

//直接从某个时间开始倒计时
- (void)startWithTime:(NSInteger)timeCount;

+ (NSTimeInterval)timeIntervalToSecond:(NSInteger)second;

@end
