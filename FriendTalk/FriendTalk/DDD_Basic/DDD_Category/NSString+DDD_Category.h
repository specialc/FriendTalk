//
//  NSString+DDD_Category.h
//  FriendTalk
//
//  Created by yn2019 on 2019/9/27.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DDD_Category)

@property (nonatomic, strong, readonly) UIFont *ddd_font;
@property (nonatomic, strong, readonly) UIColor *ddd_color;
@property (nonatomic, strong, readonly) UIColor *(^ddd_colorWithAlpha)(CGFloat ddd_alpha);
@property (nonatomic, strong, readonly) UIImage *ddd_image;

@property (nonatomic, readonly) id ddd_fromJSON;
@property (nonatomic, readonly) id ddd_fromBase64;
@property (nonatomic, readonly) NSString *ddd_toBase64;
@property (nonatomic, readonly) NSString *ddd_toMD5;

- (NSString *)ddd_stringByEscapingForURLArgument;
- (NSString *)ddd_stringByUnescapingFromURLArgument;

@end
