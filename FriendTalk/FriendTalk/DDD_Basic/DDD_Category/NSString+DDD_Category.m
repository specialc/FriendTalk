//
//  NSString+DDD_Category.m
//  FriendTalk
//
//  Created by yn2019 on 2019/9/27.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "NSString+DDD_Category.h"
#import <CommonCrypto/CommonCrypto.h>

#define DDD_MAKE_COLOR_HEXA(hex, a) [UIColor colorWithRed:((hex & 0xFF0000) >> 16) / 255.f green:((hex & 0xFF00) >> 8) / 255.f blue:(hex & 0xFF) / 255.f alpha:a]
#define DDD_MAKE_COLOR_STRINGA(s, a) ({ \
    UIColor *ddd_color = nil; \
    NSScanner *ddd_scanner = [NSScanner scannerWithString:[s stringByReplacingOccurrencesOfString:@"#" withString:@""]]; \
    uint32_t ddd_hex = 0; \
    if ([ddd_scanner scanHexInt:&ddd_hex]) { \
        ddd_color = DDD_MAKE_COLOR_HEXA(ddd_hex, a); \
    } \
    ddd_color; \
})

@implementation NSString (DDD_Category)

#pragma mark - 属性

- (UIFont *)ddd_font {
    NSScanner *ddd_scanner = [NSScanner scannerWithString:self];
    CGFloat dd_pointSize = 0;
    if (![ddd_scanner scanDouble:&dd_pointSize]) {
        return nil;
    }
    NSString *dd_string = self.lowercaseString;
    if (@available(iOS 8.2, *)) {
        UIFontWeight fontWeight = UIFontWeightRegular;
        if ([dd_string containsString:@"ultralight"])      fontWeight = UIFontWeightUltraLight;
        else if ([dd_string containsString:@"thin"])       fontWeight = UIFontWeightThin;
        else if ([dd_string containsString:@"light"])      fontWeight = UIFontWeightLight;
        else if ([dd_string containsString:@"medium"])     fontWeight = UIFontWeightMedium;
        else if ([dd_string containsString:@"semibold"])   fontWeight = UIFontWeightSemibold;
        else if ([dd_string containsString:@"bold"])       fontWeight = UIFontWeightBold;
        else if ([dd_string containsString:@"heavy"])      fontWeight = UIFontWeightHeavy;
        else if ([dd_string containsString:@"black"])      fontWeight = UIFontWeightBlack;
        return [UIFont systemFontOfSize:dd_pointSize weight:fontWeight];
    }
    if ([dd_string containsString:@"semibold"] || [dd_string containsString:@"bold"]) {
        return [UIFont boldSystemFontOfSize:dd_pointSize];
    }
    return [UIFont systemFontOfSize:dd_pointSize];
}

- (UIColor *)ddd_color {
    return self.ddd_colorWithAlpha(1);
}

- (UIColor *(^)(CGFloat))ddd_colorWithAlpha {
    return ^UIColor *(CGFloat alpha) {
        return DDD_MAKE_COLOR_STRINGA(self, alpha);
    };
}

- (UIImage *)ddd_image {
    return [UIImage imageNamed:self];
}

- (id)ddd_fromJSON {
    NSError *ddd_error = nil;
    NSData *ddd_data = [self dataUsingEncoding:NSUTF8StringEncoding];
    id ddd_object = [NSJSONSerialization JSONObjectWithData:ddd_data options:kNilOptions error:&ddd_error];
    if (ddd_error) {
        NSLog(@"%@", ddd_error);
    }
    return ddd_object;
}

- (id)ddd_fromBase64 {
    NSData *ddd_data = [[NSData alloc] initWithBase64EncodedString:self options:kNilOptions];
    id ddd_object = [[NSString alloc] initWithData:ddd_data encoding:NSUTF8StringEncoding];
    if (!ddd_object) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:ddd_data];
    }
    return ddd_object;
}

- (NSString *)ddd_toBase64 {
    NSData *ddd_data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [ddd_data base64EncodedStringWithOptions:kNilOptions];
}

- (NSString *)ddd_toMD5 {
    // MD5基于C语言, 先转成C字符串
    const char *ddd_data = self.UTF8String;
    // 创建一个16字节 (128位: MD5加密出来就是128位) 字符串数组, 接收MD5的值
    unsigned char ddd_md[CC_MD5_DIGEST_LENGTH];
    /**
     第一个参数: 要加密的字符串
     第二个参数: 字符串的长度
     第三个参数: 接收结果的数组
     */
    CC_MD5(ddd_data, (CC_LONG)strlen(ddd_data), ddd_md);
    // 格式化MD5字符串数组
    NSMutableString *ddd_result = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ddd_result appendFormat:@"%02x", ddd_md[i]];
    }
    return ddd_result;
}

- (NSString *)ddd_stringByEscapingForURLArgument {
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    CFStringRef ddd_escaped =
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8);
#if defined(__has_feature) && __has_feature(objc_arc)
    return CFBridgingRelease(ddd_escaped);
#else
    return [(NSString *)ddd_escaped autorelease];
#endif
}

- (NSString *)ddd_stringByUnescapingFromURLArgument {
    NSMutableString *ddd_resultString = [NSMutableString stringWithString:self];
    [ddd_resultString replaceOccurrencesOfString:@"+"
                                  withString:@" "
                                     options:NSLiteralSearch
                                       range:NSMakeRange(0, ddd_resultString.length)];
    return [ddd_resultString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
