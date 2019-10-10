//
//  DDD_BaseNavigationBar.h
//  FriendTalk
//
//  Created by LYH on 2018/6/21.
//  Copyright © 2018年 LYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDD_BaseNavigationBar : UIView

/** 返回按钮 */
@property (nonatomic, readonly) UIButton *ddd_backButton;
/** 右侧默认按钮 */
@property (nonatomic, readonly) UIButton *ddd_rightDefaultButton;

/** 设置背景颜色 */
@property (nonatomic, strong) UIColor *ddd_backgroundColor UI_APPEARANCE_SELECTOR;
/** 设置按钮渲染颜色 */
@property (nonatomic, strong) UIColor *ddd_tintColor UI_APPEARANCE_SELECTOR;

/** 设置背景图片 */
@property (nonatomic, strong) UIImage *ddd_backgroundImage UI_APPEARANCE_SELECTOR;
/** 设置返回按钮图片 */
@property (nonatomic, strong) UIImage *ddd_backButtonImage UI_APPEARANCE_SELECTOR;
/** 设置右侧默认按钮图片 */
@property (nonatomic, strong) UIImage *ddd_rightDefaultButtonImage;

/** 设置标题 */
@property (nonatomic, copy) NSString *ddd_title;
/** 设置自定义 titleView */
@property (nonatomic, strong) UIView *ddd_titleView;
/** 设置返回按钮标题 */
@property (nonatomic, copy) NSString *ddd_backButtonTitle UI_APPEARANCE_SELECTOR;
/** 设置右侧默认按钮标题 */
@property (nonatomic, copy) NSString *ddd_rightDefaultButtonTitle;

/** 设置标题颜色 */
@property (nonatomic, strong) UIColor *ddd_titleColor UI_APPEARANCE_SELECTOR;
/** 设置标题颜色 (animated) */
- (void)ddd_setTitleColor:(UIColor *)color animated:(BOOL)animated;

/** 设置底部分隔线颜色 */
@property (nonatomic, strong) UIColor *ddd_shadowColor UI_APPEARANCE_SELECTOR;

/** 是否高斯模糊 */
@property (nonatomic, assign, getter=isDdd_translucent) BOOL ddd_translucent UI_APPEARANCE_SELECTOR;

/** 隐藏返回按钮 */
@property (nonatomic, assign) BOOL ddd_hidesBackButton UI_APPEARANCE_SELECTOR;
/** 隐藏返回按钮标题 */
@property (nonatomic, assign) BOOL ddd_hidesBackButtonTitle UI_APPEARANCE_SELECTOR;
/** 隐藏返回按钮图片 */
@property (nonatomic, assign) BOOL ddd_hidesBackButtonImage UI_APPEARANCE_SELECTOR;
/** 隐藏右侧默认按钮 */
@property (nonatomic, assign) BOOL ddd_hidesRightDefaultButton;
/** 隐藏底部分隔线 */
@property (nonatomic, assign) BOOL ddd_hidesShadowView UI_APPEARANCE_SELECTOR;

/** 设置自定义左侧按钮 */
@property (nonatomic, strong) UIButton *ddd_leftButton;
/** 设置自定义右侧按钮 */
@property (nonatomic, strong) UIButton *ddd_rightButton;
/** 设置自定义左侧按钮 (animated) */
- (void)ddd_setLeftButton:(UIButton *)button animated:(BOOL)animated;
/** 设置自定义右侧按钮 (animated) */
- (void)ddd_setRightButton:(UIButton *)button animated:(BOOL)animated;

/** 设置自定义左侧按钮列表 */
@property (nonatomic, copy) NSArray<UIButton *> *ddd_leftButtons;
/** 设置自定义右侧按钮列表 */
@property (nonatomic, copy) NSArray<UIButton *> *ddd_rightButtons;
/** 设置自定义左侧按钮列表 (animated) */
- (void)ddd_setLeftButtons:(NSArray<UIButton *> *)buttons animated:(BOOL)animated;
/** 设置自定义右侧按钮列表 (animated) */
- (void)ddd_setRightButtons:(NSArray<UIButton *> *)buttons animated:(BOOL)animated;
/** 添加自定义左侧按钮 (animated) */
- (void)ddd_addLeftButton:(UIButton *)button animated:(BOOL)animated;
/** 添加自定义右侧按钮 (animated) */
- (void)ddd_addRightButton:(UIButton *)button animated:(BOOL)animated;

@property (nonatomic, copy) void (^ddd_viewDidTouch)(id view);

@end
