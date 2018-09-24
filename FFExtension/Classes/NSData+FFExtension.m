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

@end
