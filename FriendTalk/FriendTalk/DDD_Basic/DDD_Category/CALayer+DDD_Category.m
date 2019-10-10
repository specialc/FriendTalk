//
//  CALayer+DDD_Category.m
//  FriendTalk
//
//  Created by yn2019 on 2019/10/8.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "CALayer+DDD_Category.h"

@implementation CALayer (DDD_Category)

- (void)ddd_autoAnimating {
    CATransition *ddd_transition = [CATransition animation];
    ddd_transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    ddd_transition.type = kCATransitionFade;
    ddd_transition.duration = 0.25;
    [self addAnimation:ddd_transition forKey:nil];
}

@end
