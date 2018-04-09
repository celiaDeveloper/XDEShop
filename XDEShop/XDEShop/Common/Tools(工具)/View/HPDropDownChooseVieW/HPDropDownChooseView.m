//
//  XMDropDownChooseView.m
//  Created by Felix on 14-3-17.
//  Copyright (c) 2014年 xxyyzz. All rights reserved.
//

#import "HPDropDownChooseView.h"
#import "UIButton+HPImageTitleSpacing.h"

@implementation HPDropDownChooseView
{
    UIView * backGroundView;
    
    NSString * currentMenu;
}
static NSString * const ListTableViewID = @"ListTableViewCell";


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createInterface];
    }
    return self;
}

- (void)createInterface {
    [self addSubview:self.menu];
    self.chooseMode = HPChooseModeSlectedHidden;
    backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0,0, W_PATH, H_PATH)];
    backGroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    
    UITapGestureRecognizer * bgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgTappedAction:)];
    bgTap.delegate = self;
    [backGroundView addGestureRecognizer:bgTap];
    
    [backGroundView addSubview:self.ListTableView];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch  {
    // 输出点击的view的类名
    DEBUGLog(@"%@", NSStringFromClass([touch.view class]));
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

- (void)bgTappedAction:(UITapGestureRecognizer *)tap {
    self.chooseMode = HPChooseModeSlectedHidden;
}

- (void)setMenuTitleArr:(NSArray *)menuTitleArr {
    _menuTitleArr = menuTitleArr;
    currentMenu = _menuTitleArr.count > 0 ? _menuTitleArr[0] : @"无";
    [self.menu setTitle:currentMenu forState:0];//[currentMenu substringToIndex:2]
    
    [self.menu layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleRight imageTitleSpace:10];
}

- (void)setSelectColor:(UIColor *)selectColor {
    _selectColor = selectColor;
    
}

- (void)setNo_selectColor:(UIColor *)no_selectColor {
    _no_selectColor = no_selectColor;
    [_menu setTitleColor:_no_selectColor ? : [UIColor darkGrayColor] forState:UIControlStateNormal];
}

-(void)setFont:(UIFont *)font
{
    _font = font;
    [_menu.titleLabel setFont:_font ? : [UIFont systemFontOfSize:20]];
}

- (void)setChooseMode:(HPChooseMode)chooseMode {
    _chooseMode = chooseMode;

    switch (chooseMode) {
        case HPChooseModeNo:
            [self hideChooseView];
            break;
            
        case HPChooseModeSlectedHidden:
            [self hideChooseView];
            break;
            
        case HPChooseModeSlectedShow:
            [self showChooseView];
            break;
            
        default:
            break;
    }
}

- (void)sectionBtnAction:(UIButton *)btn {
    
    if (self.chooseMode == HPChooseModeNo) {
        self.chooseMode = HPChooseModeSlectedHidden;
        if ([self.chooseDelegate respondsToSelector:@selector(choosedview:AtIndex:)]) {
            [self.chooseDelegate choosedview:self AtIndex:[self.menuTitleArr indexOfObject:currentMenu]];
        }
        return;
    }
    
    if (self.chooseMode == HPChooseModeSlectedHidden) {
        self.chooseMode = HPChooseModeSlectedShow;
        if ([self.chooseDelegate respondsToSelector:@selector(choosedview:AtIndex:)]) {
            [self.chooseDelegate choosedview:self AtIndex:-100];
        }
        return;
    }
    
    if (self.chooseMode == HPChooseModeSlectedShow) {
        self.chooseMode = HPChooseModeSlectedHidden;
        return;
    }
}

/**
 移除筛选器列表
 */
- (void)hideChooseView {

    [UIView animateWithDuration:0.2 animations:^(void){
        CGRect frame = self.ListTableView.frame;
        frame.size.height = 0;
        self.ListTableView.frame = frame;
        backGroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.menu.selected = NO;
    } completion:^(BOOL finished){
//        [self.ListTableView removeFromSuperview];
        [backGroundView removeFromSuperview];
        
    }];
}

/**
 展示筛选器列表
 */
- (void)showChooseView {
    
    [[self belongViewController].view addSubview:backGroundView];
    [[self belongViewController].view insertSubview:backGroundView atIndex:1];
    CGFloat tableViewHeight = (self.menuTitleArr.count > 5) ? (5 * 40) : (self.menuTitleArr.count * 40);
    
    [UIView animateWithDuration:0.2 animations:^(void){
        CGRect frame = self.ListTableView.frame;
        frame.size.height = tableViewHeight;
        self.ListTableView.frame = frame;
        backGroundView.backgroundColor = [UIColor colorWithWhite:0.5f alpha:0.2];
        self.menu.selected = YES;
    }];
    [self.ListTableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuTitleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ListTableViewID];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ListTableViewID];
    }
    cell.textLabel.text = self.menuTitleArr[indexPath.row];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    cell.textLabel.font = self.font ? : [UIFont systemFontOfSize:20];
    cell.textLabel.textColor = self.no_selectColor? _no_selectColor : [UIColor darkGrayColor];
    if ([cell.textLabel.text isEqualToString:currentMenu]) {
//        cell.tintColor = _selectColor ? _selectColor : [UIColor darkGrayColor];
        [cell.textLabel setTextColor:_selectColor ? _selectColor : [UIColor darkGrayColor]];
//        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    currentMenu = self.menuTitleArr[indexPath.row];
    [self.menu setTitle:currentMenu forState:UIControlStateNormal];//[currentMenu substringToIndex:2]
    [self.menu layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleRight imageTitleSpace:10];
    if ([self.chooseDelegate respondsToSelector:@selector(choosedview:AtIndex:)]) {
        [self.chooseDelegate choosedview:self AtIndex:indexPath.row];
    }
    self.chooseMode = HPChooseModeSlectedHidden;
}
#pragma mark - 懒加载
- (UIButton *)menu {
    if (!_menu) {
        _menu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,self.bounds.size.width, self.bounds.size.height)];
        [_menu setImage:[UIImage imageNamed:@"choose_down"] forState:UIControlStateNormal];
        [_menu setImage:[UIImage imageNamed:@"choose_up"] forState:UIControlStateSelected];
        [_menu setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_menu setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
        [_menu addTarget:self action:@selector(sectionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_menu setBackgroundColor: [UIColor whiteColor]];
        _menu.titleLabel.font = [UIFont systemFontOfSize:20];
        _menu.center =CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    }
    
    return _menu;
}

- (UITableView *)ListTableView {
    if (!_ListTableView) {
        _ListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.frame), backGroundView.bounds.size.width, 0) style:UITableViewStylePlain];
        _ListTableView.delegate = self;
        _ListTableView.dataSource = self;
    }
    return _ListTableView;
}


- (UIViewController *)belongViewController {
    
    for (UIView *next = [self superview]; next; next = next.superview) {
        
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
