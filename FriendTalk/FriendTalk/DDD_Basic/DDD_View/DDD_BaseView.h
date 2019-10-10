//
//  DDD_BaseView.h
//  FriendTalk
//
//  Created by yn2019 on 2019/9/26.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDD_BaseViewProtocol <NSObject>

// 添加视图
- (void)ddd_addSubViews;
// 添加约束
- (void)ddd_addMasonrys;

@end


@interface DDD_BaseView : UIView <DDD_BaseViewProtocol>

@end
