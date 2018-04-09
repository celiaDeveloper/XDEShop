//
//  NoNetShowView.m
//  HP_iOS_CommonFrame
//
//  Created by 秦正华 on 2017/8/11.
//  Copyright © 2017年 zhijianshangcheng. All rights reserved.
//

#import "HPReconnectView.h"

@implementation HPReconnectView
{
    UIButton *reconnectButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createInterface];
    }
    return self;
}

-(void)createInterface
{
    self.backgroundColor = [UIColor whiteColor];
    reconnectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:reconnectButton];
    
    reconnectButton.frame = CGRectMake(40, self.bounds.size.height/2-20, self.bounds.size.width-80, 40);
    reconnectButton.backgroundColor = [UIColor lightGrayColor];
    [reconnectButton setTitle:@"重新连接" forState:0];
    
    [reconnectButton addTarget:self action:@selector(reconnectButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)reconnectButtonClick
{
    
    if (self.reconnectBlock) {
        self.reconnectBlock();
    }
    
    DEBUGLog(@"点击了重新连接");
}

@end
