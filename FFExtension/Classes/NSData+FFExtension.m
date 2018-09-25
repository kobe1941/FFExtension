//
//  NSData+FFExtension.m
//  FFExtension
//
//  Created by 胡峰 on 2018/9/24.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import "NSData+FFExtension.h"
#import "NSObject+methodSwizzle.h"



@implementation NSData (FFExtension)

+ (void)startHook
{
    Class dataClass = NSClassFromString(@"__NSCFData");
    [self ff_instancenSwizzleWithClass:dataClass originSelector:@selector(writeToURL:options:error:) swizzleSelector:@selector(ff_writeToURL:options:error:)];
    
    Class mutableClass = NSClassFromString(@"NSConcreteMutableData");
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(writeToURL:options:error:) swizzleSelector:@selector(mutable_writeToURL:options:error:)];
    
}

- (BOOL)ff_writeToURL:(NSURL *)url options:(NSDataWritingOptions)writeOptionsMask error:(NSError * _Nullable __autoreleasing *)errorPtr
{
    if (!url) {
        return NO;
    }
    
    return [self ff_writeToURL:url options:writeOptionsMask error:errorPtr];
}

- (BOOL)mutable_writeToURL:(NSURL *)url options:(NSDataWritingOptions)writeOptionsMask error:(NSError * _Nullable __autoreleasing *)errorPtr
{
    if (!url) {
        return NO;
    }
    
    return [self mutable_writeToURL:url options:writeOptionsMask error:errorPtr];
}

/*
 
 - (NSData *)subdataWithRange:(NSRange)range;
 - (NSRange)rangeOfData:(NSData *)dataToFind options:(NSDataSearchOptions)mask range:(NSRange)searchRange API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
 - (nullable instancetype)initWithBase64EncodedString:(NSString *)base64String options:(NSDataBase64DecodingOptions)options API_AVAILABLE(macos(10.9), ios(7.0), watchos(2.0), tvos(9.0));
 - (nullable instancetype)initWithBase64EncodedData:(NSData *)base64Data options:(NSDataBase64DecodingOptions)options API_AVAILABLE(macos(10.9), ios(7.0), watchos(2.0), tvos(9.0));
 - (void)appendData:(NSData *)other;
 - (void)increaseLengthBy:(NSUInteger)extraLength;
 - (void)replaceBytesInRange:(NSRange)range withBytes:(const void *)bytes;
 - (void)resetBytesInRange:(NSRange)range;
 - (void)setData:(NSData *)data;
 - (void)replaceBytesInRange:(NSRange)range withBytes:(nullable const void *)replacementBytes length:(NSUInteger)replacementLength;
 
*/
 

@end
