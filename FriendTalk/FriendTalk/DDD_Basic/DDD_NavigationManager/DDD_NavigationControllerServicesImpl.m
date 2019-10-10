//
//  DDD_NavigationControllerServicesImpl.m
//  FriendTalk
//
//  Created by yn2019 on 2019/10/8.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_NavigationControllerServicesImpl.h"

@interface DDD_NavigationControllerServicesImpl ()
@property (nonatomic, strong) NSMutableArray<UINavigationController *> *ddd_navigationControllers;
@property (nonatomic, weak, readonly) UINavigationController *ddd_topNavigationController;
@end

@implementation DDD_NavigationControllerServicesImpl

- (instancetype)init {
    self = [super init];
    if (self) {
        _ddd_navigationControllers = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - DDD_NavigationControllerServices - Start

#pragma mark - ResetRootViewController

- (void)ddd_resetRootViewController:(UIViewController *)viewController {
    if (![viewController isKindOfClass:UINavigationController.class]) {
        DDD_BaseNavigationController *navigationController = [[DDD_BaseNavigationController alloc] initWithRootViewController:viewController];
        [self ddd_addNavigationController:navigationController];
        UIApplication.sharedApplication.delegate.window.rootViewController = navigationController;
    }
    else {
        [self ddd_addNavigationController:(DDD_BaseNavigationController *)viewController];
        UIApplication.sharedApplication.delegate.window.rootViewController = viewController;
    }
    [UIApplication.sharedApplication.delegate.window.layer ddd_autoAnimating];
    [UIApplication.sharedApplication.delegate.window makeKeyAndVisible];
}

- (void)ddd_changeViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    [self.ddd_topNavigationController setViewControllers:viewControllers animated:animated];
}

#pragma mark - Push

// 原生
- (void)ddd_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.ddd_topNavigationController pushViewController:viewController animated:animated];
}

// 自定义
- (void)ddd_pushViewController:(UIViewController *)viewController fromViewController:(UIViewController *)fromViewController animated:(BOOL)animated {
    NSMutableArray *ddd_vcArray = [[NSMutableArray alloc] init];
    for (UIViewController *ddd_vc in self.ddd_viewControllers) {
        [ddd_vcArray addObject:ddd_vc];
        if ([ddd_vc isEqual:fromViewController]) {
            break;
        }
    }
    [ddd_vcArray addObject:viewController];
    [self ddd_changeViewControllers:[ddd_vcArray copy] animated:animated];
}

#pragma mark - Pop

// 原生
- (UIViewController *)ddd_popViewControllerAnimated:(BOOL)animated {
    return [self.ddd_topNavigationController popViewControllerAnimated:YES];
}

- (NSArray<UIViewController *> *)ddd_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    return [self.ddd_topNavigationController popToViewController:viewController animated:animated];
}

- (NSArray<UIViewController *> *)ddd_popToRootViewControllerAnimated:(BOOL)animated {
    return [self.ddd_topNavigationController popToRootViewControllerAnimated:animated];
}

#pragma mark - Present

- (void)ddd_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^)(void))completion {
    UINavigationController *ddd_presentingViewController = self.ddd_topNavigationController;
    if (![viewControllerToPresent isKindOfClass:UINavigationController.class]) {
        UINavigationController *ddd_navigationController = [[UINavigationController alloc] initWithRootViewController:viewControllerToPresent];
        [self ddd_addNavigationController:ddd_navigationController];
        
        [ddd_presentingViewController presentViewController:ddd_navigationController animated:animated completion:completion];
    }
    else {
        [self ddd_addNavigationController:(UINavigationController *)viewControllerToPresent];
        [ddd_presentingViewController presentViewController:viewControllerToPresent animated:animated completion:completion];
    }
}

- (void)ddd_dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion {
    [self ddd_popNavigationController];
    [self.ddd_topNavigationController dismissViewControllerAnimated:animated completion:completion];
}

#pragma mark - Method

- (void)ddd_addNavigationController:(UINavigationController *)navigationController {
    if ([self.ddd_navigationControllers containsObject:navigationController]) {
        return;
    }
    [self.ddd_navigationControllers addObject:navigationController];
}

- (UINavigationController *)ddd_popNavigationController {
    UINavigationController *ddd_navigationController = self.ddd_navigationControllers.lastObject;
    [self.ddd_navigationControllers removeLastObject];
    return ddd_navigationController;
}

#pragma mark - Getter

- (NSArray<UIViewController *> *)ddd_viewControllers {
    return self.ddd_topNavigationController.viewControllers;
}

- (UIViewController *)ddd_topViewController {
    return self.ddd_topNavigationController.topViewController;
}

#pragma mark - DDD_NavigationControllerServices - End

#pragma mark - Getter

- (UINavigationController *)ddd_topNavigationController {
    return self.ddd_navigationControllers.lastObject;
}

@end
