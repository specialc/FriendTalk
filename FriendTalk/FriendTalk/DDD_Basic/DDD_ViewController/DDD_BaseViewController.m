//
//  DDD_BaseViewController.m
//  FriendTalk
//
//  Created by yn2019 on 2019/9/26.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_BaseViewController.h"

@interface DDD_BaseViewController ()

@end

@implementation DDD_BaseViewController

- (void)dealloc {
    [self ddd_removeObservers];
    NSLog(@"%@ [%@.m:0] Dealloc.", self, NSStringFromClass([self class]));
}

#pragma mark - 侧滑

- (BOOL)ddd_popGestureEnabled {
    return YES;
}

#pragma mark - 状态栏

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *ddd_className = NSStringFromClass([self class]);
    NSLog(@"%@ [%@.m:0] viewDidLoad.", self, ddd_className);
    
    [self ddd_addNavigationBar];
    [self ddd_addSubViews];
    [self ddd_addMasonrys];
    [self ddd_addObservers];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

#pragma mark - 加载视图

- (void)ddd_addNavigationBar {
    if (!self.ddd_hiddenNavBar) {
        DDD_BaseNavigationBar *navBar = [[DDD_BaseNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.ddd_width, DDD_NAVIGATION_BAR_HEIGHT)];
        @weakify(self);
        navBar.ddd_viewDidTouch = ^(id view) {
            @strongify(self);
            if (view == navBar.ddd_backButton) {
                [self ddd_didClickBackButton:view];
            }
            else if (view == navBar.ddd_rightDefaultButton) {
                [self ddd_didClickRightDefaultButton:view];
            }
        };
        [self.view addSubview:navBar];
        self.ddd_navBar = navBar;
    }
}

- (void)ddd_addSubViews {
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)ddd_addMasonrys {
    
}

#pragma mark - NavBar

- (void)ddd_didClickBackButton:(UIButton *)sender {
    if (self.presentingViewController && (!self.navigationController || self.navigationController.viewControllers.count <= 1)) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    else if (self.navigationController && self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)ddd_didClickRightDefaultButton:(UIButton *)sender {
    
}

#pragma mark - 网络请求

- (void)ddd_requestNetwork {
    
}

#pragma mark - 赋值

- (void)ddd_getRequestSuccess:(id)ddd_data {
    _ddd_viewData = ddd_data;
}

- (void)ddd_getRequestFailure:(NSError *)ddd_error {
    NSString *msg = ddd_error.msg ?: @"数据加载失败，请稍后再试";
    // 如果没有数据
    if (!self.ddd_viewData) {
        // 网络错误 <= NSURLErrorCancelled
        if (ddd_error.code < 0) {
//            [self.loading loadingFailureNetwork];
            [SVProgressHUD showWithStatus:msg];
        }
        // 服务器错误
        else {
//            [self.loading loadingFailureNormal:msg];
        }
    }
    // 如果有数据
    else {
        [SVProgressHUD showWithStatus:msg];
    }
}

#pragma mark - KVO

- (void)ddd_removeObservers {}

- (void)ddd_addObservers {}

@end
