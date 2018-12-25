//
//  NSData+FFExtension.m
//  FFExtension
//
//  Created by 胡峰 on 2018/9/24.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import "NSData+FFExtension.h"
#import "NSObject+methodSwizzle.h"
#import "FFExceptionProxy.h"

@implementation NSData (FFExtension)

+ (void)startHook
{
    Class originClass = NSClassFromString(@"NSData");
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(getBytes:range:) swizzleSelector:@selector(super_getBytes:range:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(getBytes:length:) swizzleSelector:@selector(super_getBytes:length:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(subdataWithRange:) swizzleSelector:@selector(super_subdataWithRange:)];
    
    Class dataClass = NSClassFromString(@"__NSCFData");
    [self ff_instancenSwizzleWithClass:dataClass originSelector:@selector(writeToURL:options:error:) swizzleSelector:@selector(ff_writeToURL:options:error:)];
    
    Class zeroClass = NSClassFromString(@"_NSZeroData");
    [self ff_instancenSwizzleWithClass:zeroClass originSelector:@selector(subdataWithRange:) swizzleSelector:@selector(ff_subdataWithRange:)];
    [self ff_instancenSwizzleWithClass:zeroClass originSelector:@selector(rangeOfData:options:range:) swizzleSelector:@selector(ff_rangeOfData:options:range:)];
    [self ff_instancenSwizzleWithClass:zeroClass originSelector:@selector(getBytes:range:) swizzleSelector:@selector(ff_getBytes:range:)];
    
    Class inlineClass = NSClassFromString(@"_NSInlineData");
    [self ff_instancenSwizzleWithClass:inlineClass originSelector:@selector(subdataWithRange:) swizzleSelector:@selector(ff_subdataWithRange:)];
    [self ff_instancenSwizzleWithClass:inlineClass originSelector:@selector(rangeOfData:options:range:) swizzleSelector:@selector(ff_rangeOfData:options:range:)];
    [self ff_instancenSwizzleWithClass:inlineClass originSelector:@selector(getBytes:range:) swizzleSelector:@selector(ff_getBytes:range:)];
    [self ff_instancenSwizzleWithClass:inlineClass originSelector:@selector(getBytes:length:) swizzleSelector:@selector(ff_getBytes:length:)];
    
    Class mutableClass = NSClassFromString(@"NSConcreteMutableData");
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(writeToURL:options:error:) swizzleSelector:@selector(mutable_writeToURL:options:error:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(subdataWithRange:) swizzleSelector:@selector(ff_subdataWithRange:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(rangeOfData:options:range:) swizzleSelector:@selector(ff_rangeOfData:options:range:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(getBytes:range:) swizzleSelector:@selector(ff_getBytes:range:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(appendBytes:length:) swizzleSelector:@selector(ff_appendBytes:length:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(replaceBytesInRange:withBytes:) swizzleSelector:@selector(ff_replaceBytesInRange:withBytes:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(replaceBytesInRange:withBytes:length:) swizzleSelector:@selector(ff_replaceBytesInRange:withBytes:length:)];
    
    Class placeClass = NSClassFromString(@"_NSPlaceholderData");
    [self ff_instancenSwizzleWithClass:placeClass originSelector:@selector(initWithBase64EncodedString:options:) swizzleSelector:@selector(ff_initWithBase64EncodedString:options:)];
    [self ff_instancenSwizzleWithClass:placeClass originSelector:@selector(initWithBase64EncodedData:options:) swizzleSelector:@selector(ff_initWithBase64EncodedData:options:)];

    Class concreteClass = NSClassFromString(@"NSConcreteData");
    [self ff_instancenSwizzleWithClass:concreteClass originSelector:@selector(getBytes:range:) swizzleSelector:@selector(ff_getBytes:range:)];
    [self ff_instancenSwizzleWithClass:concreteClass originSelector:@selector(getBytes:length:) swizzleSelector:@selector(ff_getBytes:length:)];
}

- (BOOL)ff_writeToURL:(NSURL *)url options:(NSDataWritingOptions)writeOptionsMask error:(NSError * _Nullable __autoreleasing *)errorPtr
{
    if (!url) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], url can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
        [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        return NO;
    }
    
    return [self ff_writeToURL:url options:writeOptionsMask error:errorPtr];
}

- (BOOL)mutable_writeToURL:(NSURL *)url options:(NSDataWritingOptions)writeOptionsMask error:(NSError * _Nullable __autoreleasing *)errorPtr
{
    if (!url) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], url can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
        [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        return NO;
    }
    
    return [self mutable_writeToURL:url options:writeOptionsMask error:errorPtr];
}

- (NSData *)super_subdataWithRange:(NSRange)range
{
    if (range.location + range.length <= self.length) {
        return [self super_subdataWithRange:range];
    }
    
    long tempLength = self.length > 0 ? self.length - 1 : self.length;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), (long)tempLength];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    
    return nil;
}

- (NSData *)ff_subdataWithRange:(NSRange)range
{
    if (range.location + range.length <= self.length) {
        return [self ff_subdataWithRange:range];
    }
    
    long tempLength = self.length > 0 ? self.length - 1 : self.length;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), (long)tempLength];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    
    return nil;
}

