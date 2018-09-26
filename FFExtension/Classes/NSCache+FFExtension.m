//
//  NSCache+FFExtension.m
//  FFExtension
//
//  Created by hufeng on 25/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import "NSCache+FFExtension.h"
#import "NSObject+methodSwizzle.h"
#import "FFExceptionProxy.h"

@implementation NSCache (FFExtension)

+ (void)startHook
{
    [self ff_instancenSwizzleWithClass:[NSCache class] originSelector:@selector(setObject:forKey:) swizzleSelector:@selector(ff_setObject:forKey:)];
    [self ff_instancenSwizzleWithClass:[NSCache class] originSelector:@selector(setObject:forKey:cost:) swizzleSelector:@selector(ff_setObject:forKey:cost:)];
}

- (void)ff_setObject:(id)obj forKey:(id)key
{
    if (obj && key) {
        return [self ff_setObject:obj forKey:key];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], key %@ or object %@ can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd), key, obj];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_setObject:(id)obj forKey:(id)key cost:(NSUInteger)g
{
    if (obj && key) {
        return [self ff_setObject:obj forKey:key cost:g];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], key %@ or object %@ can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd), key, obj];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

@end
