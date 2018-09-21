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
    [self ff_instancenSwizzleWithClass:NSClassFromString(@"__NSCFConstantString") originSelector:@selector(characterAtIndex:) swizzleSelector:@selector(ff_characterAtIndex:)];
    
    
    [self ff_instancenSwizzleWithClass:NSClassFromString(@"__NSCFString") originSelector:@selector(characterAtIndex:) swizzleSelector:@selector(ff_characterAtIndex:)];
    
}

- (unichar)ff_characterAtIndex:(NSUInteger)index
{
    if (index < self.length) {
        return [self ff_characterAtIndex:index];
    }
    
    NSLog(@"capture crash, index %lu is out of bounds 0...%lu", index, self.length);
    
    return 0;
}


/*
- (unichar)characterAtIndex:(NSUInteger)index;
- (NSString *)substringFromIndex:(NSUInteger)from;
- (NSString *)substringToIndex:(NSUInteger)to;
- (NSString *)substringWithRange:(NSRange)range;
- (void)getCharacters:(unichar *)buffer range:(NSRange)range;
- (BOOL)isEqualToString:(NSString *)aString;
- (BOOL)hasPrefix:(NSString *)str;
- (BOOL)hasSuffix:(NSString *)str;
- (BOOL)containsString:(NSString *)str;
- (NSRange)rangeOfString:(NSString *)searchString;
- (NSRange)rangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask;
- (NSRange)rangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask range:(NSRange)rangeOfReceiverToSearch;
- (NSRange)rangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask range:(NSRange)rangeOfReceiverToSearch locale:(nullable NSLocale *)locale API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
- (NSRange)rangeOfComposedCharacterSequenceAtIndex:(NSUInteger)index;
- (NSRange)rangeOfComposedCharacterSequencesForRange:(NSRange)range API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
- (NSString *)stringByAppendingString:(NSString *)aString;
- (NSArray<NSString *> *)componentsSeparatedByString:(NSString *)separator;



- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString;
- (void)insertString:(NSString *)aString atIndex:(NSUInteger)loc;
- (void)deleteCharactersInRange:(NSRange)range;
- (void)appendString:(NSString *)aString;
- (void)appendFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
- (void)setString:(NSString *)aString;

*/


@end
