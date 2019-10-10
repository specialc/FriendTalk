//
//  DDD_BaseNavigationBar.m
//  FriendTalk
//
//  Created by LYH on 2018/6/21.
//  Copyright © 2018年 LYH. All rights reserved.
//

#import "DDD_BaseNavigationBar.h"

#define DDD_ITEM_TO_TITLE 5.f
#define DDD_ITEM_TO_ITEM 8.f
#define DDD_ITEM_INTER_SPACING 6.f

@interface DDD_BaseNavigationBar ()
@property (nonatomic, strong) UIView *ddd_backgroundView;
@property (nonatomic, strong) UIImageView *ddd_backgroundImageView;
@property (nonatomic, strong) UIVisualEffectView *ddd_backgroundEffectView;
@property (nonatomic, strong) UIView *ddd_contentView;
@property (nonatomic, strong) UILabel *ddd_titleLabel;
@property (nonatomic, strong) UIImageView *ddd_shadowView;
@end

@implementation DDD_BaseNavigationBar

@synthesize ddd_backButton = _ddd_backButton;
@synthesize ddd_rightDefaultButton = _ddd_rightDefaultButton;

- (void)dealloc {
    [self ddd_removeObservers];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self ddd_addSubviews];
        [self ddd_addObservers];
        // 默认设置
        self.ddd_translucent = NO;
        self.ddd_hidesBackButtonTitle = YES;
        self.ddd_hidesRightDefaultButton = YES;
        self.ddd_backButtonImage = @"ddd_nav_back".ddd_image;
    }
    return self;
}

#pragma mark - UI

- (void)ddd_addSubviews {
    [self addSubview:self.ddd_backgroundView];
    [self.ddd_backgroundView addSubview:self.ddd_backgroundImageView];
    [self.ddd_backgroundView addSubview:self.ddd_backgroundEffectView];
    [self addSubview:self.ddd_contentView];
    [self.ddd_contentView addSubview:self.ddd_titleLabel];
    [self.ddd_contentView addSubview:self.ddd_backButton];
    [self.ddd_contentView addSubview:self.ddd_rightDefaultButton];
    [self addSubview:self.ddd_shadowView];
}

