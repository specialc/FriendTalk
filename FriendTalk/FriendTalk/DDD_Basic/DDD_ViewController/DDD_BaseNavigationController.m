//
//  DDD_BaseNavigationController.m
//  FriendTalk
//
//  Created by yn2019 on 2019/9/27.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_BaseNavigationController.h"

@interface DDD_BaseNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>
@property (nonatomic, assign) BOOL ddd_isPush;
@end

@implementation DDD_BaseNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self setNavigationBarHidden:YES animated:NO];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) ddd_weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = ddd_weakSelf;
        self.delegate = ddd_weakSelf;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self.viewControllers containsObject:viewController]) {
        return;
    }
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super setViewControllers:viewControllers animated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return  [super popToRootViewControllerAnimated:animated];
}
- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if( [self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    // 在VC栈中
    if ([self.viewControllers containsObject:viewController]) {
        return [super popToViewController:viewController animated:animated];
        
    }
    // vc.tabBarController在VC栈中
    if (viewController.tabBarController && [self.viewControllers containsObject:viewController.tabBarController]) {
        return [super popToViewController:viewController.tabBarController animated:animated];
    }
    // 都不在不允许POP
    return nil;
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    
    if (!self.ddd_isPush) {
    }
    self.ddd_isPush = NO;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        self.ddd_isPush = YES;
    }
    else {
        self.ddd_isPush = NO;
    }
    return nil;
}

#pragma mark UINavigationControllerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count <= 1 || self.visibleViewController == self.viewControllers.firstObject) {
            return NO;
        }
        if ([self.visibleViewController conformsToProtocol:@protocol(DDD_NavigationControllerDelegate)]) {
            id<DDD_NavigationControllerDelegate> delegate = (id)self.visibleViewController;
            if ([delegate respondsToSelector:@selector(ddd_popGestureEnabled)]) {
                return [delegate ddd_popGestureEnabled];
            }
        }
    }
    return YES;
}

@end
