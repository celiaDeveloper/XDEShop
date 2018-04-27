//
//  XDDetailViewController.m
//  XDEShop
//
//  Created by Celia on 2018/4/20.
//  Copyright © 2018年 Hopex. All rights reserved.
//

#import "XDDetailViewController.h"
#import "XDAttributeSelectionViewController.h"

@interface XDDetailViewController ()

/* 上一次选择的属性 */
@property (nonatomic, strong) NSArray *recordAttrArray;
/* 上一次选择的数量 */
@property (nonatomic, assign) NSString *recordNum;

@property (nonatomic, strong) UILabel *attrLabel;
@end

@implementation XDDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *attributeB = [UIButton initButtonTitleFont:18 titleColor:[UIColor whiteColor] titleName:@"加入购物车" backgroundColor:kCOLOR_M radius:5.0];
    attributeB.frame = CGRectMake(HPScreenWidth / 2 - 50, 130, 100, 44);
    [self.view addSubview:attributeB];
    [attributeB addTarget:self action:@selector(attributeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _attrLabel = [UILabel initLabelTextFont:18 textColor:[UIColor darkGrayColor] title:@"已选属性："];
    _attrLabel.frame = CGRectMake(HPScreenWidth / 2 - 140 , 100, 280, 20);
    _attrLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _attrLabel.layer.borderWidth = 0.5;
    _attrLabel.layer.cornerRadius = 5.0;
    _attrLabel.tag = 1100;
    [self.view addSubview:_attrLabel];
}

- (void)attributeButtonAction:(UIButton *)btn {
    XDAttributeSelectionViewController *vc = [[XDAttributeSelectionViewController alloc] init];
    // 存在记录数据，传给属性视图来显示
    if (self.recordAttrArray && self.recordAttrArray.count) {
        vc.lastSeleArray = [self.recordAttrArray mutableCopy];
    }
    if (self.recordNum && self.recordNum.length) {
        vc.lastNum = self.recordNum;
    }
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:vc animated:YES completion:nil];
    // 记录数据归零
    self.recordAttrArray = @[];
    self.recordNum = @"";
    self.attrLabel.text = @"已选属性：";
    
    // 属性视图传递过来的属性记录
    HPWeakSelf(self)
    vc.FeatureSelectionSubmitBlock = ^(NSDictionary *dic) {
        DEBUGLog(@"%@",dic);
        weakself.recordNum = dic[@"Num"];
        weakself.recordAttrArray = dic[@"Array"];
        weakself.attrLabel.text = [NSString stringWithFormat:@"已选属性：%@ ×%@",[weakself.recordAttrArray componentsJoinedByString:@","],weakself.recordNum];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
