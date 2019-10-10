//
//  DDD_NavigationManager.m
//  FriendTalk
//
//  Created by yn2019 on 2019/10/8.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_NavigationManager.h"
#import "DDD_MainViewController.h"
#import "DDD_LoginViewController.h"
#import "DDD_CompleteInfoViewController.h"
#import "DDD_TagsViewController.h"

@implementation DDD_NavigationManager

+ (void)ddd_resetRootViewController {
    UIViewController *ddd_first = self.ddd_navigationServices.ddd_viewControllers.firstObject;
    if (DDD_CurrentUser.ddd_isLogin) {
        if (![ddd_first isKindOfClass:[DDD_MainViewController class]]) {
            DDD_MainViewController *ddd_vc = [[DDD_MainViewController alloc] init];
            DDD_BaseNavigationController *ddd_nav = [[DDD_BaseNavigationController alloc] initWithRootViewController:ddd_vc];
            [self.ddd_navigationServices ddd_resetRootViewController:ddd_nav];
        }
    }
    else {
        if (![ddd_first isKindOfClass:[DDD_LoginViewController class]]) {
            DDD_LoginViewController *ddd_vc = [[DDD_LoginViewController alloc] init];
            DDD_BaseNavigationController *ddd_nav = [[DDD_BaseNavigationController alloc] initWithRootViewController:ddd_vc];
            [self.ddd_navigationServices ddd_resetRootViewController:ddd_nav];
        }
    }
}

+ (void)ddd_handleUserLogin:(NSDictionary *)responseObject isLogin:(BOOL)isLogin {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ddd_FriendTalk_had_login];
    
    UIViewController *ddd_popVC = nil;
    for (UIViewController *ddd_vc in self.ddd_navigationServices.ddd_viewControllers) {
        if ([ddd_vc isMemberOfClass:[DDD_LoginViewController class]]) {
            break;
        }
        ddd_popVC = ddd_vc;
    }
    
#warning CYTest
    DDD_CurrentUser.is_perfect = 3;
    
    // 判断是否资料完善
    // 1 完善
    // 2 老用户未完善
    // 3 新用户未完善
    if (DDD_CurrentUser.is_perfect == 2) {
        [self ddd_handleForCompleteInfoWithPopViewController:ddd_popVC responseObject:responseObject isLogin:isLogin];
    }
    else if (DDD_CurrentUser.is_perfect == 3) {
        [self ddd_handleForCompleteInfoWithPopViewController:ddd_popVC responseObject:responseObject isLogin:isLogin];
    }
    else {
        if (!isLogin) {
            return;
        }
        [SVProgressHUD showInfoWithStatus:@"登录成功"];
        [self.ddd_navigationServices ddd_popToViewController:ddd_popVC animated:YES];
    }
}

// 完善信息
+ (void)ddd_handleForCompleteInfoWithPopViewController:(UIViewController *)popVC responseObject:(NSDictionary *)responseObject isLogin:(BOOL)isLogin {
    if ([self.ddd_navigationServices.ddd_topViewController isKindOfClass:[DDD_CompleteInfoViewController class]]) {
        return;
    }
    
    DDD_CompleteInfoViewController *ddd_vc = [[DDD_CompleteInfoViewController alloc] init];
    ddd_vc.ddd_dataModel = responseObject;
    ddd_vc.ddd_handleUserInfoCompleted = ^{
        [self ddd_handleForTagsSelect];
    };
    [self.ddd_navigationServices ddd_pushViewController:ddd_vc fromViewController:popVC animated:YES];
}

// 标签选择
+ (void)ddd_handleForTagsSelect {
    [DDD_TagsViewController ddd_showViewControllerCompletion:^{
        
    }];
//    DDD_TagsViewController *ddd_vc = [[DDD_TagsViewController alloc] init];
//    [self.ddd_navigationServices ddd_pushViewController:ddd_vc animated:YES];
}

+ (void)ddd_openSettingsURL {
    NSURL *ddd_url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:ddd_url];
    if ([[UIApplication sharedApplication] canOpenURL:ddd_url]) {
        [[UIApplication sharedApplication] openURL:ddd_url];
    }
}

@end
