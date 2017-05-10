//
//  TabCartController.m
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/06/03.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//
#import "TabCartController.h"
#import "UserLoginController.h"
#import "PreorderController.h"
#import "CartModel.h"
#import "TabCartItemCell.h"
#import "TabCartSubmitBar.h"
#import "PreorderModel.h"

@interface TabCartController () <UITableViewDataSource, UITableViewDelegate, TabCartItemCellDelegate, TabCartSubmitBarDelegate>
{
    UITableView *_mainTable;
    TabCartSubmitBar *_vSubmitBar;
    NSArray *_cartItems; //购物车里的项
    NSArray *_couponUsers;
    NSNumber *_totalPrice;
}

@end


@implementation TabCartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    self.title = @"购物车";
    
    CGFloat submitBarHeight = [TabCartSubmitBar height];
    CGFloat submitBarTop = kScreenHeight - submitBarHeight - kNavBarHeight;
    CGFloat mainTableHeight = kScreenHeight - kNavBarHeight - submitBarHeight;
    _vSubmitBar = [[TabCartSubmitBar alloc] initWithFrame:CGRectMake(0, submitBarTop, kScreenWidth, submitBarHeight)];
    _vSubmitBar.delegate = self;
    
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, mainTableHeight)];
    _mainTable.tableFooterView = [[UIView alloc]init];
    _mainTable.dataSource = self;
    _mainTable.delegate = self;
    
    [self.view addSubview:_mainTable];
    [self.view addSubview:_vSubmitBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showLoadingView];
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getData
{
    __weak typeof (self) weakSelf = self;
    [CartModel getCart:^(BOOL result, NSString *message, NSArray *cartItems, NSArray *couponUsers, NSNumber *cartNum, NSNumber *totalPrice, BOOL isLoggedIn) {
        _cartItems = cartItems;
        _couponUsers = couponUsers;
        _totalPrice = totalPrice;
        [_vSubmitBar setCartNum:cartNum];
        
        [_mainTable reloadData];
        [self hideLoadingView];
        [self hideNetworkBrokenView];
    } failure:^(NSError *error) {
        //网络没有连接
        if ([error.domain isEqualToString:NSURLErrorDomain] && error.code == NSURLErrorNotConnectedToInternet) {
            [weakSelf showNetworkBrokenView:nil];
        } else {
            [weakSelf toastWithError:error];
        }
        [weakSelf hideLoadingView];
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cartItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"TabCartItemCell";
    TabCartItemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TabCartItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell fillContentWithCartItem:_cartItems[indexPath.row] couponUser:_couponUsers totalPrice:_totalPrice];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [TabCartItemCell height];
}


#pragma mark - TabCartItemCellDelegate

- (void)doClickMinus:(TabCartItemCell *)sender
{
    NSString *itemId = sender.cartItemId;
    NSNumber *count = [sender getCount];
    if (itemId.length > 0 && [count intValue] >= 2) {
        count = [NSNumber numberWithInt:[count intValue]-1];
        [self setCartItemCountWithItemId:itemId count:count sender:sender];
    }
}

- (void)doClickPlus:(TabCartItemCell *)sender
{
    NSString *itemId = sender.cartItemId;
    NSNumber *count = [sender getCount];
    if (itemId.length > 0 && [count intValue] >= 0) {
        count = [NSNumber numberWithInt:[count intValue]+1];
        [self setCartItemCountWithItemId:itemId count:count sender:sender];
    }
}

- (void)setCartItemCountWithItemId:(NSString *)itemId count:(NSNumber *)count sender:(TabCartItemCell *)sender
{
    [self showLoadingView];
    __weak typeof (self) weakSelf = self;
    [CartModel setCartItemCountWithItemId:itemId count:count success:^(BOOL result, NSString *message, NSNumber *cartNum, NSNumber *totalPrice) {
        if (result) {
            [sender setCount:count];
        } else {
            [self toast:message];
        }
        [weakSelf hideLoadingView];
    } failure:^(NSError *error) {
        [self toastWithError:error];
        [weakSelf hideLoadingView];
    }];
}

- (void)doClickDelete:(TabCartItemCell *)sender
{
    [self showLoadingView];
    NSString *itemId = sender.cartItemId;
    __weak typeof (self) weakSelf = self;
    [CartModel deleteCartItemWithItemId:itemId success:^(BOOL result, NSString *message, NSNumber *cartNum, NSNumber *totalPrice) {
        if (result) {
            [self getData];
        } else {
            [self toast:message];
        }
        [weakSelf hideLoadingView];
    } failure:^(NSError *error) {
        [self toastWithError:error];
        [weakSelf hideLoadingView];
    }];
}

- (void)doClickSelect:(TabCartItemCell *)sender isSelected:(NSNumber *)isSelected
{
    [self showLoadingView];
    NSString *itemId = sender.cartItemId;
    __weak typeof (self) weakSelf = self;
    [CartModel selectCartItemWithItemId:itemId isSelected:isSelected success:^(BOOL result, NSString *message, NSNumber *cartNum, NSNumber *totalPrice) {
        if (result) {
            [self getData];
            [sender setIsSelectedBy:isSelected];
        } else {
            [self toast:message];
        }
        [weakSelf hideLoadingView];
    } failure:^(NSError *error) {
        [self toastWithError:error];
        [weakSelf hideLoadingView];
    }];
}

- (void)doClickSubmitCartBtn
{
    __weak typeof (self) weakSelf = self;
    [self showLoadingView];
    
    //用户没有登陆则跳到登陆页面
    [PreorderModel add:^(BOOL result, NSNumber *resultCode, NSString *message, NSString *preorderId) {
        NSNumber *resultCodeUserNotLogedin = kResultCodeUserNotLogedin;
        NSNumber *resultCodeUserSuccess = kResultCodeSuccess;
        if ([resultCode isEqualToNumber:resultCodeUserNotLogedin]) {
            UserLoginController *userController = [UserLoginController new];
            userController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:userController animated:YES];
        }
        else if ([resultCode isEqualToNumber:resultCodeUserSuccess]) {
            PreorderController *preorderController = [[PreorderController alloc] initWithPreorderId:preorderId];
            preorderController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:preorderController animated:YES];
        } else {
            [self toast:message];
        }
        [weakSelf hideLoadingView];
    } failure:^(NSError *error) {
        [self toastWithError:error];
        [weakSelf hideLoadingView];
    }];
}

- (void)doClickNetworkBrokenView
{
    [self showLoadingView];
    [self getData];
}

@end
