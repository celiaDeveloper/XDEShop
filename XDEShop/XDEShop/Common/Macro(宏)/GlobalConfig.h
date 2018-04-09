//
//  GlobalConfig.h
//  ZHDJ
//
//  Created by 秦正华 on 2017/8/29.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#ifndef GlobalConfig_h
#define GlobalConfig_h


/** 主色 */
#define kCOLOR_M                   [UIColor hex:@"1296db"]
#define kCOLOR_Red_ScrollTitle     [UIColor hex:@"c9171e"]
#define kCOLOR_Gray_ScrollTitle    [UIColor hex:@"424242"]

#define kCOLOR_Gray_TableBG        [UIColor hex:@"f2f2f2"]

#define kCOLOR_LINE        [UIColor hex:@"f0f0f0"]

#define kCOLOR_imageBG        [UIColor hex:@"f2f2f2"]


/** 圆形占位图 */
#define kPLACEHOLDER_IMAGE_ROUND @"wode"
#define kIMAGE_PLACEHOLDER       @""


/** 图文图片比例 */
#define kIMAGE_S1 1.33      //列表图宽高比
#define kIMAGE_S2 1.78      //列表图宽高比


/** 界面测试文字 */
#define kTEST_TITLE @"中国人大常务委员会"
#define kTEST_TIME @"2017-06-08"

/** 测试用的user_id */
#define kTEST_USERID @"10275"


/** 文件路径 */
#define SpecialFilePath  [HPPathDocument stringByAppendingString:@"/studyDownload/topic/"]


/** 发送通知 字段 */
#define HomeCanLoadData      @"HomeCanLoadData"


#define LeftNavigationItem  UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];\
    [backButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];\
    [backButton addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];\
    [backButton sizeToFit];\
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);\
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];


#define kFONT_SCALE    ({ CGFloat fontS = 1.0;\
                        if (IS_IPHONE_4 || IS_IPHONE_5) {\
                            fontS = 0.92;\
                        }else if (IS_IPHONE_6) {\
                            fontS = 1.0;\
                        }else if (IS_IPHONE_6_PLUS) {\
                            fontS = 1.0;\
                        }\
                        (fontS);\
                        })


#endif /* GlobalConfig_h */
