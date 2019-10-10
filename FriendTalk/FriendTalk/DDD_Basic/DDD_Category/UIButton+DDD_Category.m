//
//  UIButton+DDD_Category.m
//  FriendTalk
//
//  Created by LYH on 2019/3/20.
//  Copyright © 2019 LYH. All rights reserved.
//

#import "UIButton+DDD_Category.h"

typedef NS_ENUM(NSUInteger, DDD_ButtonImagePosition) {
    /** 图片在上 */
    DDD_ButtonImagePositionTop,
    /** 图片在左 */
    DDD_ButtonImagePositionLeft,
    /** 图片在下 */
    DDD_ButtonImagePositionBottom,
    /** 图片在右 */
    DDD_ButtonImagePositionRight,
};

@implementation UIButton (DDD_Category)

- (CGRect (^)(CGFloat))ddd_imageTop {
    return ^CGRect (CGFloat spacing) {
        return self.ddd_imagePosition(DDD_ButtonImagePositionTop, spacing);
    };
}

- (CGRect (^)(CGFloat))ddd_imageLeft {
    return ^CGRect (CGFloat spacing) {
        return self.ddd_imagePosition(DDD_ButtonImagePositionLeft, spacing);
    };
}

- (CGRect (^)(CGFloat))ddd_imageBottom {
    return ^CGRect (CGFloat spacing) {
        return self.ddd_imagePosition(DDD_ButtonImagePositionBottom, spacing);
    };
}

- (CGRect (^)(CGFloat))ddd_imageRight {
    return ^CGRect (CGFloat spacing) {
        return self.ddd_imagePosition(DDD_ButtonImagePositionRight, spacing);
    };
}

- (CGRect (^)(DDD_ButtonImagePosition, CGFloat))ddd_imagePosition {
    return ^CGRect (DDD_ButtonImagePosition position, CGFloat spacing) {
        // 图文大小
        CGSize ddd_imageSize = self.currentImage.size;
        CGSize ddd_titleSize = (self.currentTitle || self.currentAttributedTitle) ? [self.titleLabel sizeThatFits:CGSizeZero] : CGSizeZero;
        
        // 总的宽高
        CGFloat ddd_totalWidth = ddd_imageSize.width + spacing + ddd_titleSize.width;
        CGFloat ddd_totalHeight = ddd_imageSize.height + spacing + ddd_titleSize.height;
        
        // 调整内边距
        switch (position) {
            case DDD_ButtonImagePositionTop:
            case DDD_ButtonImagePositionBottom:
                self.contentEdgeInsets = UIEdgeInsetsMake((ddd_titleSize.height + spacing) / 2,
                                                          -MIN(ddd_imageSize.width, ddd_titleSize.width) / 2,
                                                          (ddd_titleSize.height + spacing) / 2,
                                                          -MIN(ddd_imageSize.width, ddd_titleSize.width) / 2);
                break;
            case DDD_ButtonImagePositionLeft:
            case DDD_ButtonImagePositionRight:
                self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing / 2, 0, spacing / 2);
                break;
                
            default:
                break;
        }
        
        // 调整图文内边距
        switch (position) {
            case DDD_ButtonImagePositionTop:
                self.imageEdgeInsets = UIEdgeInsetsMake(-(ddd_titleSize.height + spacing / 2), 0, spacing / 2, -ddd_titleSize.width);
                self.titleEdgeInsets = UIEdgeInsetsMake(spacing / 2, -ddd_imageSize.width, -(ddd_imageSize.height + spacing / 2), 0);
                return CGRectMake(0, 0, MAX(ddd_imageSize.width, ddd_titleSize.width), ddd_totalHeight);
            case DDD_ButtonImagePositionLeft:
                self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing / 2, 0, spacing / 2);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing / 2, 0, -spacing / 2);
                return CGRectMake(0, 0, ddd_totalWidth, MAX(ddd_imageSize.height, ddd_titleSize.height));
            case DDD_ButtonImagePositionBottom:
                self.imageEdgeInsets = UIEdgeInsetsMake(spacing / 2, 0, -(ddd_titleSize.height + spacing / 2), -ddd_titleSize.width);
                self.titleEdgeInsets = UIEdgeInsetsMake(-(ddd_imageSize.height + spacing / 2), -ddd_imageSize.width, spacing / 2, 0);
                return CGRectMake(0, 0, MAX(ddd_imageSize.width, ddd_titleSize.width), ddd_totalHeight);
            case DDD_ButtonImagePositionRight:
                self.imageEdgeInsets = UIEdgeInsetsMake(0, ddd_titleSize.width + spacing / 2, 0, -(ddd_titleSize.width + spacing / 2));
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -(ddd_imageSize.width + spacing / 2), 0, ddd_imageSize.width + spacing / 2);
                return CGRectMake(0, 0, ddd_totalWidth, MAX(ddd_imageSize.height, ddd_titleSize.height));
                
            default:
                break;
        }
    };
}

