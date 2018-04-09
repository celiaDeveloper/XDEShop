//
//  XDSearchStoreCell.m
//  B2B2C
//
//  Created by Celia on 2018/3/22.
//  Copyright © 2018年 HP. All rights reserved.
//

#import "XDSearchStoreCell.h"

static NSString *const cellIDSearchStore = @"SearchStoreCell";
static NSInteger GoodsImageBaseTag = 1200;
static NSInteger ImagePriceBaseTag = 1300;

@interface XDSearchStoreCell ()

@property (nonatomic, strong) UIImageView *storeIV;
@property (nonatomic, strong) UILabel *storeNameL;
@property (nonatomic, strong) UILabel *goodsCountL;
@property (nonatomic, strong) UIButton *collectB;

@property (nonatomic, strong) UILabel *scoreGoodsL;     // 宝贝得分
@property (nonatomic, strong) UILabel *scoreSellerL;    // 卖家服务得分
@property (nonatomic, strong) UILabel *scoreLogisticsL; // 物流服务得分
@property (nonatomic, strong) UILabel *descGoodsL;      // 宝贝得分高低描述
@property (nonatomic, strong) UILabel *descSellerL;     //
@property (nonatomic, strong) UILabel *descLogisticsL;  //

@property (nonatomic, strong) UIButton *enterStoreB;

@end

@implementation XDSearchStoreCell {
    UIView *topContainer;
    UIView *topLine;
    
    UIView *gradeContainer;
    UILabel *titleGoods;
    UILabel *titleSeller;
    UILabel *titleLogistics;
    
    UIView *goodsContainer;
    
    UIView *bottomContainer;
    UIView *bottomLine;
    
    UIView *grayView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    XDSearchStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDSearchStore];
    if (!cell) {
        cell = [[XDSearchStoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDSearchStore];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createInterface];
    }
    return self;
}

#pragma mark - 内部逻辑实现
- (void)goodsImageAction:(UITapGestureRecognizer *)tap {
    UIImageView *imgView = (UIImageView *)tap.view;
    if ([self.cellDelegate respondsToSelector:@selector(tapGoodsIndex:currentCell:)]) {
        [self.cellDelegate tapGoodsIndex:(imgView.tag - GoodsImageBaseTag) currentCell:self];
    }
}

- (void)collectButtonAction:(UIButton *)btn {
    
    if ([self.cellDelegate respondsToSelector:@selector(collectStoreCurrentCell:)]) {
        [self.cellDelegate collectStoreCurrentCell:self];
    }
}

- (void)enterStoreButtonAction:(UIButton *)btn {
    
    if ([self.cellDelegate respondsToSelector:@selector(enterStoreCurrentCell:)]) {
        [self.cellDelegate enterStoreCurrentCell:self];
    }
}

