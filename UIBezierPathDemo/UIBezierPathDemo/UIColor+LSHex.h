//
//  UIColor+LSHex.h
//  AgriculturalTradeAssistant
//
//  Created by ls on 2019/3/20.
//  Copyright © 2019 LiShi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]
#define HEXCOLOR(string) [UIColor colorWithHexString:string]
#define HEXACOLOR(string,a) [UIColor colorWithHexString:string alpha:a]

@interface UIColor (LSHex)

+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
+ (NSDictionary *)getRGBDictionaryByColor:(UIColor *)originColor;
+ (NSString *)hexStringFromColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
