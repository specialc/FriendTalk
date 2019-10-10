//
//  UIAlertController+DDD_Category.h
//  FriendTalk
//
//  Created by LYH on 2018/3/24.
//  Copyright © 2018年 LYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (DDD_Category)

/**
 创建带回调方法的 UIAlertController
 
 @param actionTitles UIAlertAction title 列表
 @param actionStyles UIAlertAction title 对应的 UIAlertActionStyle 列表
 @param handler UIAlertAction 点击回调
 */
+ (instancetype)ddd_alertControllerWithTitle:(NSString *)title
                                     message:(NSString *)message
                              preferredStyle:(UIAlertControllerStyle)preferredStyle
                                actionTitles:(NSArray<NSString *> *)actionTitles
                                actionStyles:(NSArray<NSNumber *> *)actionStyles
                                     handler:(void (^)(UIAlertAction *action))handler;

/**
 创建并显示带回调方法的 UIAlertController
 
 @param actionTitles UIAlertAction title 列表
 @param actionStyles UIAlertAction title 对应的 UIAlertActionStyle 列表
 @param handler UIAlertAction 点击回调
 */
+ (instancetype)ddd_showAlertControllerWithTitle:(NSString *)title
                                         message:(NSString *)message
                                  preferredStyle:(UIAlertControllerStyle)preferredStyle
                                    actionTitles:(NSArray<NSString *> *)actionTitles
                                    actionStyles:(NSArray<NSNumber *> *)actionStyles
                                         handler:(void (^)(UIAlertAction *action))handler;

UIAlertController * DDD_Alert(NSString *message, NSArray<NSString *> *actionTitles, void (^handler)(UIAlertAction *action));

UIAlertController * DDD_ActionSheet(NSString *message, NSArray<NSString *> *actionTitles, void (^handler)(UIAlertAction *action));

@end

#pragma mark -

@interface UIAlertAction (DDD_Category)
@property (nonatomic, assign) NSInteger ddd_index;
@end
