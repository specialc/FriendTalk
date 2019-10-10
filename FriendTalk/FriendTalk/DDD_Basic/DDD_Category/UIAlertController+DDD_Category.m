//
//  UIAlertController+DDD_Category.m
//  FriendTalk
//
//  Created by LYH on 2018/3/24.
//  Copyright © 2018年 LYH. All rights reserved.
//

#import "UIAlertController+DDD_Category.h"
#import <objc/runtime.h>

@implementation UIAlertController (DDD_Category)

+ (instancetype)ddd_alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actionTitles:(NSArray<NSString *> *)actionTitles actionStyles:(NSArray<NSNumber *> *)actionStyles handler:(void (^)(UIAlertAction *))handler {
    UIAlertController *ddd_alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    for (int i = 0; i < MIN(actionTitles.count, actionStyles.count); i++) {
        UIAlertAction *ddd_action = [UIAlertAction actionWithTitle:actionTitles[i] style:actionStyles[i].integerValue handler:handler];
        ddd_action.ddd_index = i;
        [ddd_alert addAction:ddd_action];
    }
    UIPopoverPresentationController *ddd_popover = ddd_alert.popoverPresentationController;
    if (UIAlertControllerStyleActionSheet == preferredStyle && ddd_popover) {
        UIWindow *ddd_window = UIApplication.sharedApplication.delegate.window;
        ddd_popover.sourceView = ddd_window;
        ddd_popover.sourceRect = CGRectOffset(ddd_window.bounds, 0, ddd_window.bounds.size.height);
    }
    return ddd_alert;
}

+ (instancetype)ddd_showAlertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actionTitles:(NSArray<NSString *> *)actionTitles actionStyles:(NSArray<NSNumber *> *)actionStyles handler:(void (^)(UIAlertAction *))handler {
    UIAlertController *ddd_alert = [self ddd_alertControllerWithTitle:title message:message preferredStyle:preferredStyle actionTitles:actionTitles actionStyles:actionStyles handler:handler];
    [DDD_VisibleViewController(nil) presentViewController:ddd_alert animated:YES completion:nil];
    return ddd_alert;
}

UIAlertController * DDD_Alert(NSString *message, NSArray<NSString *> *actionTitles, void (^handler)(UIAlertAction *action)) {
    NSMutableArray *ddd_actionStyles = [NSMutableArray array];
    for (NSString *ddd_title in actionTitles) {
        [ddd_actionStyles addObject:[ddd_title isEqualToString:@"取消"] ? @(UIAlertActionStyleCancel) : @(UIAlertActionStyleDefault)];
    }
    return [UIAlertController ddd_showAlertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert actionTitles:actionTitles actionStyles:ddd_actionStyles handler:handler];
}

UIAlertController * DDD_ActionSheet(NSString *message, NSArray<NSString *> *actionTitles, void (^handler)(UIAlertAction *action)) {
    NSMutableArray *ddd_actionStyles = [NSMutableArray array];
    for (NSString *ddd_title in actionTitles) {
        [ddd_actionStyles addObject:[ddd_title isEqualToString:@"取消"] ? @(UIAlertActionStyleCancel) : @(UIAlertActionStyleDefault)];
    }
    return [UIAlertController ddd_showAlertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleActionSheet actionTitles:actionTitles actionStyles:ddd_actionStyles handler:handler];
}

@end

#pragma mark -

static const void *DDD_kIndexKey = &DDD_kIndexKey;

@implementation UIAlertAction (DDD_Category)

- (void)setDdd_index:(NSInteger)ddd_index {
    objc_setAssociatedObject(self, DDD_kIndexKey, @(ddd_index), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)ddd_index {
    return [objc_getAssociatedObject(self, DDD_kIndexKey) integerValue];
}

@end
