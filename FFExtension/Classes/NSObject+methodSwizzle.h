//
//  NSObject+methodSwizzle.h
//  FFExtension
//
//  Created by hufeng on 21/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (methodSwizzle)

+ (void)ff_classSwizzleWithClass:(Class)class originSelector:(SEL)originSelector swizzleSelector:(SEL)swizzleSelector;

+ (void)ff_instancenSwizzleWithClass:(Class)class originSelector:(SEL)originSelector swizzleSelector:(SEL)swizzleSelector;

@end
