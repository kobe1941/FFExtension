//
//  NSCache+FFExtension.m
//  FFExtension
//
//  Created by hufeng on 25/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import "NSCache+FFExtension.h"
#import "NSObject+methodSwizzle.h"

@implementation NSCache (FFExtension)

+ (void)startHook
{
    [self ff_instancenSwizzleWithClass:[NSCache class] originSelector:@selector(setObject:forKey:) swizzleSelector:@selector(ff_setObject:forKey:)];
    [self ff_instancenSwizzleWithClass:[NSCache class] originSelector:@selector(setObject:forKey:cost:) swizzleSelector:@selector(ff_setObject:forKey:cost:)];
}

- (void)ff_setObject:(id)obj forKey:(id)key
{
    if (obj && key) {
        [self ff_setObject:obj forKey:key];
    }
}

- (void)ff_setObject:(id)obj forKey:(id)key cost:(NSUInteger)g
{
    if (obj && key) {
        [self ff_setObject:obj forKey:key cost:g];
    }
}

@end