#pragma mark - 代理协议
#pragma mark - 数据请求 / 数据处理
#pragma mark - 视图布局
- (void)createInterface {
    
    topContainer = [[UIView alloc] init];
    [self.contentView addSubview:topContainer];
    
    self.storeIV = [UIImageView initImageView:@""];
    self.storeIV.backgroundColor = [UIColor lightGrayColor];
    
    self.storeNameL = [UILabel initLabelTextFont:22 textColor:[UIColor blackColor] title:@"店铺名称"];
    self.storeNameL.font = [UIFont hp_boldSystemFontOfSize:22];
    
    self.goodsCountL = [UILabel initLabelTextFont:18 textColor:[UIColor lightGrayColor] title:@"共17件宝贝"];
    
    self.collectB = [UIButton initButtonTitleFont:18 titleColor:[UIColor orangeColor] titleName:@"收藏" backgroundColor:[UIColor whiteColor] radius:3.0];
    self.collectB.layer.borderColor = [UIColor orangeColor].CGColor;
    self.collectB.layer.borderWidth = 1.0;
    [self.collectB addTarget:self action:@selector(collectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    topLine = [UIView initViewBackColor:kCOLOR_Gray_TableBG];
    
    [topContainer addSubview:self.storeIV];
    [topContainer addSubview:self.storeNameL];
    [topContainer addSubview:self.goodsCountL];
    [topContainer addSubview:self.collectB];
    [topContainer addSubview:topLine];

    
    gradeContainer = [[UIView alloc] init];
    [self.contentView addSubview:gradeContainer];
    
    titleGoods = [self makeGradeContainerLabels:[UIColor lightGrayColor] title:@"宝贝描述:" corner:0];
    titleSeller = [self makeGradeContainerLabels:[UIColor lightGrayColor] title:@"卖家服务:" corner:0];
    titleLogistics = [self makeGradeContainerLabels:[UIColor lightGrayColor] title:@"物流服务:" corner:0];
    
    self.scoreGoodsL = [self makeGradeContainerLabels:[UIColor redColor] title:@"5.0" corner:0];
    self.scoreSellerL = [self makeGradeContainerLabels:[UIColor redColor] title:@"5.0" corner:0];
    self.scoreLogisticsL = [self makeGradeContainerLabels:[UIColor redColor] title:@"5.0" corner:0];
    
    self.descGoodsL = [self makeGradeContainerLabels:[UIColor whiteColor] title:@"高" corner:3.0];
    self.descSellerL = [self makeGradeContainerLabels:[UIColor whiteColor] title:@"高" corner:3.0];
    self.descLogisticsL = [self makeGradeContainerLabels:[UIColor whiteColor] title:@"高" corner:3.0];
    
    
    goodsContainer = [[UIView alloc] init];
    [self.contentView addSubview:goodsContainer];
    
    NSInteger showNum = 4;
    CGFloat space = 5;
    CGFloat imgWidth = (HPScreenWidth - space*(2+showNum+1)) / showNum;
    CGFloat labelHeight = 18;
    for (int i = 0; i < showNum; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(space+space*(i+1)+imgWidth*i, 0, imgWidth, imgWidth)];
        imgView.backgroundColor = kCOLOR_Gray_TableBG;
        imgView.tag = i+GoodsImageBaseTag;
        [imgView addTarget:self action:@selector(goodsImageAction:)];
        
        UILabel *priceL = [UILabel initLabelTextFont:17 textColor:[UIColor whiteColor] title:@"19.00"];
        priceL.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        priceL.frame = CGRectMake(imgWidth/2, imgWidth - labelHeight, imgWidth/2, labelHeight);
        priceL.textAlignment = NSTextAlignmentCenter;
        priceL.tag = i+ImagePriceBaseTag;
        
        [goodsContainer addSubview:imgView];
        [imgView addSubview:priceL];
    }
    
    
    bottomContainer = [[UIView alloc] init];
    [self.contentView addSubview:bottomContainer];
    
    bottomLine = [UIView initViewBackColor:kCOLOR_Gray_TableBG];
    
    self.enterStoreB = [UIButton initButtonTitleFont:20 titleColor:[UIColor darkGrayColor] titleName:@"进入店铺逛逛 >"];
    [self.enterStoreB addTarget:self action:@selector(enterStoreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomContainer addSubview:bottomLine];
    [bottomContainer addSubview:self.enterStoreB];
    
    
    grayView = [UIView initViewBackColor:kCOLOR_Gray_TableBG];
    [self.contentView addSubview:grayView];
    
    [self setConstraints];
}

- (UILabel *)makeGradeContainerLabels:(UIColor *)textColor title:(NSString *)title corner:(CGFloat)corner {
    UILabel *tempL = [UILabel initLabelTextFont:18 textColor:textColor title:title];
    if (corner) {
        tempL.layer.cornerRadius = corner;
        tempL.layer.masksToBounds = YES;
        tempL.backgroundColor = [UIColor redColor];
    }
    [gradeContainer addSubview:tempL];
    return tempL;
}

- (void)setConstraints {
    [topContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.mas_equalTo(60);
    }];
    
    [self.storeIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topContainer).offset(10);
        make.centerY.equalTo(topContainer);
        make.size.mas_equalTo(CGSizeMake(55, 40));
    }];
    
    [self.storeNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.storeIV.mas_right).offset(12);
        make.top.equalTo(self.storeIV).offset(2);
    }];
    
    [self.goodsCountL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.storeNameL);
        make.top.equalTo(self.storeIV.mas_centerY);
    }];
    
    [self.collectB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topContainer).offset(-10);
        make.centerY.equalTo(topContainer);
        make.size.mas_equalTo(CGSizeMake(50, 28));
    }];
    
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topContainer).offset(5);
        make.right.equalTo(topContainer).offset(-5);
        make.bottom.equalTo(topContainer);
        make.height.mas_equalTo(1.0);
    }];
    
    
    [gradeContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(topContainer.mas_bottom).offset(10);
        make.height.mas_equalTo(25);
    }];
    
    [titleGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HPScreenWidth/24-5);
        make.centerY.equalTo(gradeContainer);
    }];
    
    [titleSeller mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HPScreenWidth*9/24-5);
        make.centerY.equalTo(gradeContainer);
    }];
    
    [titleLogistics mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HPScreenWidth*17/24-5);
        make.centerY.equalTo(gradeContainer);
    }];
    
    [self.scoreGoodsL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleGoods.mas_right);
        make.centerY.equalTo(gradeContainer);
    }];
    
    [self.scoreSellerL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleSeller.mas_right);
        make.centerY.equalTo(gradeContainer);
    }];
    
    [self.scoreLogisticsL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLogistics.mas_right);
        make.centerY.equalTo(gradeContainer);
    }];
    
    [self.descGoodsL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scoreGoodsL.mas_right);
        make.centerY.equalTo(gradeContainer);
    }];
    
    [self.descSellerL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scoreSellerL.mas_right);
        make.centerY.equalTo(gradeContainer);
    }];
    
    [self.descLogisticsL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scoreLogisticsL.mas_right);
        make.centerY.equalTo(gradeContainer);
    }];
    
    
    [goodsContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(gradeContainer.mas_bottom).offset(10);
        make.height.mas_equalTo((HPScreenWidth-35)/4);
    }];
    
    [bottomContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(goodsContainer.mas_bottom).offset(10);
        make.height.mas_equalTo(41);
    }];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(bottomContainer);
        make.height.mas_equalTo(1.0);
    }];
    
    [self.enterStoreB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bottomContainer);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
    
    
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(bottomContainer.mas_bottom);
    }];
}


#pragma mark - 懒加载

@end
