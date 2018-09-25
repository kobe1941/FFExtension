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

///< TODO:研究一下NSPlaceholderString，NSTaggedPointerString等其他类是否需要hook
 


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
    
    
    ///< mutable
    Class mutableClass = NSClassFromString(@"__NSCFString");
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(characterAtIndex:) swizzleSelector:@selector(ff_characterAtIndex:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(replaceCharactersInRange:withString:) swizzleSelector:@selector(ff_replaceCharactersInRange:withString:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(insertString:atIndex:) swizzleSelector:@selector(ff_insertString:atIndex:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(deleteCharactersInRange:) swizzleSelector:@selector(ff_deleteCharactersInRange:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(appendString:) swizzleSelector:@selector(ff_appendString:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(substringToIndex:) swizzleSelector:@selector(ff_substringToIndex:)];
    
    /*
     __NSCFString  =>>>>NSString copy 后生成
     2018-09-25 18:04:57.739 FFExtension[7156:1505068] array __NSCFString method name = _newSubstringWithRange:zone:
     2018-09-25 18:04:57.740 FFExtension[7156:1505068] array __NSCFString method name = appendCharacters:length:
     2018-09-25 18:04:57.740 FFExtension[7156:1505068] array __NSCFString method name = getLineStart:end:contentsEnd:forRange:
     2018-09-25 18:04:57.740 FFExtension[7156:1505068] array __NSCFString method name = isEqualToString:
     2018-09-25 18:04:57.742 FFExtension[7156:1505068] array __NSCFString method name = hasPrefix:
     2018-09-25 18:04:57.743 FFExtension[7156:1505068] array __NSCFString method name = substringWithRange:
     2018-09-25 18:04:57.743 FFExtension[7156:1505068] array __NSCFString method name = appendString:
     2018-09-25 18:04:57.743 FFExtension[7156:1505068] array __NSCFString method name = appendFormat:
     2018-09-25 18:04:57.743 FFExtension[7156:1505068] array __NSCFString method name = hasSuffix:
     2018-09-25 18:04:57.743 FFExtension[7156:1505068] array __NSCFString method name = deleteCharactersInRange:
     2018-09-25 18:04:57.743 FFExtension[7156:1505068] array __NSCFString method name = characterAtIndex:
     2018-09-25 18:04:57.744 FFExtension[7156:1505068] array __NSCFString method name = replaceOccurrencesOfString:withString:options:range:
     2018-09-25 18:04:57.745 FFExtension[7156:1505068] array __NSCFString method name = getCString:maxLength:encoding:
     2018-09-25 18:04:57.745 FFExtension[7156:1505068] array __NSCFString method name = replaceCharactersInRange:withString:
     2018-09-25 18:04:57.745 FFExtension[7156:1505068] array __NSCFString method name = setString:
     2018-09-25 18:04:57.745 FFExtension[7156:1505068] array __NSCFString method name = getCharacters:range:
     2018-09-25 18:04:57.745 FFExtension[7156:1505068] array __NSCFString method name = cStringUsingEncoding:
     2018-09-25 18:04:57.745 FFExtension[7156:1505068] array __NSCFString method name = insertString:atIndex:
     */
    
    /*
     NSTaggedPointerString =>>>NSMutableString copy后生成
     
     2018-09-25 18:13:07.191 FFExtension[7173:1508225] array NSTaggedPointerString method name = _getCString:maxLength:encoding:
     2018-09-25 18:13:07.191 FFExtension[7173:1508225] array NSTaggedPointerString method name = _fastCStringContents:
     2018-09-25 18:13:07.191 FFExtension[7173:1508225] array NSTaggedPointerString method name = _fastCharacterContents
     2018-09-25 18:13:07.191 FFExtension[7173:1508225] array NSTaggedPointerString method name = UTF8String
     2018-09-25 18:13:07.191 FFExtension[7173:1508225] array NSTaggedPointerString method name = isEqualToString:
     2018-09-25 18:13:07.192 FFExtension[7173:1508225] array NSTaggedPointerString method name = isEqual:
     2018-09-25 18:13:07.192 FFExtension[7173:1508225] array NSTaggedPointerString method name = retain
     2018-09-25 18:13:07.192 FFExtension[7173:1508225] array NSTaggedPointerString method name = release
     2018-09-25 18:13:07.192 FFExtension[7173:1508225] array NSTaggedPointerString method name = autorelease
     2018-09-25 18:13:07.192 FFExtension[7173:1508225] array NSTaggedPointerString method name = retainCount
     2018-09-25 18:13:07.192 FFExtension[7173:1508225] array NSTaggedPointerString method name = hash
     2018-09-25 18:13:07.196 FFExtension[7173:1508225] array NSTaggedPointerString method name = length
     2018-09-25 18:13:07.196 FFExtension[7173:1508225] array NSTaggedPointerString method name = substringWithRange:
     2018-09-25 18:13:07.196 FFExtension[7173:1508225] array NSTaggedPointerString method name = copyWithZone:
     2018-09-25 18:13:07.196 FFExtension[7173:1508225] array NSTaggedPointerString method name = uppercaseStringWithLocale:
     2018-09-25 18:13:07.196 FFExtension[7173:1508225] array NSTaggedPointerString method name = characterAtIndex:
     2018-09-25 18:13:07.197 FFExtension[7173:1508225] array NSTaggedPointerString method name = compare:options:range:locale:
     2018-09-25 18:13:07.197 FFExtension[7173:1508225] array NSTaggedPointerString method name = getCharacters:range:
     2018-09-25 18:13:07.197 FFExtension[7173:1508225] array NSTaggedPointerString method name = lowercaseStringWithLocale:
     2018-09-25 18:13:07.198 FFExtension[7173:1508225] array NSTaggedPointerString method name = cStringUsingEncoding:
     2018-09-25 18:13:07.198 FFExtension[7173:1508225] array NSTaggedPointerString method name = getBytes:maxLength:usedLength:encoding:options:range:remainingRange:
     */
    
}

+ (instancetype)ff_stringWithUTF8String:(const char *)nullTerminatedCString
{
    if (nullTerminatedCString) {
        return [self ff_stringWithUTF8String:nullTerminatedCString];
    }
    
    return nil;
}

- (instancetype)ff_initWithUTF8String:(const char *)nullTerminatedCString
{
    if (nullTerminatedCString) {
        return [self ff_initWithUTF8String:nullTerminatedCString];
    }
    
    return nil;
}

+ (instancetype)ff_stringWithCString:(const char *)cString encoding:(NSStringEncoding)enc
{
    if (cString) {
        return [self ff_stringWithCString:cString encoding:enc];
    }
    
    return nil;
}

- (instancetype)ff_initWithCString:(const char *)nullTerminatedCString encoding:(NSStringEncoding)encoding
{
    if (nullTerminatedCString) {
        return [self ff_initWithCString:nullTerminatedCString encoding:encoding];
    }
    
    return nil;
}

- (instancetype)ff_initWithString:(NSString *)aString
{
    if (aString) {
        return [self ff_initWithString:aString];
    }
    
    return nil;
}

- (unichar)ff_characterAtIndex:(NSUInteger)index
{
    if (index < self.length) {
        return [self ff_characterAtIndex:index];
    }
    
    NSLog(@"capture crash, index %lu is out of bounds 0...%lu", index, self.length);
    
    return 0;
}



- (NSString *)ff_substringFromIndex:(NSUInteger)from
{
    if (from < self.length) {
        return [self ff_substringFromIndex:from];
    }
    
    return nil;
}

- (NSString *)ff_substringToIndex:(NSUInteger)to
{
    if (to < self.length) {
        return [self ff_substringFromIndex:to];
    }
    
    NSLog(@"字符串index = %lu 越界", to);
    return nil;
}

- (NSString *)ff_substringWithRange:(NSRange)range
{
    if (range.location + range.length < self.length) {
        return [self ff_substringWithRange:range];
    }
    
    return nil;
}

- (BOOL)ff_hasPrefix:(NSString *)str
{
    if (str) {
        return [self ff_hasPrefix:str];
    }
    
    return NO;
}

- (BOOL)ff_hasSuffix:(NSString *)str
{
    if (str) {
        return [self ff_hasSuffix:str];
    }
    
    return NO;
}

- (NSRange)ff_rangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask range:(NSRange)rangeOfReceiverToSearch locale:(nullable NSLocale *)locale
{
    if (searchString && rangeOfReceiverToSearch.location + rangeOfReceiverToSearch.length < self.length) {
        return [self ff_rangeOfString:searchString options:mask range:rangeOfReceiverToSearch locale:locale];
    }
    
    return NSMakeRange(0, 0);
}

- (NSRange)ff_rangeOfComposedCharacterSequenceAtIndex:(NSUInteger)index
{
    if (index < self.length) {
        return [self ff_rangeOfComposedCharacterSequenceAtIndex:index];
    }
    
    return NSMakeRange(0, 0);
}

- (NSRange)ff_rangeOfComposedCharacterSequencesForRange:(NSRange)range API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0))
{
    if (range.location + range.length < self.length) {
        return [self ff_rangeOfComposedCharacterSequencesForRange:range];
    }
    
    return NSMakeRange(0, 0);
}

- (NSString *)ff_stringByAppendingString:(NSString *)aString
{
    if (aString) {
        return [self ff_stringByAppendingString:aString];
    }
    
    return self;
}

- (NSString *)ff_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement
{
    if (target && replacement) {
        return [self ff_stringByReplacingOccurrencesOfString:target withString:replacement];
    }
    
    return self;
}

- (NSString *)ff_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement
{
    if (replacement && range.location + range.length < self.length) {
        return [self ff_stringByReplacingCharactersInRange:range withString:replacement];
    }
    
    return self;
}

- (void)ff_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString
{
    if (aString && range.location + range.length < self.length) {
       return [self ff_replaceCharactersInRange:range withString:aString];
    }
    
}

- (void)ff_insertString:(NSString *)aString atIndex:(NSUInteger)loc
{
    if (aString && loc < self.length) {
        [self ff_insertString:aString atIndex:loc];
    }
    
}

- (void)ff_deleteCharactersInRange:(NSRange)range
{
    if (range.location + range.length < self.length) {
        return [self ff_deleteCharactersInRange:range];
    }
    
}

- (void)ff_appendString:(NSString *)aString
{
    if (aString) {
        return [self ff_appendString:aString];
    }
    
}

- (void)ff_setString:(NSString *)aString
{
    if (aString) {
        return [self ff_setString:aString];
    }
    
    
}

 



@end
