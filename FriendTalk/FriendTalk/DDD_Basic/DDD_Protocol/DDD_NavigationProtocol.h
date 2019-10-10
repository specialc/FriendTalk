//
//  DDD_NavigationProtocol.h
//  FriendTalk
//
//  Created by yn2019 on 2019/10/8.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DDD_NavigationProtocol <NSObject>

/// 重设keyWindow的RootViewController
- (void)ddd_resetRootViewController:(UIViewController *)viewController;

/// viewControllers
@property(nonatomic, copy, readonly) NSArray<__kindof UIViewController *> *ddd_viewControllers;
- (void)ddd_changeViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated;

#pragma mark - Push
- (void)ddd_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

/**
 * Push到@viewController，但会将@fromViewController之上的所有控制器从栈中移除
 * 假设
 * A | B | C | D
 * viewController     = E
 * fromViewController = B
 * 执行结果
 * A | B | E
 */
- (void)ddd_pushViewController:(UIViewController *)viewController fromViewController:(UIViewController *)fromViewController animated:(BOOL)animated;

#pragma mark - Pop
- (nullable UIViewController *)ddd_popViewControllerAnimated:(BOOL)animated;
- (nullable NSArray<__kindof UIViewController *> *)ddd_popToViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (nullable NSArray<__kindof UIViewController *> *)ddd_popToRootViewControllerAnimated:(BOOL)animated;

#pragma mark - Present
- (void)ddd_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
- (void)ddd_dismissViewControllerAnimated:(BOOL)animated completion: (void (^ __nullable)(void))completion;

#pragma mark -
@property(nullable, nonatomic, strong, readonly) UIViewController *ddd_topViewController;

@end

NS_ASSUME_NONNULL_END
