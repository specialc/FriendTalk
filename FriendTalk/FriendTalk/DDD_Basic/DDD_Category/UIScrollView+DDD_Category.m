
//
//  UIScrollView+DDD_Category.m
//  FriendTalk
//
//  Created by yn2019 on 2019/10/9.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "UIScrollView+DDD_Category.h"

static const void *ddd_kDeliversNextResponderKey = &ddd_kDeliversNextResponderKey;

@implementation UIScrollView (DDD_Category)

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.ddd_deliversNextResponder) {
        [[self nextResponder] touchesBegan:touches withEvent:event];
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.ddd_deliversNextResponder) {
        [[self nextResponder] touchesMoved:touches withEvent:event];
        [super touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.ddd_deliversNextResponder) {
        [[self nextResponder] touchesEnded:touches withEvent:event];
        [super touchesEnded:touches withEvent:event];
    }
}

#pragma mark - Getter

- (BOOL)ddd_deliversNextResponder {
    return objc_getAssociatedObject(self, ddd_kDeliversNextResponderKey);
}

#pragma mark - Setter

// scrollView点击事件传递
- (void)setDdd_deliversNextResponder:(BOOL)ddd_deliversNextResponder {
    objc_setAssociatedObject(self, ddd_kDeliversNextResponderKey, @(ddd_deliversNextResponder), OBJC_ASSOCIATION_ASSIGN);
}

@end
