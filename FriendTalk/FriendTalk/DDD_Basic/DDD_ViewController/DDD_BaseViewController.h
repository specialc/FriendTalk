//
//  DDD_BaseViewController.h
//  FriendTalk
//
//  Created by yn2019 on 2019/9/26.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDD_BaseNavigationController.h"
#import "DDD_BaseNavigationBar.h"

@interface DDD_BaseViewController : UIViewController <DDD_NavigationControllerDelegate>

#pragma mark - 右滑

- (BOOL)ddd_popGestureEnabled;

#pragma mark - 视图

// 添加导航栏
- (void)ddd_addNavigationBar;
// 添加视图
- (void)ddd_addSubViews NS_REQUIRES_SUPER;
// 添加约束
- (void)ddd_addMasonrys;

- (void)ddd_removeObservers NS_REQUIRES_SUPER;
- (void)ddd_addObservers NS_REQUIRES_SUPER;

#pragma mark - 导航栏

@property (nonatomic, weak) DDD_BaseNavigationBar *ddd_navBar;
@property (nonatomic, assign) BOOL ddd_hiddenNavBar;

- (void)ddd_didClickBackButton:(UIButton *)sender;
- (void)ddd_didClickRightDefaultButton:(UIButton *)sender;

#pragma mark - 网络请求

// 请求网络
- (void)ddd_requestNetwork;
// 网络请求成功
- (void)ddd_getRequestSuccess:(id)ddd_data;
// 网络请求失败
- (void)ddd_getRequestFailure:(NSError *)ddd_error;

#pragma mark - 数据源

@property (nonatomic, strong) id ddd_viewData;

@end
