//
//  NSObject+FFExtension.m
//  FFExtension
//
//  Created by hufeng on 21/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import "NSObject+FFExtension.h"
#import "NSObject+methodSwizzle.h"
#import <objc/runtime.h>
#import "pthread.h"
#import "FFExceptionProxy.h"

static NSMutableArray *prefixs;
static pthread_mutex_t mutex;

@interface ff_target : NSObject
@end

@implementation ff_target

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    class_addMethod([self class],
                    sel,
                    (IMP)testAddMethod,
                    "v@:");
    return YES;
}

void testAddMethod(id self, SEL _cmd) {}

@end

@implementation NSObject (FFExtension)

+ (void)startHook
{
    [NSObject ff_instancenSwizzleWithClass:[NSObject class]
                            originSelector:@selector(forwardingTargetForSelector:)
                           swizzleSelector:@selector(ff_forwardingTargetForSelector:)];
}

+ (void)addUnrecognizedSelectorWithClassPrefixs:(NSArray <NSString *> *)classPrefixs
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        pthread_mutex_init(&mutex, NULL);
        prefixs = [NSMutableArray array];
        
        if (classPrefixs && [classPrefixs isKindOfClass:NSArray.class]) {
            NSSet *set = [NSSet setWithArray:classPrefixs];
            pthread_mutex_lock(&mutex);
            [prefixs addObjectsFromArray:set.allObjects];
            pthread_mutex_unlock(&mutex);
        }
    });
}

+ (void)updateUnrecogziedSelectorClassPrefixs:(NSArray<NSString *> *)classPrefixs
{
    if (classPrefixs && [classPrefixs isKindOfClass:NSArray.class]) {
        NSMutableSet *set = [NSMutableSet setWithArray:classPrefixs];
        pthread_mutex_lock(&mutex);
        [set addObjectsFromArray:prefixs];
        prefixs = [NSMutableArray arrayWithArray:set.allObjects];
        pthread_mutex_unlock(&mutex);
    }
}


- (id)ff_forwardingTargetForSelector:(SEL)aSelector
{
    NSString *className = NSStringFromClass([self class]);
    
    pthread_mutex_lock(&mutex);
    for (NSString *prefix in prefixs) {
        if ([className hasPrefix:prefix]) {
            pthread_mutex_unlock(&mutex);
            NSString *msg = [NSString stringWithFormat:@"capture unrecognized selector sent to instance, -[%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(aSelector)];
            [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
            return [ff_target new];
        }
    }
    
    pthread_mutex_unlock(&mutex);
    return [self ff_forwardingTargetForSelector:aSelector];
}

@end



