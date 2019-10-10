//
//  DDD_BaseView.m
//  FriendTalk
//
//  Created by yn2019 on 2019/9/26.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_BaseView.h"

@interface DDD_BaseView ()

@end

@implementation DDD_BaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self ddd_addSubViews];
        [self ddd_addMasonrys];
    }
    return self;
}

#pragma mark - Subview处理函数

- (void)ddd_addSubViews {
    // self.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundColor = [UIColor clearColor];
}

- (void)ddd_addMasonrys {
    
}

@end
