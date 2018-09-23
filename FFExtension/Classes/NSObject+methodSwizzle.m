//
//  NSObject+methodSwizzle.m
//  FFExtension
//
//  Created by hufeng on 21/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import "NSObject+methodSwizzle.h"
#import <objc/runtime.h>


@implementation NSObject (methodSwizzle)

+ (void)ff_classSwizzleWithClass:(Class)class originSelector:(SEL)originSelector swizzleSelector:(SEL)swizzleSelector
{
    Class realClass = object_getClass(class);
    Method originMethod = class_getClassMethod(realClass, originSelector);
    Method swizzleMethod = class_getClassMethod(realClass, swizzleSelector);
    if (!originMethod || !swizzleMethod) {
        return;
    }
    
    class_addMethod(realClass,
                    originSelector,
                    method_getImplementation(originMethod),
                    method_getTypeEncoding(originMethod));
    class_addMethod(realClass,
                    swizzleSelector,
                    method_getImplementation(swizzleMethod),
                    method_getTypeEncoding(swizzleMethod));
    
    Method originMethod2 = class_getInstanceMethod(class, originSelector);
    Method swizzleMethod2 = class_getInstanceMethod(class, swizzleSelector);
    method_exchangeImplementations(originMethod2, swizzleMethod2);
}

+ (void)ff_instancenSwizzleWithClass:(Class)class originSelector:(SEL)originSelector swizzleSelector:(SEL)swizzleSelector
{
    Method originMethod = class_getInstanceMethod(class, originSelector);
    Method swizzleMethod = class_getInstanceMethod(class, swizzleSelector);
    if (!originMethod || !swizzleMethod) {
        return;
    }
    
    BOOL success1 = class_addMethod(class,
                    originSelector,
                    method_getImplementation(originMethod),
                    method_getTypeEncoding(originMethod));
    BOOL success2 = class_addMethod(class,
                    swizzleSelector,
                    method_getImplementation(swizzleMethod),
                    method_getTypeEncoding(swizzleMethod));
    
    
    
    ///< 添加完了之后要重新赋值，因为原来的两个method都是父类的。参考自见https://github.com/rentzsch/jrswizzle/blob/semver-1.x/JRSwizzle.m
    Method originMethod2 = class_getInstanceMethod(class, originSelector);
    Method swizzleMethod2 = class_getInstanceMethod(class, swizzleSelector);
    
//    IMP originIMP = method_getImplementation(originMethod2);
//    IMP swizzleIMP = method_getImplementation(swizzleMethod2);
    
    method_exchangeImplementations(originMethod2, swizzleMethod2);
    
//    IMP originIMP2 = method_getImplementation(originMethod2);
//    IMP swizzleIMP2 = method_getImplementation(swizzleMethod2);
    
//    if ([NSStringFromSelector(originSelector) isEqualToString:@"getObjects:range:"]) {
//        NSLog(@"class = %@, originSelector = %@, swizzleSelector = %@, success1 = %d, success2 = %d", class, NSStringFromSelector(originSelector), NSStringFromSelector(swizzleSelector), success1, success2);
//
//        NSLog(@"originIMP = %p, swizzleIMP = %p; originIMP2 = %p, swizzleIMP2 = %p.", originIMP, swizzleIMP, originIMP2, swizzleIMP2);
//
//        NSLog(@"\n\n");
//    }
    
    
    // 第二种方案也OK
    /*
    BOOL success = class_addMethod(class,
                                   originSelector,
                                   method_getImplementation(swizzleMethod),
                                   method_getTypeEncoding(swizzleMethod));
    if (success) {
        class_replaceMethod(class,
                            swizzleSelector,
                            method_getImplementation(originMethod),
                            method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzleMethod);
    }
     */
}


@end
