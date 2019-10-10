//
//  UIImage+DDD_Category.m
//  FriendTalk
//
//  Created by yn2019 on 2019/9/27.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "UIImage+DDD_Category.h"

@implementation UIImage (DDD_Category)

+ (UIImage *)ddd_imageWithColor:(UIColor *)color {
    return [self ddd_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)ddd_imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect ddd_rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(ddd_rect.size);
    CGContextRef ddd_context = UIGraphicsGetCurrentContext();
    [color set];
    CGContextFillRect(ddd_context, ddd_rect);
    UIImage *ddd_img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return ddd_img;
}

@end
