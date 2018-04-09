//
//  ASBirthSelectSheet.h
//  ASBirthSheet
//
//  Created by Ashen on 15/12/8.
//  Copyright © 2015年 Ashen. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *自定义生日选择视图
 */
@interface HPBirthDaySelectView : UIView
@property (nonatomic, copy) void(^GetSelectDate)(NSString *dateStr);
/**日期选择器*/
@property (nonatomic, strong) NSString * selectDate;
@end
