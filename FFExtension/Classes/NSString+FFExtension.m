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

@implementation NSString (FFExtension)

+ (void)startHook
{
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