- (void)setDdd_font:(UIFont *)ddd_font {
    self.titleLabel.font = ddd_font;
}

- (UIFont *)ddd_font {
    return self.titleLabel.font;
}

#pragma mark - Normal

- (void)setDdd_normalTitle:(NSString *)ddd_normalTitle {
    [self setTitle:ddd_normalTitle forState:UIControlStateNormal];
}

- (NSString *)ddd_normalTitle {
    return [self titleForState:UIControlStateNormal];
}

- (void)setDdd_normalTitleColor:(UIColor *)ddd_normalTitleColor {
    [self setTitleColor:ddd_normalTitleColor forState:UIControlStateNormal];
}

- (UIColor *)ddd_normalTitleColor {
    return [self titleColorForState:UIControlStateNormal];
}

- (void)setDdd_normalTitleShadowColor:(UIColor *)ddd_normalTitleShadowColor {
    [self setTitleShadowColor:ddd_normalTitleShadowColor forState:UIControlStateNormal];
}

- (UIColor *)ddd_normalTitleShadowColor {
    return [self titleShadowColorForState:UIControlStateNormal];
}

- (void)setDdd_normalImage:(UIImage *)ddd_normalImage {
    [self setImage:ddd_normalImage forState:UIControlStateNormal];
}

- (UIImage *)ddd_normalImage {
    return [self imageForState:UIControlStateNormal];
}

- (void)setDdd_normalBackgroundImage:(UIImage *)ddd_normalBackgroundImage {
    [self setBackgroundImage:ddd_normalBackgroundImage forState:UIControlStateNormal];
}

- (UIImage *)ddd_normalBackgroundImage {
    return [self backgroundImageForState:UIControlStateNormal];
}

- (void)setDdd_normalAttributedTitle:(NSAttributedString *)ddd_normalAttributedTitle {
    [self setAttributedTitle:ddd_normalAttributedTitle forState:UIControlStateNormal];
}

- (NSAttributedString *)ddd_normalAttributedTitle {
    return [self attributedTitleForState:UIControlStateNormal];
}

#pragma mark - Highlighted

- (void)setDdd_highlightedTitle:(NSString *)ddd_highlightedTitle {
    [self setTitle:ddd_highlightedTitle forState:UIControlStateHighlighted];
}

- (NSString *)ddd_highlightedTitle {
    return [self titleForState:UIControlStateHighlighted];
}

- (void)setDdd_highlightedTitleColor:(UIColor *)ddd_highlightedTitleColor {
    [self setTitleColor:ddd_highlightedTitleColor forState:UIControlStateHighlighted];
}

- (UIColor *)ddd_highlightedTitleColor {
    return [self titleColorForState:UIControlStateHighlighted];
}

- (void)setDdd_highlightedTitleShadowColor:(UIColor *)ddd_highlightedTitleShadowColor {
    [self setTitleShadowColor:ddd_highlightedTitleShadowColor forState:UIControlStateHighlighted];
}

- (UIColor *)ddd_highlightedTitleShadowColor {
    return [self titleShadowColorForState:UIControlStateHighlighted];
}

- (void)setDdd_highlightedImage:(UIImage *)ddd_highlightedImage {
    [self setImage:ddd_highlightedImage forState:UIControlStateHighlighted];
}

- (UIImage *)ddd_highlightedImage {
    return [self imageForState:UIControlStateHighlighted];
}

- (void)setDdd_highlightedBackgroundImage:(UIImage *)ddd_highlightedBackgroundImage {
    [self setBackgroundImage:ddd_highlightedBackgroundImage forState:UIControlStateHighlighted];
}

- (UIImage *)ddd_highlightedBackgroundImage {
    return [self backgroundImageForState:UIControlStateHighlighted];
}

