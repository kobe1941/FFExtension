//
//  NSString+FFExtension.m
//  FFExtension
//
//  Created by hufeng on 21/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import "NSString+FFExtension.h"
#import "NSObject+methodSwizzle.h"
#import <objc/runtime.h>
#import "FFExceptionProxy.h"


@implementation NSString (FFExtension)

+ (void)startHook
{
    Class strClass = NSClassFromString(@"NSString");
    [self ff_classSwizzleWithClass:strClass originSelector:@selector(stringWithUTF8String:) swizzleSelector:@selector(ff_stringWithUTF8String:)];
    [self ff_classSwizzleWithClass:strClass originSelector:@selector(stringWithCString:encoding:) swizzleSelector:@selector(ff_stringWithCString:encoding:)];

    Class placeClass = NSClassFromString(@"NSPlaceholderString");
    [self ff_instancenSwizzleWithClass:placeClass originSelector:@selector(initWithUTF8String:) swizzleSelector:@selector(ff_initWithUTF8String:)];
    [self ff_instancenSwizzleWithClass:placeClass originSelector:@selector(initWithCString:encoding:) swizzleSelector:@selector(ff_initWithCString:encoding:)];
    [self ff_instancenSwizzleWithClass:placeClass originSelector:@selector(initWithString:) swizzleSelector:@selector(ff_initWithString:)];
    
    Class placeMutableClass = NSClassFromString(@"NSPlaceholderMutableString");
    [self ff_instancenSwizzleWithClass:placeMutableClass originSelector:@selector(initWithCString:encoding:) swizzleSelector:@selector(ff_initWithCString:encoding:)];
    [self ff_instancenSwizzleWithClass:placeMutableClass originSelector:@selector(initWithUTF8String:) swizzleSelector:@selector(ff_initWithUTF8String:)];
    [self ff_instancenSwizzleWithClass:placeMutableClass originSelector:@selector(initWithString:) swizzleSelector:@selector(ff_initWithString:)];
    
    Class originClass = NSClassFromString(@"__NSCFConstantString");
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(characterAtIndex:) swizzleSelector:@selector(ff_characterAtIndex:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(substringFromIndex:) swizzleSelector:@selector(ff_substringFromIndex:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(substringToIndex:) swizzleSelector:@selector(ff_substringToIndex:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(substringWithRange:) swizzleSelector:@selector(ff_substringWithRange:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(hasPrefix:) swizzleSelector:@selector(ff_hasPrefix:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(hasSuffix:) swizzleSelector:@selector(ff_hasSuffix:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(rangeOfString:options:range:locale:) swizzleSelector:@selector(ff_rangeOfString:options:range:locale:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(rangeOfComposedCharacterSequenceAtIndex:) swizzleSelector:@selector(ff_rangeOfComposedCharacterSequenceAtIndex:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(rangeOfComposedCharacterSequencesForRange:) swizzleSelector:@selector(ff_rangeOfComposedCharacterSequencesForRange:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(stringByAppendingString:) swizzleSelector:@selector(ff_stringByAppendingString:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(stringByReplacingOccurrencesOfString:withString:) swizzleSelector:@selector(ff_stringByReplacingOccurrencesOfString:withString:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(stringByReplacingCharactersInRange:withString:) swizzleSelector:@selector(ff_stringByReplacingCharactersInRange:withString:)];
    
    
    Class mutableClass = NSClassFromString(@"__NSCFString");
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(characterAtIndex:) swizzleSelector:@selector(ff_characterAtIndex:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(substringFromIndex:) swizzleSelector:@selector(ff_substringFromIndex:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(substringToIndex:) swizzleSelector:@selector(ff_substringToIndex:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(substringWithRange:) swizzleSelector:@selector(ff_substringWithRange:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(hasPrefix:) swizzleSelector:@selector(ff_hasPrefix:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(hasSuffix:) swizzleSelector:@selector(ff_hasSuffix:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(rangeOfString:options:range:locale:) swizzleSelector:@selector(ff_rangeOfString:options:range:locale:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(rangeOfComposedCharacterSequenceAtIndex:) swizzleSelector:@selector(ff_rangeOfComposedCharacterSequenceAtIndex:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(rangeOfComposedCharacterSequencesForRange:) swizzleSelector:@selector(ff_rangeOfComposedCharacterSequencesForRange:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(stringByAppendingString:) swizzleSelector:@selector(ff_stringByAppendingString:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(stringByReplacingOccurrencesOfString:withString:) swizzleSelector:@selector(ff_stringByReplacingOccurrencesOfString:withString:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(stringByReplacingCharactersInRange:withString:) swizzleSelector:@selector(ff_stringByReplacingCharactersInRange:withString:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) swizzleSelector:@selector(ff_stringByReplacingOccurrencesOfString:withString:options:range:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(replaceCharactersInRange:withString:) swizzleSelector:@selector(ff_replaceCharactersInRange:withString:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(insertString:atIndex:) swizzleSelector:@selector(ff_insertString:atIndex:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(deleteCharactersInRange:) swizzleSelector:@selector(ff_deleteCharactersInRange:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(appendString:) swizzleSelector:@selector(ff_appendString:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(setString:) swizzleSelector:@selector(ff_setString:)];
    
    
    Class tagClass = NSClassFromString(@"NSTaggedPointerString");
    [self ff_instancenSwizzleWithClass:tagClass originSelector:@selector(characterAtIndex:) swizzleSelector:@selector(ff_characterAtIndex:)];
    [self ff_instancenSwizzleWithClass:tagClass originSelector:@selector(substringWithRange:) swizzleSelector:@selector(ff_substringWithRange:)];
    
    
    Class bigClass = NSClassFromString(@"NSBigMutableString"); ///< 某些系统的键盘会用到这个类
    [self ff_instancenSwizzleWithClass:bigClass originSelector:@selector(characterAtIndex:) swizzleSelector:@selector(ff_characterAtIndex:)];
    [self ff_instancenSwizzleWithClass:bigClass originSelector:@selector(substringWithRange:) swizzleSelector:@selector(ff_substringWithRange:)];
    [self ff_instancenSwizzleWithClass:bigClass originSelector:@selector(replaceCharactersInRange:withString:) swizzleSelector:@selector(ff_replaceCharactersInRange:withString:)];
    // getCharacters:range:
}

+ (instancetype)ff_stringWithUTF8String:(const char *)nullTerminatedCString
{
    if (nullTerminatedCString) {
        return [self ff_stringWithUTF8String:nullTerminatedCString];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (instancetype)ff_initWithUTF8String:(const char *)nullTerminatedCString
{
    if (nullTerminatedCString) {
        return [self ff_initWithUTF8String:nullTerminatedCString];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

+ (instancetype)ff_stringWithCString:(const char *)cString encoding:(NSStringEncoding)enc
{
    if (cString) {
        return [self ff_stringWithCString:cString encoding:enc];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (instancetype)ff_initWithCString:(const char *)nullTerminatedCString encoding:(NSStringEncoding)encoding
{
    if (nullTerminatedCString) {
        return [self ff_initWithCString:nullTerminatedCString encoding:encoding];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (instancetype)ff_initWithString:(NSString *)aString
{
    if (aString) {
        return [self ff_initWithString:aString];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (unichar)ff_characterAtIndex:(NSUInteger)index
{
    if (index < self.length) {
        return [self ff_characterAtIndex:index];
    }
    
    long length = self.length > 0 ? self.length - 1 : self.length;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index %lu is out of bounds 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)index, length];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    
    return 0;
}

- (NSString *)ff_substringFromIndex:(NSUInteger)from
{
    if (from <= self.length) {
        return [self ff_substringFromIndex:from];
    }
    
    long length = self.length > 0 ? self.length - 1 : self.length;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index %lu is out of bounds 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)from, length];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return [self ff_substringFromIndex:self.length];
}

- (NSString *)ff_substringToIndex:(NSUInteger)to
{
    if (to <= self.length) {
        return [self ff_substringToIndex:to];
    }
    
    long length = self.length > 0 ? self.length - 1 : self.length;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index %lu is out of bounds 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)to, length];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return [self ff_substringToIndex:self.length];
}

- (NSString *)ff_substringWithRange:(NSRange)range
{
    if (range.location + range.length <= self.length) {
        return [self ff_substringWithRange:range];
    }
    
    long length = self.length > 0 ? self.length - 1 : self.length;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), length];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (BOOL)ff_hasPrefix:(NSString *)str
{
    if (str) {
        return [self ff_hasPrefix:str];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], str can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return NO;
}

- (BOOL)ff_hasSuffix:(NSString *)str
{
    if (str) {
        return [self ff_hasSuffix:str];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], str can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return NO;
}

- (NSRange)ff_rangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask range:(NSRange)rangeOfReceiverToSearch locale:(nullable NSLocale *)locale
{
    if (searchString && rangeOfReceiverToSearch.location + rangeOfReceiverToSearch.length <= self.length) {
        return [self ff_rangeOfString:searchString options:mask range:rangeOfReceiverToSearch locale:locale];
    }
    
    long length = self.length > 0 ? self.length - 1 : self.length;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], str = %@, range = %@, self.length = %lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), searchString, NSStringFromRange(rangeOfReceiverToSearch), (long)length];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return NSMakeRange(0, 0);
}

- (NSRange)ff_rangeOfComposedCharacterSequenceAtIndex:(NSUInteger)index
{
    if (index < self.length) {
        return [self ff_rangeOfComposedCharacterSequenceAtIndex:index];
    }
    
    long length = self.length > 0 ? self.length - 1 : self.length;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index %lu is out of bounds 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)index, length];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return NSMakeRange(0, 0);
}

- (NSRange)ff_rangeOfComposedCharacterSequencesForRange:(NSRange)range
{
    if (range.location + range.length <= self.length) {
        return [self ff_rangeOfComposedCharacterSequencesForRange:range];
    }
    
    long length = self.length > 0 ? self.length - 1 : self.length;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), length];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return NSMakeRange(0, 0);
}

- (NSString *)ff_stringByAppendingString:(NSString *)aString
{
    if (aString) {
        return [self ff_stringByAppendingString:aString];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], str can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return self;
}

- (NSString *)ff_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement
{
    if (target && replacement) {
        return [self ff_stringByReplacingOccurrencesOfString:target withString:replacement];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], both target str %@ and replace str %@ can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd), target, replacement];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return self;
}

- (NSString *)ff_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement
{
    if (replacement && range.location + range.length <= self.length) {
        return [self ff_stringByReplacingCharactersInRange:range withString:replacement];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ and total length %lu, replace str is %@ ", NSStringFromClass([self class]), NSStringFromSelector(_cmd),NSStringFromRange(range), (long)self.length, replacement];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return self;
}

- (void)ff_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString
{
    if (aString && range.location + range.length <= self.length) {
       return [self ff_replaceCharactersInRange:range withString:aString];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ and total length %lu, str is %@ ", NSStringFromClass([self class]), NSStringFromSelector(_cmd),NSStringFromRange(range), (long)self.length, aString];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_insertString:(NSString *)aString atIndex:(NSUInteger)loc
{
    if (aString && loc <= self.length) {
        return [self ff_insertString:aString atIndex:loc];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index %lu and total length %lu, str is %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), (long)loc, (long)self.length, aString];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_deleteCharactersInRange:(NSRange)range
{
    if (range.location + range.length <= self.length) {
        return [self ff_deleteCharactersInRange:range];
    }
    
    long length = self.length > 0 ? self.length - 1 : self.length;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), length];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_appendString:(NSString *)aString
{
    if (aString) {
        return [self ff_appendString:aString];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], str can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_setString:(NSString *)aString
{
    if (aString) {
        return [self ff_setString:aString];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], str can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (NSString *)ff_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
{
    if (target && replacement) {
        return [self ff_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], target str %@ and replace str %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), target, replacement];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return self;
}

@end
