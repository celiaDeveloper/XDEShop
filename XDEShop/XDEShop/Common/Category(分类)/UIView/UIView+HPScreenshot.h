//
//  PK-ios
//
//  Created by peikua on 15/9/15.
//  Copyright (c) 2015年 peikua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HPScreenshot)

/** View截图 */
- (UIImage*) screenshot;

/** ScrollView截图 contentOffset */
- (UIImage*) screenshotForScrollViewWithContentOffset:(CGPoint)contentOffset;

/** View按Rect截图 */
- (UIImage*) screenshotInFrame:(CGRect)frame;

@end


