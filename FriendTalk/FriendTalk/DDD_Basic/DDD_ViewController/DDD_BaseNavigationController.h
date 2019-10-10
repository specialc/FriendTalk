//
//  DDD_BaseNavigationController.h
//  FriendTalk
//
//  Created by yn2019 on 2019/9/27.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDD_NavigationControllerDelegate <NSObject>

@optional
// 侧滑：默认支持侧滑
- (BOOL)ddd_popGestureEnabled;

@end

@interface DDD_BaseNavigationController : UINavigationController

@end
