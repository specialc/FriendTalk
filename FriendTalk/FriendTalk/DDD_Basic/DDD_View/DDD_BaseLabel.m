//
//  DDD_BaseLabel.m
//  FriendTalk
//
//  Created by yn2019 on 2019/9/27.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_BaseLabel.h"

@interface DDD_BaseLabel ()

@end

@implementation DDD_BaseLabel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        // iOS6默认不是透明色，这里强制设置
        self.backgroundColor = [UIColor clearColor];
        self.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (void)layoutSubviews {
    // 固定宽度，高度自适应，iOS8以下需要
    self.preferredMaxLayoutWidth = self.frame.size.width;
    [super layoutSubviews];
}

@end
