//
//  NSDictionary+FFExtension.m
//  FFExtension
//
//  Created by hufeng on 21/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import "NSDictionary+FFExtension.h"
#import "NSObject+methodSwizzle.h"


@implementation NSDictionary (FFExtension)

+ (void)startHook
{
    Class placeHolderClass = NSClassFromString(@"__NSPlaceholderDictionary");
    [self ff_instancenSwizzleWithClass:placeHolderClass originSelector:@selector(initWithObjects:forKeys:count:) swizzleSelector:@selector(ff_initWithObjects:forKeys:count:)];
    
    Class originClass = NSClassFromString(@"NSDictionary");
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(writeToURL:error:) swizzleSelector:@selector(ff_writeToURL:error:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(initWithObjects:forKeys:) swizzleSelector:@selector(ff_initWithObjects:forKeys:)];
    [self ff_classSwizzleWithClass:originClass originSelector:@selector(sharedKeySetForKeys:) swizzleSelector:@selector(ff_sharedKeySetForKeys:)];
    
    Class mutableClass = NSClassFromString(@"NSMutableDictionary");
    [self ff_classSwizzleWithClass:mutableClass originSelector:@selector(sharedKeySetForKeys:) swizzleSelector:@selector(mutable_sharedKeySetForKeys:)];
    [self ff_classSwizzleWithClass:mutableClass originSelector:@selector(dictionaryWithSharedKeySet:) swizzleSelector:@selector(ff_dictionaryWithSharedKeySet:)];

    Class classM = NSClassFromString(@"__NSDictionaryM");
    [self ff_instancenSwizzleWithClass:classM originSelector:@selector(removeObjectForKey:) swizzleSelector:@selector(ff_removeObjectForKey:)];
    [self ff_instancenSwizzleWithClass:classM originSelector:@selector(setObject:forKey:) swizzleSelector:@selector(ff_setObject:forKey:)];
    [self ff_instancenSwizzleWithClass:classM originSelector:@selector(setObject:forKeyedSubscript:) swizzleSelector:@selector(ff_setObject:forKeyedSubscript:)];
    
}

- (instancetype)ff_initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt
{
    NSUInteger realCount = 0;
    id realObjects[cnt];
    id realKeys[cnt];
    
    for (NSUInteger i = 0; i < cnt; i++) {
        if (keys && objects && keys[i] && objects[i]) {
            realObjects[realCount] = objects[i];
            realKeys[realCount] = keys[i];
            realCount++;
        } else {
            NSLog(@"出错啦，第 %lu 个key 或 value 的值为空", i);
        }
    }
    
    return [self ff_initWithObjects:realObjects forKeys:realKeys count:realCount];
}

- (instancetype)ff_initWithObjects:(NSArray *)objects forKeys:(NSArray<id<NSCopying>> *)keys
{
    if (objects.count == keys.count) {
        return [self ff_initWithObjects:objects forKeys:keys];
    }
    
    return nil;
}

- (BOOL)ff_writeToURL:(NSURL *)url error:(NSError * _Nullable __autoreleasing *)error
{
    if (!url) {
        return NO;
    }
    
    return [self ff_writeToURL:url error:error];
}

+ (id)ff_sharedKeySetForKeys:(NSArray<id<NSCopying>> *)keys
{
    if (!keys) {
        return nil;
    }
    
    return [self ff_sharedKeySetForKeys:keys];
}

+ (id)mutable_sharedKeySetForKeys:(NSArray<id<NSCopying>> *)keys
{
    if (!keys) {
        return nil;
    }
    
    return [self mutable_sharedKeySetForKeys:keys];
}

- (void)ff_removeObjectForKey:(id)aKey
{
    if (aKey) {
        return [self ff_removeObjectForKey:aKey];
    }
}

- (void)ff_setObject:(id)anObject forKey:(id)aKey
{
    if (anObject && aKey) {
        return [self ff_setObject:anObject forKey:aKey];
    }
}

- (void)ff_setObject:(nullable id)obj forKeyedSubscript:(id <NSCopying>)key
{
    if (obj && key) {
        return [self ff_setObject:obj forKeyedSubscript:key];
    }
}

+ (NSMutableDictionary *)ff_dictionaryWithSharedKeySet:(id)keyset
{
    if (keyset) {
        return [self ff_dictionaryWithSharedKeySet:keyset];
    }
    
    return nil;
}

@end

