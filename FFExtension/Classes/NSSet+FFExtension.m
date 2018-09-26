//
//  NSSet+FFExtension.m
//  FFExtension
//
//  Created by hufeng on 25/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import "NSSet+FFExtension.h"
#import "NSObject+methodSwizzle.h"

@implementation NSSet (FFExtension)

+ (void)startHook
{
    Class originClass = NSClassFromString(@"NSSet");
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(setByAddingObject:) swizzleSelector:@selector(ff_setByAddingObject:)];
    
    Class placeClass = NSClassFromString(@"__NSPlaceholderSet");
    [self ff_instancenSwizzleWithClass:placeClass originSelector:@selector(initWithObjects:count:) swizzleSelector:@selector(ff_initWithObjects:count:)];
}

- (instancetype)ff_initWithObjects:(const id _Nonnull [_Nullable])objects count:(NSUInteger)cnt
{
    NSUInteger realCount = 0;
    id  _Nonnull __unsafe_unretained realObjects[cnt];
    
    for (NSUInteger i = 0; i < cnt; i++) {
        if (objects && objects[i]) {
            realObjects[realCount] = objects[i];
            realCount++;
        } else {
            NSLog(@"出错啦，第 %lu 个值为空", i);
        }
    }
    
    return [self ff_initWithObjects:realObjects count:realCount];
}

- (NSSet *)ff_setByAddingObject:(id)anObject
{
    if (anObject) {
        return [self ff_setByAddingObject:anObject];
    }
    
    return nil;
}

@end