- (UIView *)ddd_backgroundView {
    if (!_ddd_backgroundView) {
        _ddd_backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _ddd_backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _ddd_backgroundView;
}

- (UIImageView *)ddd_backgroundImageView {
    if (!_ddd_backgroundImageView) {
        _ddd_backgroundImageView = [[UIImageView alloc] initWithFrame:self.ddd_backgroundView.bounds];
        _ddd_backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _ddd_backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        _ddd_backgroundImageView.layer.masksToBounds = YES;
    }
    return _ddd_backgroundImageView;
}

- (UIVisualEffectView *)ddd_backgroundEffectView {
    if (!_ddd_backgroundEffectView) {
        _ddd_backgroundEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _ddd_backgroundEffectView.frame = self.ddd_backgroundView.bounds;
        _ddd_backgroundEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _ddd_backgroundEffectView;
}

- (UIView *)ddd_contentView {
    if (!_ddd_contentView) {
        _ddd_contentView = [[UIView alloc] initWithFrame:CGRectMake(0, DDD_STATUS_BAR_HEIGHT, self.ddd_width, self.ddd_height - DDD_STATUS_BAR_HEIGHT)];
        _ddd_contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _ddd_contentView;
}

- (UILabel *)ddd_titleLabel {
    if (!_ddd_titleLabel) {
        _ddd_titleLabel = [[UILabel alloc] init];
        _ddd_titleLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    }
    return _ddd_titleLabel;
}

- (UIButton *)ddd_backButton {
    if (!_ddd_backButton) {
        _ddd_backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _ddd_backButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        [_ddd_backButton addTarget:self action:@selector(ddd_didClickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ddd_backButton;
}

- (UIButton *)ddd_rightDefaultButton {
    if (!_ddd_rightDefaultButton) {
        _ddd_rightDefaultButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _ddd_rightDefaultButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [_ddd_rightDefaultButton addTarget:self action:@selector(ddd_didClickRightDefaultButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ddd_rightDefaultButton;
}

- (UIImageView *)ddd_shadowView {
    if (!_ddd_shadowView) {
        _ddd_shadowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.ddd_height - 0.5, self.ddd_width, 0.5)];
        _ddd_shadowView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        _ddd_shadowView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    }
    return _ddd_shadowView;
}

#pragma mark - TouchEvents

- (void)ddd_didClickBackButton:(UIButton *)sender {
    if (self.ddd_viewDidTouch) {
        self.ddd_viewDidTouch(sender);
    }
}

- (void)ddd_didClickRightDefaultButton:(UIButton *)sender {
    if (self.ddd_viewDidTouch) {
        self.ddd_viewDidTouch(sender);
    }
}

#pragma mark - Private

- (void)ddd_remakeContentSubviewsConstraints {
    [self ddd_remakeBackButtonConstraints];
    [self ddd_remakeRightDefaultButtonConstraints];
    [self ddd_remakeTitleLabelConstraints];
}

- (void)ddd_remakeBackButtonConstraints {
    self.ddd_backButton.superview ? : [self.ddd_contentView addSubview:self.ddd_backButton];
    CGFloat ddd_spacing = self.ddd_backButton.ddd_normalTitle && self.ddd_backButton.ddd_normalImage ? DDD_ITEM_INTER_SPACING : 0;
    CGFloat ddd_width = self.ddd_backButton.ddd_imageLeft(ddd_spacing).size.width;
    self.ddd_backButton.frame = CGRectMake(8, 0, ddd_width, self.ddd_contentView.ddd_height);
}

- (void)ddd_remakeRightDefaultButtonConstraints {
    self.ddd_rightDefaultButton.superview ? : [self.ddd_contentView addSubview:self.ddd_rightDefaultButton];
    CGFloat ddd_width = [self.ddd_rightDefaultButton sizeThatFits:CGSizeZero].width;
    self.ddd_rightDefaultButton.frame = CGRectMake(self.ddd_contentView.ddd_width - 8 - ddd_width, 0, ddd_width, self.ddd_contentView.ddd_height);
}

- (void)ddd_remakeTitleLabelConstraints {
    CGFloat ddd_left = 8;
    CGFloat ddd_right = 8;
    if (self.ddd_leftButtons.count > 0) {
        ddd_left = self.ddd_nearestLeftButton.ddd_right;
    }
    else if (!self.ddd_hidesBackButton) {
        ddd_left = self.ddd_backButton.ddd_right;
    }
    if (self.ddd_rightButtons.count > 0) {
        ddd_right = self.ddd_contentView.ddd_width - self.ddd_nearestRightButton.ddd_left;
    }
    else if (!self.ddd_hidesRightDefaultButton) {
        ddd_right = self.ddd_contentView.ddd_width - self.ddd_rightDefaultButton.ddd_left;
    }
    CGFloat ddd_width = MIN(self.ddd_width - (MAX(ddd_left, ddd_right) + DDD_ITEM_TO_TITLE) * 2, [self.ddd_titleLabel sizeThatFits:CGSizeZero].width);
    self.ddd_titleLabel.frame = CGRectMake((self.ddd_contentView.ddd_width - ddd_width) / 2, 0, ddd_width, self.ddd_contentView.ddd_height);
}

- (void)ddd_updateBackgroundSubviews {
    if (self.ddd_backgroundImage) {
        self.ddd_backgroundImageView.hidden = NO;
        self.ddd_backgroundEffectView.hidden = YES;
    } else {
        self.ddd_backgroundImageView.hidden = YES;
        self.ddd_backgroundEffectView.hidden = !self.ddd_translucent;
    }
}

- (void)ddd_addButton:(UIButton *)button animated:(BOOL)animated isLeft:(BOOL)isLeft {
    if (!button) {
        return;
    }
    
    NSMutableArray *ddd_buttons = [NSMutableArray arrayWithArray:(isLeft ? self.ddd_leftButtons : self.ddd_rightButtons)];
    if (isLeft ? !self.ddd_hidesBackButton : !self.ddd_hidesRightDefaultButton) {
        [ddd_buttons addObject:(isLeft ? self.ddd_backButton : self.ddd_rightDefaultButton)];
    }
    [ddd_buttons addObject:button];
    [self ddd_setButtons:ddd_buttons animated:animated isLeft:isLeft];
}

- (void)ddd_setButtons:(NSArray<UIButton *> *)buttons animated:(BOOL)animated isLeft:(BOOL)isLeft {
    for (UIButton *ddd_button in (isLeft ? self.ddd_leftButtons : self.ddd_rightButtons)) {
        if (![buttons containsObject:ddd_button] && ddd_button != self.ddd_backButton && ddd_button != self.ddd_rightDefaultButton) {
            [ddd_button removeFromSuperview];
        }
    }
    
    isLeft ? (_ddd_leftButtons = buttons.copy) : (_ddd_rightButtons = buttons.copy);
    if (buttons.count > 0) {
        isLeft ? (_ddd_leftButton = buttons.firstObject) : (_ddd_rightButton = buttons.firstObject);
        if (![buttons containsObject:(isLeft ? self.ddd_backButton : self.ddd_rightDefaultButton)]) {
            isLeft ? (self.ddd_backButton.alpha = 0) : (self.ddd_rightDefaultButton.alpha = 0);
        }
        [self ddd_remakeButtonsConstraints:buttons animated:animated isLeft:isLeft];
    } else {
        isLeft ? (_ddd_leftButton = nil) : (_ddd_rightButton = nil);
        isLeft ? (self.ddd_backButton.alpha = 1) : (self.ddd_rightDefaultButton.alpha = 1);
    }
    [self ddd_remakeContentSubviewsConstraints];
}

- (void)ddd_remakeButtonsConstraints:(NSArray<UIButton *> *)buttons animated:(BOOL)animated isLeft:(BOOL)isLeft {
    [buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat ddd_width = obj.width > 0 ? obj.ddd_width : [obj sizeThatFits:CGSizeZero].width;
        CGFloat ddd_left = idx == 0 ? 8 : (buttons[idx - 1].ddd_right + DDD_ITEM_TO_ITEM);
        CGFloat ddd_right = idx == 0 ? (self.ddd_contentView.ddd_width - 8 - ddd_width) : (buttons[idx - 1].ddd_left - DDD_ITEM_TO_ITEM - ddd_width);
        CGFloat ddd_x = isLeft ? ddd_left : ddd_right;
        obj.frame = CGRectMake(ddd_x, 0, ddd_width, self.ddd_contentView.ddd_height);
        obj.autoresizingMask = (isLeft ? UIViewAutoresizingFlexibleRightMargin : UIViewAutoresizingFlexibleLeftMargin) | UIViewAutoresizingFlexibleHeight;
        obj.tintColor = self.ddd_tintColor;
        [self.ddd_contentView addSubview:obj];
    }];
}

#pragma mark - Public

- (void)ddd_setTitleColor:(UIColor *)color animated:(BOOL)animated {
    _ddd_titleColor = color;
    self.ddd_titleLabel.textColor = color;
}

- (void)ddd_setLeftButton:(UIButton *)button animated:(BOOL)animated {
    _ddd_leftButton = button;
    [self ddd_setLeftButtons:button ? @[button] : nil animated:animated];
}

- (void)ddd_setRightButton:(UIButton *)button animated:(BOOL)animated {
    _ddd_rightButton = button;
    [self ddd_setRightButtons:button ? @[button] : nil animated:animated];
}

- (void)ddd_setLeftButtons:(NSArray<UIButton *> *)buttons animated:(BOOL)animated {
    [self ddd_setButtons:buttons animated:animated isLeft:YES];
}

- (void)ddd_setRightButtons:(NSArray<UIButton *> *)buttons animated:(BOOL)animated {
    [self ddd_setButtons:buttons animated:animated isLeft:NO];
}

- (void)ddd_addLeftButton:(UIButton *)button animated:(BOOL)animated {
    [self ddd_addButton:button animated:animated isLeft:YES];
}

- (void)ddd_addRightButton:(UIButton *)button animated:(BOOL)animated {
    [self ddd_addButton:button animated:animated isLeft:NO];
}

#pragma mark -

- (UIButton *)ddd_nearestLeftButton {
    return [self ddd_nearestButton:self.ddd_leftButtons];
}

- (UIButton *)ddd_nearestRightButton {
    return [self ddd_nearestButton:self.ddd_rightButtons];
}

- (UIButton *)ddd_nearestButton:(NSArray *)buttons {
    if (buttons.count > 0) {
        for (NSInteger i = buttons.count; i > 0; i--) {
            UIButton *ddd_button = buttons[i - 1];
            if (!ddd_button.hidden && ddd_button.alpha > 0) {
                return ddd_button;
            }
        }
    }
    return nil;
}

#pragma mark - KVO

- (void)ddd_removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)ddd_addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ddd_didChangeStatusBarOrientation:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
}

- (void)ddd_didChangeStatusBarOrientation:(NSNotification *)notification {
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.ddd_height = DDD_NAVIGATION_BAR_HEIGHT;
        self.ddd_contentView.frame = CGRectMake(0, DDD_STATUS_BAR_HEIGHT, self.ddd_width, self.ddd_height - DDD_STATUS_BAR_HEIGHT);
        if (DDD_IS_IPHONE_X) {
            [self ddd_remakeButtonsConstraints:self.ddd_leftButtons animated:YES isLeft:YES];
            [self ddd_remakeButtonsConstraints:self.ddd_rightButtons animated:YES isLeft:NO];
            [self ddd_remakeContentSubviewsConstraints];
        } else {
            [self ddd_remakeTitleLabelConstraints];
        }
    } completion:nil];
}

#pragma mark - Setter

- (void)setDdd_backgroundImage:(UIImage *)ddd_backgroundImage {
    _ddd_backgroundImage = ddd_backgroundImage;
    self.ddd_backgroundImageView.image = ddd_backgroundImage;
    [self ddd_updateBackgroundSubviews];
}

- (void)setDdd_backButtonImage:(UIImage *)ddd_backButtonImage {
    _ddd_backButtonImage = ddd_backButtonImage;
    self.ddd_backButton.ddd_normalImage = self.ddd_hidesBackButtonImage ? nil : ddd_backButtonImage;
    [self ddd_remakeBackButtonConstraints];
    [self ddd_remakeTitleLabelConstraints];
}

- (void)setDdd_rightDefaultButtonImage:(UIImage *)ddd_rightDefaultButtonImage {
    _ddd_rightDefaultButtonImage = ddd_rightDefaultButtonImage;
    self.ddd_rightDefaultButton.ddd_normalImage = ddd_rightDefaultButtonImage;
    [self ddd_remakeRightDefaultButtonConstraints];
    [self ddd_remakeTitleLabelConstraints];
}

- (void)setDdd_title:(NSString *)ddd_title {
    _ddd_title = ddd_title;
    self.ddd_titleLabel.text = ddd_title;
    [self ddd_remakeTitleLabelConstraints];
}

- (void)setDdd_titleView:(UIView *)ddd_titleView {
    if (self.ddd_titleView) {
        [self.ddd_titleView removeFromSuperview];
    }
    
    _ddd_titleView = ddd_titleView;
    if (ddd_titleView) {
        ddd_titleView.center = self.ddd_titleLabel.center;
        [self.ddd_contentView addSubview:ddd_titleView];
    }
    self.ddd_titleLabel.hidden = ddd_titleView != nil;
}

- (void)setDdd_backButtonTitle:(NSString *)ddd_backButtonTitle {
    _ddd_backButtonTitle = ddd_backButtonTitle;
    self.ddd_backButton.ddd_normalTitle = self.ddd_hidesBackButtonTitle ? nil : ddd_backButtonTitle;
    [self ddd_remakeBackButtonConstraints];
    [self ddd_remakeTitleLabelConstraints];
}

- (void)setDdd_rightDefaultButtonTitle:(NSString *)ddd_rightDefaultButtonTitle {
    _ddd_rightDefaultButtonTitle = ddd_rightDefaultButtonTitle;
    self.ddd_rightDefaultButton.ddd_normalTitle = ddd_rightDefaultButtonTitle;
    [self ddd_remakeRightDefaultButtonConstraints];
    [self ddd_remakeTitleLabelConstraints];
}

- (void)setDdd_titleColor:(UIColor *)ddd_titleColor {
    [self ddd_setTitleColor:ddd_titleColor animated:NO];
}

- (void)setDdd_shadowColor:(UIColor *)ddd_shadowColor {
    _ddd_shadowColor = ddd_shadowColor;
    self.ddd_shadowView.backgroundColor = ddd_shadowColor;
}

- (void)setDdd_translucent:(BOOL)ddd_translucent {
    _ddd_translucent = ddd_translucent;
    [self ddd_updateBackgroundSubviews];
}

- (void)setDdd_hidesBackButton:(BOOL)ddd_hidesBackButton {
    _ddd_hidesBackButton = ddd_hidesBackButton;
    if (!(self.ddd_leftButtons.count > 0 && !ddd_hidesBackButton)) {
        self.ddd_backButton.hidden = ddd_hidesBackButton;
        [self ddd_remakeBackButtonConstraints];
        [self ddd_remakeTitleLabelConstraints];
    }
}

- (void)setDdd_hidesBackButtonTitle:(BOOL)ddd_hidesBackButtonTitle {
    _ddd_hidesBackButtonTitle = ddd_hidesBackButtonTitle;
    self.ddd_backButton.ddd_normalTitle = ddd_hidesBackButtonTitle ? nil : self.ddd_backButtonTitle;
    [self ddd_remakeBackButtonConstraints];
    [self ddd_remakeTitleLabelConstraints];
}

- (void)setDdd_hidesBackButtonImage:(BOOL)ddd_hidesBackButtonImage {
    _ddd_hidesBackButtonImage = ddd_hidesBackButtonImage;
    self.ddd_backButton.ddd_normalImage = ddd_hidesBackButtonImage ? nil : self.ddd_backButtonImage;
    [self ddd_remakeBackButtonConstraints];
    [self ddd_remakeTitleLabelConstraints];
}

- (void)setDdd_hidesRightDefaultButton:(BOOL)ddd_hidesRightDefaultButton {
    _ddd_hidesRightDefaultButton = ddd_hidesRightDefaultButton;
    if (!(self.ddd_rightButtons.count > 0 && !ddd_hidesRightDefaultButton)) {
        self.ddd_rightDefaultButton.hidden = ddd_hidesRightDefaultButton;
        [self ddd_remakeRightDefaultButtonConstraints];
        [self ddd_remakeTitleLabelConstraints];
    }
}

- (void)setDdd_hidesShadowView:(BOOL)ddd_hidesShadowView {
    _ddd_hidesShadowView = ddd_hidesShadowView;
    self.ddd_shadowView.hidden = ddd_hidesShadowView;
}

- (void)setDdd_leftButton:(UIButton *)ddd_leftButton {
    [self ddd_setLeftButton:ddd_leftButton animated:NO];
}

- (void)setDdd_rightButton:(UIButton *)ddd_rightButton {
    [self ddd_setRightButton:ddd_rightButton animated:NO];
}

- (void)setDdd_leftButtons:(NSArray<UIButton *> *)ddd_leftButtons {
    [self ddd_setLeftButtons:ddd_leftButtons animated:NO];
}

- (void)setDdd_rightButtons:(NSArray<UIButton *> *)ddd_rightButtons {
    [self ddd_setRightButtons:ddd_rightButtons animated:NO];
}

- (void)setDdd_backgroundColor:(UIColor *)ddd_backgroundColor {
    _ddd_backgroundColor = ddd_backgroundColor;
    self.backgroundColor = ddd_backgroundColor;
}

- (void)setDdd_tintColor:(UIColor *)ddd_tintColor {
    _ddd_tintColor = ddd_tintColor;
    NSMutableArray *subviews = @[self.ddd_backButton, self.ddd_rightDefaultButton].mutableCopy;
    [subviews addObjectsFromArray:self.ddd_leftButtons];
    [subviews addObjectsFromArray:self.ddd_rightButtons];
    for (UIView *child in subviews) {
        child.tintColor = ddd_tintColor;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
