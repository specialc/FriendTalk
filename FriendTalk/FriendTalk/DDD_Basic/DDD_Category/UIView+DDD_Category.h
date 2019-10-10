//
//  UIView+DDD_Category.h
//  FriendTalk
//
//  Created by zhxixh_pc on 2019/9/27.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (DDD_Category)
@property (nonatomic, assign) CGFloat ddd_top;
@property (nonatomic, assign) CGFloat ddd_left;
@property (nonatomic, assign) CGFloat ddd_bottom;
@property (nonatomic, assign) CGFloat ddd_right;
@property (nonatomic, assign) CGSize ddd_size;
@property (nonatomic, assign) CGFloat ddd_width;
@property (nonatomic, assign) CGFloat ddd_height;
@property (nonatomic, assign) CGFloat ddd_centerX;
@property (nonatomic, assign) CGFloat ddd_centerY;

- (void)removeAllSubviews;
@end

NS_ASSUME_NONNULL_END
