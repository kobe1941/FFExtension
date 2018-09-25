//
//  NSUserDefaults+FFExtension.m
//  FFExtension
//
//  Created by hufeng on 25/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import "NSUserDefaults+FFExtension.h"
#import "NSObject+methodSwizzle.h"

@implementation NSUserDefaults (FFExtension)

+ (void)startHook
{
    Class originClass = NSClassFromString(@"NSUserDefaults");
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(objectForKey:) swizzleSelector:@selector(ff_objectForKey:)];
    
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(setObject:forKey:) swizzleSelector:@selector(ff_setObject:forKey:)];
    
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(removeObjectForKey:) swizzleSelector:@selector(ff_removeObjectForKey:)];
    
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(integerForKey:) swizzleSelector:@selector(ff_integerForKey:)];
    
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(boolForKey:) swizzleSelector:@selector(ff_boolForKey:)];
    
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(addSuiteNamed:) swizzleSelector:@selector(ff_addSuiteNamed:)];
    
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(removeSuiteNamed:) swizzleSelector:@selector(ff_removeSuiteNamed:)];
    
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(volatileDomainForName:) swizzleSelector:@selector(ff_volatileDomainForName:)];
    
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(setVolatileDomain:forName:) swizzleSelector:@selector(ff_setVolatileDomain:forName:)];
    
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(removeVolatileDomainForName:) swizzleSelector:@selector(ff_removeVolatileDomainForName:)];

    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(objectIsForcedForKey:inDomain:) swizzleSelector:@selector(ff_objectIsForcedForKey:inDomain:)];
}

- (nullable id)ff_objectForKey:(NSString *)defaultName
{
    if (defaultName) {
        return [self ff_objectForKey:defaultName];
    }
    
    return nil;
}
 
- (void)ff_setObject:(nullable id)value forKey:(NSString *)defaultName
{
    if (defaultName && value) {
        [self ff_setObject:value forKey:defaultName];
    }
}

- (void)ff_removeObjectForKey:(NSString *)defaultName
{
    if (defaultName) {
        [self ff_removeObjectForKey:defaultName];
    }
}

- (NSInteger)ff_integerForKey:(NSString *)defaultName
{
    if (defaultName) {
        return [self ff_integerForKey:defaultName];
    }
    
    return 0;
}

- (BOOL)ff_boolForKey:(NSString *)defaultName
{
    if (defaultName) {
        return [self ff_boolForKey:defaultName];
    }
    
    return NO;
}

- (void)ff_addSuiteNamed:(NSString *)suiteName
{
    if (suiteName) {
        [self ff_addSuiteNamed:suiteName];
    }
}

- (void)ff_removeSuiteNamed:(NSString *)suiteName;
{
    if (suiteName) {
        [self ff_removeSuiteNamed:suiteName];
    }
}

- (NSDictionary<NSString *, id> *)ff_volatileDomainForName:(NSString *)domainName
{
    if (domainName) {
        return [self ff_volatileDomainForName:domainName];
    }
    
    return nil;
}

- (void)ff_setVolatileDomain:(NSDictionary<NSString *, id> *)domain forName:(NSString *)domainName
{
    if (domain && domainName) {
        [self ff_setVolatileDomain:domain forName:domainName];
    }
}

- (void)ff_removeVolatileDomainForName:(NSString *)domainName
{
    if (domainName) {
        [self ff_removeVolatileDomainForName:domainName];
    }
}

- (BOOL)ff_objectIsForcedForKey:(NSString *)key inDomain:(NSString *)domain
{
    if (domain) {
        return [self ff_objectIsForcedForKey:key inDomain:domain];
    }
    
    return NO;
}

@end