- (NSRange)ff_rangeOfData:(NSData *)dataToFind options:(NSDataSearchOptions)mask range:(NSRange)searchRange
{
    if (searchRange.location + searchRange.length <= self.length) {
        return [self ff_rangeOfData:dataToFind options:mask range:searchRange];
    }
    
    long tempLength = self.length > 0 ? self.length - 1 : self.length;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(searchRange), (long)tempLength];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    
    return NSMakeRange(0, 0);
}

- (void)super_getBytes:(void *)buffer length:(NSUInteger)length
{
    ///< 这里如果不拦截length的越界，系统会报BAD_ACCESS
    if (buffer && length <= self.length) {
        return [self super_getBytes:buffer length:length];
    }
    
    long tempLength = self.length > 0 ? self.length - 1 : self.length;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], buffer is %p, length %ld is out of bounds 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), buffer, (long)length, (long)tempLength];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)super_getBytes:(void *)buffer range:(NSRange)range
{
    if (buffer && range.location + range.length <= self.length) {
        return [self super_getBytes:buffer range:range];
    }
    
    long tempLength = self.length > 0 ? self.length - 1 : self.length;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], buffer is %p, range %@ is out of bounds 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), buffer, NSStringFromRange(range), tempLength];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

///< 这两个函数不用处理越界，系统可能内部兼容了
- (void)ff_getBytes:(void *)buffer length:(NSUInteger)length
{
    if (buffer) {
        return [self ff_getBytes:buffer length:length];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], buffer can not be NULL", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_getBytes:(void *)buffer range:(NSRange)range
{
    if (buffer) {
        return [self ff_getBytes:buffer range:range]; ///< 某些时候，这个函数会调用上述super_getBytes:range:
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], buffer can not be NULL", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (nullable instancetype)ff_initWithBase64EncodedString:(NSString *)base64String options:(NSDataBase64DecodingOptions)options
{
    if (base64String) {
        return [self ff_initWithBase64EncodedString:base64String options:options];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], base64String can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (nullable instancetype)ff_initWithBase64EncodedData:(NSData *)base64Data options:(NSDataBase64DecodingOptions)options
{
    if (base64Data) {
        return [self ff_initWithBase64EncodedData:base64Data options:options];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], base64Data can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (void)ff_appendBytes:(const void *)bytes length:(NSUInteger)length
{
    if (bytes || length == 0) {
        return [self ff_appendBytes:bytes length:length];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], bytes can not be nil, length = %lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)length];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_replaceBytesInRange:(NSRange)range withBytes:(const void *)bytes
{
    if (bytes && range.location + range.length <= self.length) {
        return [self ff_replaceBytesInRange:range withBytes:bytes];
    }
    
    long tempLength = self.length > 0 ? self.length - 1 : self.length;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], bytes is %p, range %@ is out of bounds 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), bytes, NSStringFromRange(range), tempLength];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_replaceBytesInRange:(NSRange)range withBytes:(nullable const void *)replacementBytes length:(NSUInteger)replacementLength
{
    if (range.location + range.length <= self.length) {
        return [self ff_replaceBytesInRange:range withBytes:replacementBytes length:replacementLength];
    }
    
    long tempLength = self.length > 0 ? self.length - 1 : self.length;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], bytes is %p, range %@ is out of bounds 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), replacementBytes, NSStringFromRange(range), tempLength];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

@end
