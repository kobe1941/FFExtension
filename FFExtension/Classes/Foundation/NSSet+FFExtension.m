//
//  NSSet+FFExtension.m
//  FFExtension
//
//  Created by hufeng on 25/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import "NSSet+FFExtension.h"
#import "NSObject+methodSwizzle.h"
#import "FFExceptionProxy.h"

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
    
    BOOL capture = NO;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (objects && objects[i]) {
            realObjects[realCount] = objects[i];
            realCount++;
        } else {
            
            if (!capture) {
                capture = YES;
                
                NSString *msg = [NSString stringWithFormat:@"+[%@ %@], the %lu object or objects %p is nil in  0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)i, objects, (long)cnt-1];
                [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
            }
        }
    }
    
    return [self ff_initWithObjects:realObjects count:realCount];
}

- (NSSet *)ff_setByAddingObject:(id)anObject
{
    if (anObject) {
        return [self ff_setByAddingObject:anObject];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    
    return nil;
}

@end
