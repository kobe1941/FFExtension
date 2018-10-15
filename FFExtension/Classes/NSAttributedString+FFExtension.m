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
#import <UIKit/UIKit.h>

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
    Class originClass = [NSAttributedString class];
    [self ff_classSwizzleWithClass:originClass originSelector:@selector(attributedStringWithAttachment:) swizzleSelector:@selector(ff_attributedStringWithAttachment:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(initWithString:) swizzleSelector:@selector(super_initWithString:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(attribute:atIndex:longestEffectiveRange:inRange:) swizzleSelector:@selector(ff_attribute:atIndex:longestEffectiveRange:inRange:)];
    
    
    Class concreteClass = NSClassFromString(@"NSConcreteAttributedString");
    [self ff_instancenSwizzleWithClass:concreteClass originSelector:@selector(initWithString:) swizzleSelector:@selector(ff_initWithString:)];
    [self ff_instancenSwizzleWithClass:concreteClass originSelector:@selector(attributesAtIndex:effectiveRange:) swizzleSelector:@selector(ff_attributesAtIndex:effectiveRange:)];
    [self ff_instancenSwizzleWithClass:concreteClass originSelector:@selector(attribute:atIndex:effectiveRange:) swizzleSelector:@selector(ff_attribute:atIndex:effectiveRange:)];
    [self ff_instancenSwizzleWithClass:concreteClass originSelector:@selector(attributedSubstringFromRange:) swizzleSelector:@selector(ff_attributedSubstringFromRange:)];
    
    
    Class mutableClass = NSClassFromString(@"NSConcreteMutableAttributedString");
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(replaceCharactersInRange:withString:) swizzleSelector:@selector(ff_replaceCharactersInRange:withString:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(setAttributes:range:) swizzleSelector:@selector(ff_setAttributes:range:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(addAttribute:value:range:) swizzleSelector:@selector(ff_addAttribute:value:range:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(addAttributes:range:) swizzleSelector:@selector(ff_addAttributes:range:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(removeAttribute:range:) swizzleSelector:@selector(ff_removeAttribute:range:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(setAttributedString:) swizzleSelector:@selector(ff_setAttributedString:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(replaceCharactersInRange:withAttributedString:) swizzleSelector:@selector(ff_replaceCharactersInRange:withAttributedString:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(deleteCharactersInRange:) swizzleSelector:@selector(ff_deleteCharactersInRange:)];
}

+ (NSAttributedString *)ff_attributedStringWithAttachment:(NSTextAttachment *)attachment
{
    if (attachment) {
        return [self ff_attributedStringWithAttachment:attachment];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], attachment can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (instancetype)super_initWithString:(NSString *)str
{
    if (str) {
        return [self super_initWithString:str];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], str can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (instancetype)ff_initWithString:(NSString *)str
{
    if (str) {
        return [self ff_initWithString:str];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], str can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (NSDictionary<NSAttributedStringKey, id> *)ff_attributesAtIndex:(NSUInteger)location effectiveRange:(nullable NSRangePointer)range
{
    if (location < self.length && range && (*range).location + (*range).length <= self.length) {
        return [self ff_attributesAtIndex:location effectiveRange:range];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], location %ld, range %@, self.length %ld", NSStringFromClass([self class]), NSStringFromSelector(_cmd), (long)location, NSStringFromRange(*range), self.length];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (nullable id)ff_attribute:(NSAttributedStringKey)attrName atIndex:(NSUInteger)location effectiveRange:(nullable NSRangePointer)range
{
    if (attrName && location < self.length && (*range).location + (*range).length <= self.length) {
        return [self ff_attribute:attrName atIndex:location effectiveRange:range];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], attrName = %@, index %ld, range %@, self.length %ld", NSStringFromClass([self class]), NSStringFromSelector(_cmd), attrName, (long)location, NSStringFromRange(*range), self.length];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

///< attention:这个函数如果不hook直接调用会让Xcode10无法继续执行
- (nullable id)ff_attribute:(NSAttributedStringKey)attrName atIndex:(NSUInteger)location longestEffectiveRange:(nullable NSRangePointer)range inRange:(NSRange)rangeLimit
{
    if (attrName && range && (*range).location + (*range).length <= self.length) {
        return [self ff_attribute:attrName atIndex:location longestEffectiveRange:range inRange:rangeLimit];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], attrName = %@, index %ld, range %@, self.length %ld", NSStringFromClass([self class]), NSStringFromSelector(_cmd), attrName, (long)location, NSStringFromRange(*range), self.length];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (NSAttributedString *)ff_attributedSubstringFromRange:(NSRange)range
{
    if (range.location + range.length <= self.length) {
        return [self ff_attributedSubstringFromRange:range];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@, self.length %ld", NSStringFromClass([self class]), NSStringFromSelector(_cmd), NSStringFromRange(range), self.length];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (BOOL)ff_isEqualToAttributedString:(NSAttributedString *)other
{
    if (other) {
        return [self ff_isEqualToAttributedString:other];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], attributedString can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return NO;
}

///< mutable
- (void)ff_replaceCharactersInRange:(NSRange)range withString:(NSString *)str
{
    if (str && range.location + range.length <= self.length) {
        return [self ff_replaceCharactersInRange:range withString:str];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@, self.length %ld, str is %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), NSStringFromRange(range), (long)self.length, str];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_setAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range
{
    if (range.location + range.length <= self.length) {
        return [self ff_setAttributes:attrs range:range];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@, self.length %ld, ", NSStringFromClass([self class]), NSStringFromSelector(_cmd), NSStringFromRange(range), (long)self.length];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_addAttribute:(NSAttributedStringKey)name value:(id)value range:(NSRange)range
{
    if (name && value && range.location + range.length <= self.length) {
        return [self ff_addAttribute:name value:value range:range];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], name %@， value %@ range %@, self.length %ld, ", NSStringFromClass([self class]), NSStringFromSelector(_cmd), NSStringFromRange(range), name, value,  (long)self.length];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range
{
    if (attrs && range.location + range.length <= self.length) {
        return [self ff_addAttributes:attrs range:range];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], attrs is %@, range %@, self.length %ld, ", NSStringFromClass([self class]), NSStringFromSelector(_cmd), attrs, NSStringFromRange(range), (long)self.length];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_removeAttribute:(NSAttributedStringKey)name range:(NSRange)range
{
    if (name && range.location + range.length <= self.length) {
        return [self ff_removeAttribute:name range:range];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], name is %@, range %@, self.length %ld, ", NSStringFromClass([self class]), NSStringFromSelector(_cmd), name, NSStringFromRange(range), (long)self.length];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_setAttributedString:(NSAttributedString *)attrString
{
    if (attrString && [attrString isKindOfClass:NSAttributedString.class]) {
        return [self ff_setAttributedString:attrString];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], attrString is %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), attrString];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_replaceCharactersInRange:(NSRange)range withAttributedString:(NSAttributedString *)attrString
{
    if (attrString && [attrString isKindOfClass:NSAttributedString.class] && range.location + range.length <= self.length) {
        return [self ff_replaceCharactersInRange:range withAttributedString:attrString];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], attrString is %@, range %@, self.length %ld, ", NSStringFromClass([self class]), NSStringFromSelector(_cmd), attrString, NSStringFromRange(range), (long)self.length];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_deleteCharactersInRange:(NSRange)range
{
    if (range.location + range.length <= self.length) {
        return [self ff_deleteCharactersInRange:range];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@, self.length %ld, ", NSStringFromClass([self class]), NSStringFromSelector(_cmd), NSStringFromRange(range), (long)self.length];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

@end


