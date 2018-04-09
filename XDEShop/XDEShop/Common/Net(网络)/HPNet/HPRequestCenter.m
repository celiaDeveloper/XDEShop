//
//  HPApiRequest.m
//  HP_iOS_CommonFrame
//
//  Created by 秦正华 on 2017/8/10.
//  Copyright © 2017年 zhijianshangcheng. All rights reserved.
//

#import "HPRequestCenter.h"

@interface HPRequestCenter()

@end

@implementation HPRequestCenter

-(void)setStatus:(HPRequestResultStatus)status
{
    NSInteger subviewCount = self.contentView.subviews.count;
    
    switch (status) {
            
        case HPRequestResultNoNet:
        {
            //因为每次重新连接，HPRequestCenter这个都会重新创建，self.reconnectView也会跟着变化，如果用self.reconnectView这个去判断是否已经是self.contentView的子视图，结果一直是否，会导致self.contentView这个视图一直叠加重新连接的视图。
            if (subviewCount && [self.contentView.subviews[subviewCount - 1] isKindOfClass:[HPReconnectView class]]) {
                return;
            }
            [self.contentView addSubview:self.reconnectView];

        }
            break;
            
        case HPRequestResultReturnError:
            
            if (subviewCount && [self.contentView.subviews[subviewCount - 1] isKindOfClass:[HPReconnectView class]]) {
                [self.contentView.subviews[subviewCount - 1] removeFromSuperview];
            }
            [HPProgressHUD showMessage:_errorInfo inView:self.contentView];

            break;
            
        case HPRequestResultSuccess:
            
            if (subviewCount && [self.contentView.subviews[subviewCount - 1] isKindOfClass:[HPReconnectView class]]) {
                [self.contentView.subviews[subviewCount - 1] removeFromSuperview];
            }
            
            break;
            
        default:
            break;
    }
}

-(HPReconnectView *)reconnectView
{
    if (!_reconnectView) {
        
        _reconnectView = [[HPReconnectView alloc] initWithFrame:self.contentView.frame];
        
    }
    return _reconnectView;
}


@end
