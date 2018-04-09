//
//  Macro.h
//  ZHDJ
//
//  Created by Celia on 2017/8/28.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

// 调试DEBUG
#ifdef DEBUG
//#define DEBUGLog(fmt, ...) printf("<%p> [line %d] %s >>> %s\n", self, __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(fmt), ##__VA_ARGS__] UTF8String]);
# define DEBUGLog(fmt, ...) NSLog(@"%s [Line %d] %s", __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:(fmt), ##__VA_ARGS__] UTF8String]);
#else
#define DEBUGLog(...)
#endif


#define HPWeakSelf(type)    __weak typeof(type) weak##type = type; // weak
#define HPStrongSelf(type)  __strong typeof(type) type = weak##type; // strong

#define HPFORMAT(f, ...)        [NSString stringWithFormat:f, ## __VA_ARGS__]
#define StringValueFromInt(x)   [NSString stringWithFormat:@"%ld",x]

// app主窗口
#define HPKeyWindow     [UIApplication sharedApplication].keyWindow

// 偏好设置
#define HPUserdefault   [NSUserDefaults standardUserDefaults]

// 获取图片资源
#define GetImage(imageName)     [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

#define URL(URLName)            [NSURL URLWithString:[NSString stringWithFormat:@"%@",URLName]]

#define BASEURLAppend(URLName)  [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,URLName]]

// 第一个参数是当下的控制器适配iOS11 以下的，第二个参数表示scrollview或子类
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}


//----------页面设计相关-------
#define HPScreenBounds      [UIScreen mainScreen].bounds
#define HPScreenWidth       [UIScreen mainScreen].bounds.size.width
#define HPScreenHeight      [UIScreen mainScreen].bounds.size.height

/*! 屏幕适配（8P标准屏幕：414 * 736） */
#define HPscale_W           [UIScreen mainScreen].bounds.size.width/414.0



//---------- 常用高度 -------
// 导航条高度
#define HPNavBarH ([UIScreen mainScreen].bounds.size.height == 812.0 ? 88 : 64)
// 标签栏高度
#define HPTabBarH ([UIScreen mainScreen].bounds.size.height == 812.0 ? 83 : 49)
//底部安全距离
#define HPSafeAreaBottomHeight ([UIScreen mainScreen].bounds.size.height == 812.0 ? 34 : 0)



//---------- 通知 -------
#define HPNOTIF             [NSNotificationCenter defaultCenter]
#define HPNOTIF_ADD(n, f)   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(f) name:n object:nil]
#define HPNOTIF_POST(n, o)  [[NSNotificationCenter defaultCenter] postNotificationName:n object:o]
#define HPNOTIF_REMV()      [[NSNotificationCenter defaultCenter] removeObserver:self]



//---------- 颜色 -------
#define HPRGB(r, g, b)      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define HPRGBA(r, g, b, a)  [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

//rgb颜色转换（16进制->10进制）
#define HPHexColor(hex)     [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]



//---------- GCD -------
// GCD - 一次性执行
#define HP_DISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);

// GCD - 在Main线程上运行
#define HP_DISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);

// GCD - 开启异步线程
#define HP_DISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);



//----------系统目录-------
// 获取temp
#define HPPathTemp      NSTemporaryDirectory()

// 获取沙盒 Document
#define HPPathDocument  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

// 获取沙盒 Cache
#define HPPathCache     [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#define HPPathHomeDir   NSHomeDirectory()



//---------- 字体 -------
#define HPFontL(s)             [UIFont systemFontOfSize:s weight:UIFontWeightLight]
#define HPFontR(s)             [UIFont systemFontOfSize:s weight:UIFontWeightRegular]
#define HPFontB(s)             [UIFont systemFontOfSize:s weight:UIFontWeightBold]
#define HPFontT(s)             [UIFont systemFontOfSize:s weight:UIFontWeightThin]
#define HPFont(s)              [UIFont systemFontOfSize:s]



//---------- 设备系统相关 -------
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )480) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )960) < DBL_EPSILON)
#define IS_IPHONE_X (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )812) < DBL_EPSILON)

#define HPSystemVersion   [[UIDevice currentDevice] systemVersion]
#define HPCurrentLanguage [[NSLocale preferredLanguages] objectAtIndex:0]
#define HPAPPVersion      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]






//以tag读取View
#define mViewByTag(parentView, tag, Class)  (Class *)[parentView viewWithTag:tag]
//读取Xib文件的类
#define mViewByNib(Class, owner) [[[NSBundle mainBundle] loadNibNamed:Class owner:owner options:nil] lastObject]

//id对象与NSData之间转换
#define mObjectToData(object)   [NSKeyedArchiver archivedDataWithRootObject:object]
#define mDataToObject(data)     [NSKeyedUnarchiver unarchiveObjectWithData:data]

//度弧度转换
#define mDegreesToRadian(x)      (M_PI * (x) / 180.0)
#define mRadianToDegrees(radian) (radian * 180.0) / (M_PI)



#endif /* Macro_h */
