//
//  UIButton+DDD_Category.h
//  FriendTalk
//
//  Created by LYH on 2019/3/20.
//  Copyright © 2019 LYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (DDD_Category)

@property (nonatomic, readonly) CGRect (^ddd_imageTop)(CGFloat spacing);
@property (nonatomic, readonly) CGRect (^ddd_imageLeft)(CGFloat spacing);
@property (nonatomic, readonly) CGRect (^ddd_imageBottom)(CGFloat spacing);
@property (nonatomic, readonly) CGRect (^ddd_imageRight)(CGFloat spacing);

@property (nonatomic, weak) UIFont *ddd_font;

@property (nonatomic, copy) NSString *ddd_normalTitle;
@property (nonatomic, weak) UIColor *ddd_normalTitleColor;
@property (nonatomic, weak) UIColor *ddd_normalTitleShadowColor;
@property (nonatomic, weak) UIImage *ddd_normalImage;
@property (nonatomic, weak) UIImage *ddd_normalBackgroundImage;
@property (nonatomic, weak) NSAttributedString *ddd_normalAttributedTitle;

@property (nonatomic, copy) NSString *ddd_highlightedTitle;
@property (nonatomic, weak) UIColor *ddd_highlightedTitleColor;
@property (nonatomic, weak) UIColor *ddd_highlightedTitleShadowColor;
@property (nonatomic, weak) UIImage *ddd_highlightedImage;
@property (nonatomic, weak) UIImage *ddd_highlightedBackgroundImage;
@property (nonatomic, weak) NSAttributedString *ddd_highlightedAttributedTitle;

@property (nonatomic, copy) NSString *ddd_disabledTitle;
@property (nonatomic, weak) UIColor *ddd_disabledTitleColor;
@property (nonatomic, weak) UIColor *ddd_disabledTitleShadowColor;
@property (nonatomic, weak) UIImage *ddd_disabledImage;
@property (nonatomic, weak) UIImage *ddd_disabledBackgroundImage;
@property (nonatomic, weak) NSAttributedString *ddd_disabledAttributedTitle;

@property (nonatomic, copy) NSString *ddd_selectedTitle;
@property (nonatomic, weak) UIColor *ddd_selectedTitleColor;
@property (nonatomic, weak) UIColor *ddd_selectedTitleShadowColor;
@property (nonatomic, weak) UIImage *ddd_selectedImage;
@property (nonatomic, weak) UIImage *ddd_selectedBackgroundImage;
@property (nonatomic, weak) NSAttributedString *ddd_selectedAttributedTitle;

- (void)ddd_fillsContent;

@end

NS_ASSUME_NONNULL_END
