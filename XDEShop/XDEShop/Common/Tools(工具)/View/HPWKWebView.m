//
//  XM_WKWebView.m
//  ZJSC
//
//  Created by 秦正华 on 2017/6/30.
//  Copyright © 2017年 zhijianshangcheng. All rights reserved.
//

#import "HPWKWebView.h"
#define HPNOTIF_POST(n, o)    [[NSNotificationCenter defaultCenter] postNotificationName:n object:o]
@implementation HPWKWebView

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    UIScrollView *scrollView = object;
    _webViewHeight = scrollView.contentSize.height;
    
    HPNOTIF_POST(@"web_height", nil);
    
}

#pragma mark -- super

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
//        self.multipleTouchEnabled = NO;
//        self.autoresizesSubviews = YES;
        self.scrollView.showsVerticalScrollIndicator = false;
        self.scrollView.showsHorizontalScrollIndicator = false;
        self.scrollView.bounces = false;
        self.opaque = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
}



@end
