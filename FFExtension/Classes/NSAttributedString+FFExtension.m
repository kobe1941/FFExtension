//
//  NSAttributedString+FFExtension.m
//  FFExtension
//
//  Created by 胡峰 on 2018/10/13.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import "NSAttributedString+FFExtension.h"
#import "NSObject+methodSwizzle.h"
#import "FFExceptionProxy.h"

@implementation NSAttributedString (FFExtension)

/*
 NSConcreteAttributedString,
 NSMutableAttributedString,
 "_NSCachedAttributedString",
 NSCFAttributedString,
 NSConcreteMutableAttributedString,
 NSConcreteNotifyingMutableAttributedString,
 "__NSCFAttributedString"
 */

+ (void)startHook
{
    
    Class concreteClass = NSClassFromString(@"NSConcreteAttributedString");
    
    [self ff_instancenSwizzleWithClass:concreteClass originSelector:@selector(initWithString:) swizzleSelector:@selector(ff_initWithString:)];
    
//    NSConcreteAttributedString initWithString:
}


- (instancetype)ff_initWithString:(NSString *)str
{
    if (str) {
        return [self ff_initWithString:str];
    }
    
    
    return nil;
}

/*
 

 - (instancetype)initWithString:(NSString *)str attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs;
 - (instancetype)initWithAttributedString:(NSAttributedString *)attrStr;
 
 
- (NSDictionary<NSAttributedStringKey, id> *)attributesAtIndex:(NSUInteger)location effectiveRange:(nullable NSRangePointer)range;
 - (nullable id)attribute:(NSAttributedStringKey)attrName atIndex:(NSUInteger)location effectiveRange:(nullable NSRangePointer)range;
 - (NSAttributedString *)attributedSubstringFromRange:(NSRange)range;
 
 - (NSDictionary<NSAttributedStringKey, id> *)attributesAtIndex:(NSUInteger)location longestEffectiveRange:(nullable NSRangePointer)range inRange:(NSRange)rangeLimit;
 - (nullable id)attribute:(NSAttributedStringKey)attrName atIndex:(NSUInteger)location longestEffectiveRange:(nullable NSRangePointer)range inRange:(NSRange)rangeLimit;
 
 - (BOOL)isEqualToAttributedString:(NSAttributedString *)other;
 

 
 // mutable
 
 - (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str;
 - (void)setAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range;
 - (void)addAttribute:(NSAttributedStringKey)name value:(id)value range:(NSRange)range;
 - (void)addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range;
 - (void)removeAttribute:(NSAttributedStringKey)name range:(NSRange)range;
 
 - (void)replaceCharactersInRange:(NSRange)range withAttributedString:(NSAttributedString *)attrString;
 - (void)insertAttributedString:(NSAttributedString *)attrString atIndex:(NSUInteger)loc;
 - (void)appendAttributedString:(NSAttributedString *)attrString;
 - (void)deleteCharactersInRange:(NSRange)range;
 - (void)setAttributedString:(NSAttributedString *)attrString;
 
 */
 
@end


