//
//  DDD_Common.m
//  FriendTalk
//
//  Created by zhxixh_pc on 2019/9/29.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_Common.h"

@implementation DDD_Common

UIViewController * DDD_VisibleViewController(UIViewController *viewController) {
    if (![viewController isKindOfClass:[UIViewController class]]) {
        UIViewController *ddd_root = UIApplication.sharedApplication.delegate.window.rootViewController;
        return DDD_VisibleViewController(ddd_root);
    }
    if (viewController.isBeingDismissed) {
        UIViewController *ddd_presenting = viewController.presentingViewController;
        return DDD_VisibleViewController(ddd_presenting);
    }
    if (viewController.presentedViewController && !viewController.presentedViewController.isBeingDismissed) {
        UIViewController *ddd_presented = viewController.presentedViewController;
        return DDD_VisibleViewController(ddd_presented);
    }
    if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *ddd_tab = (id)viewController;
        return DDD_VisibleViewController(ddd_tab.selectedViewController);
    }
    else if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *ddd_nav = (id)viewController;
        return ddd_nav.topViewController;
    }
    return viewController;
}

BOOL DDD_ShowViewController(UIViewController *viewController, BOOL animated) {
    UIViewController *ddd_vc = DDD_VisibleViewController(nil);
    if (!ddd_vc) {
        return NO;
    }
    if (ddd_vc.navigationController && ![viewController isKindOfClass:[UINavigationController class]]) {
        [ddd_vc.navigationController pushViewController:viewController animated:animated];
    } else {
        [ddd_vc presentViewController:viewController animated:animated completion:nil];
    }
    return YES;
}

@end
