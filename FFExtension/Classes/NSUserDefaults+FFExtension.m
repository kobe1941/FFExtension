//
//  NSUserDefaults+FFExtension.m
//  FFExtension
//
//  Created by hufeng on 25/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import "NSUserDefaults+FFExtension.h"
#import "NSObject+methodSwizzle.h"
#import "FFExceptionProxy.h"

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
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], key can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    
    return nil;
}
 
- (void)ff_setObject:(nullable id)value forKey:(NSString *)defaultName
{
    if (defaultName && value) {
        return [self ff_setObject:value forKey:defaultName];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], key %@ or object %@ can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd), defaultName, value];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_removeObjectForKey:(NSString *)defaultName
{
    if (defaultName) {
        return [self ff_removeObjectForKey:defaultName];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], key can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (NSInteger)ff_integerForKey:(NSString *)defaultName
{
    if (defaultName) {
        return [self ff_integerForKey:defaultName];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], key can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    
    return 0;
}

- (BOOL)ff_boolForKey:(NSString *)defaultName
{
    if (defaultName) {
        return [self ff_boolForKey:defaultName];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], key can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    
    return NO;
}

- (void)ff_addSuiteNamed:(NSString *)suiteName
{
    if (suiteName) {
        return [self ff_addSuiteNamed:suiteName];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], suiteName can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_removeSuiteNamed:(NSString *)suiteName;
{
    if (suiteName) {
        return [self ff_removeSuiteNamed:suiteName];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], suiteName can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (NSDictionary<NSString *, id> *)ff_volatileDomainForName:(NSString *)domainName
{
    if (domainName) {
        return [self ff_volatileDomainForName:domainName];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], domainName can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    
    return nil;
}

- (void)ff_setVolatileDomain:(NSDictionary<NSString *, id> *)domain forName:(NSString *)domainName
{
    if (domain && domainName) {
        return [self ff_setVolatileDomain:domain forName:domainName];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], domain %@ or domainName %@ can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd), domain, domainName];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_removeVolatileDomainForName:(NSString *)domainName
{
    if (domainName) {
        return [self ff_removeVolatileDomainForName:domainName];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], domainName can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (BOOL)ff_objectIsForcedForKey:(NSString *)key inDomain:(NSString *)domain
{
    if (domain) {
        return [self ff_objectIsForcedForKey:key inDomain:domain];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], domain can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    NSLog(@"%@", msg);
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    
    return NO;
}

@end
