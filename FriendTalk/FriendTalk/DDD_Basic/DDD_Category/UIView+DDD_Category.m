//
//  UIView+DDD_Category.m
//  FriendTalk
//
//  Created by zhxixh_pc on 2019/9/27.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "UIView+DDD_Category.h"

@implementation UIView (DDD_Category)

- (CGFloat)ddd_top {
    return self.frame.origin.y;
}

- (void)setDdd_top:(CGFloat)ddd_top {
    CGRect ddd_rect = self.frame;
    ddd_rect.origin.y = ddd_top;
    self.frame = ddd_rect;
}

- (CGFloat)ddd_left {
    return self.frame.origin.x;
}

- (void)setDdd_left:(CGFloat)ddd_left {
    CGRect ddd_rect = self.frame;
    ddd_rect.origin.x = ddd_left;
    self.frame = ddd_rect;
}

- (CGFloat)ddd_bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setDdd_bottom:(CGFloat)ddd_bottom {
    CGRect ddd_rect = self.frame;
    ddd_rect.origin.y = ddd_bottom - ddd_rect.size.height;
    self.frame = ddd_rect;
}

- (CGFloat)ddd_right {
    return CGRectGetMaxX(self.frame);
}

- (void)setDdd_right:(CGFloat)ddd_right {
    CGRect ddd_rect = self.frame;
    ddd_rect.origin.x = ddd_right - ddd_rect.size.width;
    self.frame = ddd_rect;
}

- (CGSize)ddd_size {
    return self.frame.size;
}

- (void)setDdd_size:(CGSize)ddd_size {
    CGRect ddd_rect = self.frame;
    ddd_rect.size = ddd_size;
    self.frame = ddd_rect;
}

- (CGFloat)ddd_width {
    return self.frame.size.width;
}

- (void)setDdd_width:(CGFloat)ddd_width {
    CGRect ddd_rect = self.frame;
    ddd_rect.size.width = ddd_width;
    self.frame = ddd_rect;
}

- (CGFloat)ddd_height {
    return self.frame.size.height;
}

- (void)setDdd_height:(CGFloat)ddd_height {
    CGRect ddd_rect = self.frame;
    ddd_rect.size.height = ddd_height;
    self.frame = ddd_rect;
}

- (CGFloat)ddd_centerX {
    return self.center.x;
}

- (void)setDdd_centerX:(CGFloat)ddd_centerX {
    CGPoint ddd_point = self.center;
    ddd_point.x = ddd_centerX;
    self.center = ddd_point;
}

- (CGFloat)ddd_centerY {
    return self.center.y;
}

- (void)setDdd_centerY:(CGFloat)ddd_centerY {
    CGPoint ddd_point = self.center;
    ddd_point.y = ddd_centerY;
    self.center = ddd_point;
}

- (void)removeAllSubviews {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}

@end