- (void)setDdd_highlightedAttributedTitle:(NSAttributedString *)ddd_highlightedAttributedTitle {
    [self setAttributedTitle:ddd_highlightedAttributedTitle forState:UIControlStateHighlighted];
}

- (NSAttributedString *)ddd_highlightedAttributedTitle {
    return [self attributedTitleForState:UIControlStateHighlighted];
}

#pragma mark - Disabled

- (void)setDdd_disabledTitle:(NSString *)ddd_disabledTitle {
    [self setTitle:ddd_disabledTitle forState:UIControlStateDisabled];
}

- (NSString *)ddd_disabledTitle {
    return [self titleForState:UIControlStateDisabled];
}

- (void)setDdd_disabledTitleColor:(UIColor *)ddd_disabledTitleColor {
    [self setTitleColor:ddd_disabledTitleColor forState:UIControlStateDisabled];
}

- (UIColor *)ddd_disabledTitleColor {
    return [self titleColorForState:UIControlStateDisabled];
}

- (void)setDdd_disabledTitleShadowColor:(UIColor *)ddd_disabledTitleShadowColor {
    [self setTitleShadowColor:ddd_disabledTitleShadowColor forState:UIControlStateDisabled];
}

- (UIColor *)ddd_disabledTitleShadowColor {
    return [self titleShadowColorForState:UIControlStateDisabled];
}

- (void)setDdd_disabledImage:(UIImage *)ddd_disabledImage {
    [self setImage:ddd_disabledImage forState:UIControlStateDisabled];
}

- (UIImage *)ddd_disabledImage {
    return [self imageForState:UIControlStateDisabled];
}

- (void)setDdd_disabledBackgroundImage:(UIImage *)ddd_disabledBackgroundImage {
    [self setBackgroundImage:ddd_disabledBackgroundImage forState:UIControlStateDisabled];
}

- (UIImage *)ddd_disabledBackgroundImage {
    return [self backgroundImageForState:UIControlStateDisabled];
}

- (void)setDdd_disabledAttributedTitle:(NSAttributedString *)ddd_disabledAttributedTitle {
    [self setAttributedTitle:ddd_disabledAttributedTitle forState:UIControlStateDisabled];
}

- (NSAttributedString *)ddd_disabledAttributedTitle {
    return [self attributedTitleForState:UIControlStateDisabled];
}

#pragma mark - Selected

- (void)setDdd_selectedTitle:(NSString *)ddd_selectedTitle {
    [self setTitle:ddd_selectedTitle forState:UIControlStateSelected];
}

- (NSString *)ddd_selectedTitle {
    return [self titleForState:UIControlStateSelected];
}

- (void)setDdd_selectedTitleColor:(UIColor *)ddd_selectedTitleColor {
    [self setTitleColor:ddd_selectedTitleColor forState:UIControlStateSelected];
}

- (UIColor *)ddd_selectedTitleColor {
    return [self titleColorForState:UIControlStateSelected];
}

- (void)setDdd_selectedTitleShadowColor:(UIColor *)ddd_selectedTitleShadowColor {
    [self setTitleShadowColor:ddd_selectedTitleShadowColor forState:UIControlStateSelected];
}

- (UIColor *)ddd_selectedTitleShadowColor {
    return [self titleShadowColorForState:UIControlStateSelected];
}

- (void)setDdd_selectedImage:(UIImage *)ddd_selectedImage {
    [self setImage:ddd_selectedImage forState:UIControlStateSelected];
}

- (UIImage *)ddd_selectedImage {
    return [self imageForState:UIControlStateSelected];
}

- (void)setDdd_selectedBackgroundImage:(UIImage *)ddd_selectedBackgroundImage {
    [self setBackgroundImage:ddd_selectedBackgroundImage forState:UIControlStateSelected];
}

- (UIImage *)ddd_selectedBackgroundImage {
    return [self backgroundImageForState:UIControlStateSelected];
}

- (void)setDdd_selectedAttributedTitle:(NSAttributedString *)ddd_selectedAttributedTitle {
    [self setAttributedTitle:ddd_selectedAttributedTitle forState:UIControlStateSelected];
}

- (NSAttributedString *)ddd_selectedAttributedTitle {
    return [self attributedTitleForState:UIControlStateSelected];
}

- (void)ddd_fillsContent {
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
}

@end
