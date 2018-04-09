//
//  XMTextView.h
//  SLYP
//
//  Created by 秦正华 on 2017/3/20.
//  Copyright © 2017年 马晓明. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *自定义textView
 */
@interface HPTextView : UIView<UITextViewDelegate>

/** 输入框 */
@property(nonatomic,strong)UITextView * textView;

/**提示文字*/
@property(nonatomic,strong)NSString * Placeholdertext;

/**文字大小*/
@property(nonatomic,assign)CGFloat fontSize;

/**输入的内容*/
@property(nonatomic,strong)NSString * contentText;

@property(nonatomic,strong)UIColor * contentBackgroundColor;

/** 设定输入长度 */
@property(nonatomic,assign)NSInteger maxTextLength;

/** 限制提示 true 限制,false 不限制 */
@property(nonatomic,assign)BOOL textTips;

@end
