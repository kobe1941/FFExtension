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

static NSMutableArray *prefixs;


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

+ (void)addUnrecognizedSelectorWithClassPrefixs:(NSArray <NSString *>*)classPrefixs needDefault:(BOOL)need
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 默认的太多了，选取一部分眼熟的类就好，有需要可以手动添加。
        NSArray *defaultArr = @[
                                @"NSNull",
                                @"NSString",
                                @"NSLocalizableString",
                                @"NSConstantString",
                                @"NSTaggedPointerString",
                                @"NSPlaceholderString",
                                @"NSMutableString",
                                @"NSPlaceholderMutableString",
                                @"__NSLocalizedString",
                                @"__NSCFString",
                                @"__NSCFConstantString",
                                @"NSNumber",
                                @"__NSCFNumber",
                                @"__NSCFBoolean",
                                @"NSDecimalNumber",
                                @"_NSConstantNumber",
                                @"NSPlaceholderNumber",
                                ];
        prefixs = [NSMutableArray array];
        if (need) {
            [prefixs addObjectsFromArray:defaultArr];
        }
        
        if (classPrefixs && [classPrefixs isKindOfClass:NSArray.class]) {
           [prefixs addObjectsFromArray:classPrefixs];
        }
    });
}

- (id)ff_forwardingTargetForSelector:(SEL)aSelector
{
    NSString *className = NSStringFromClass([self class]);
    
    for (NSString *prefix in prefixs) {
        if ([className hasPrefix:prefix]) {
            ///< TODO:堆栈回溯和错误日志待处理
            NSLog(@"capture unrecognized selector sent to instance, selector = %@, class = %@", NSStringFromSelector(aSelector), NSStringFromClass([self class]));
            return [ff_target new];
        }
    }
    
    return [self ff_forwardingTargetForSelector:aSelector];
}

@end



