//
//  NSArray+FFExtension.m
//  FFExtension
//
//  Created by hufeng on 21/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import "NSArray+FFExtension.h"
#import "NSObject+methodSwizzle.h"

@implementation NSArray (FFExtension)
/*
 NSArray
 __NSArrayI
 __NSArray0
 __NSSingleObjectArrayI
 
 NSMutableArray
 __NSArrayM
 __NSPlaceholderArray
 __NSCFArray
 NSCFArray
 */

///< TODO: 想一下为什么这里的同一个函数，不能被两个类去交换，按理来说，会分别拷贝到不同的类去，是没有关系的，但是实际应用如果不分开实现会崩溃————因为不能动NSArray这个父类，只要不动父类，子类随便玩


+ (void)startHook
{
    SEL getObjectsRangeSEL = @selector(ff_getObjects:range:);
    SEL objectsAtIndexSEL = @selector(ff_objectAtIndex:);
    
    Class arrayClass = NSClassFromString(@"NSArray");
    [self ff_instancenSwizzleWithClass:arrayClass originSelector:@selector(arrayByAddingObject:) swizzleSelector:@selector(ff_arrayByAddingObject:)];
    [self ff_instancenSwizzleWithClass:arrayClass originSelector:@selector(indexOfObject:inRange:) swizzleSelector:@selector(ff_indexOfObject:inRange:)];
    [self ff_instancenSwizzleWithClass:arrayClass originSelector:@selector(getObjects:range:) swizzleSelector:@selector(ff_getObjectsForSuperClass:range:)]; ///< 这里要注意不能把父类的方法给替换了，否则会影响到所有子类
    [self ff_instancenSwizzleWithClass:arrayClass originSelector:@selector(indexOfObjectIdenticalTo:inRange:) swizzleSelector:@selector(ff_indexOfObjectIdenticalTo:inRange:)];
    [self ff_instancenSwizzleWithClass:arrayClass originSelector:@selector(subarrayWithRange:) swizzleSelector:@selector(ff_subarrayWithRange:)];
    [self ff_instancenSwizzleWithClass:arrayClass originSelector:@selector(objectsAtIndexes:) swizzleSelector:@selector(ff_objectsAtIndexes:)];
    [self ff_instancenSwizzleWithClass:arrayClass originSelector:@selector(writeToURL:error:) swizzleSelector:@selector(ff_writeToURL:error:)]; ///< for NSData
    
    
    
    Class originClass = NSClassFromString(@"__NSArrayI");
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(ff_objectAtIndexedSubscript:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(objectAtIndex:) swizzleSelector:objectsAtIndexSEL];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(getObjects:range:) swizzleSelector:getObjectsRangeSEL];
    
    
    
    Class array0Class = NSClassFromString(@"__NSArray0");
    [self ff_instancenSwizzleWithClass:array0Class originSelector:@selector(objectAtIndex:) swizzleSelector:objectsAtIndexSEL];
    
    
    
    Class singleClass = NSClassFromString(@"__NSSingleObjectArrayI");
    [self ff_instancenSwizzleWithClass:singleClass originSelector:@selector(objectAtIndex:) swizzleSelector:objectsAtIndexSEL];
    [self ff_instancenSwizzleWithClass:singleClass originSelector:@selector(getObjects:range:) swizzleSelector:getObjectsRangeSEL];
    

    Class mutableClass = NSClassFromString(@"NSMutableArray");
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(removeObjectsAtIndexes:) swizzleSelector:@selector(ff_removeObjectsAtIndexes:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(removeObject:inRange:) swizzleSelector:@selector(ff_removeObject:inRange:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(removeObjectAtIndex:) swizzleSelector:@selector(ff_removeObjectAtIndex:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(removeObjectIdenticalTo:inRange:) swizzleSelector:@selector(ff_removeObjectIdenticalTo:inRange:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(replaceObjectsInRange:withObjectsFromArray:) swizzleSelector:@selector(ff_replaceObjectsInRange:withObjectsFromArray:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(replaceObjectsInRange:withObjectsFromArray:range:) swizzleSelector:@selector(ff_replaceObjectsInRange:withObjectsFromArray:range:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(insertObjects:atIndexes:) swizzleSelector:@selector(ff_insertObjects:atIndexes:)];
    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(replaceObjectsAtIndexes:withObjects:) swizzleSelector:@selector(ff_replaceObjectsAtIndexes:withObjects:)];
    
    
    
    Class classM = NSClassFromString(@"__NSArrayM");
    [self ff_instancenSwizzleWithClass:classM originSelector:@selector(insertObject:atIndex:) swizzleSelector:@selector(ff_insertObject:atIndex:)];
    [self ff_instancenSwizzleWithClass:classM originSelector:@selector(removeObjectsInRange:) swizzleSelector:@selector(ff_removeObjectsInRange:)];
    [self ff_instancenSwizzleWithClass:classM originSelector:@selector(replaceObjectAtIndex:withObject:) swizzleSelector:@selector(ff_replaceObjectAtIndex:withObject:)];
    [self ff_instancenSwizzleWithClass:classM originSelector:@selector(exchangeObjectAtIndex:withObjectAtIndex:) swizzleSelector:@selector(ff_exchangeObjectAtIndex:withObjectAtIndex:)];
    [self ff_instancenSwizzleWithClass:classM originSelector:@selector(setObject:atIndexedSubscript:) swizzleSelector:@selector(ff_setObject:atIndexedSubscript:)];
    [self ff_instancenSwizzleWithClass:classM originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(ff_objectAtIndexedSubscriptArrayM:)];
    [self ff_instancenSwizzleWithClass:classM originSelector:@selector(objectAtIndex:) swizzleSelector:objectsAtIndexSEL];
    [self ff_instancenSwizzleWithClass:classM originSelector:@selector(getObjects:range:) swizzleSelector:getObjectsRangeSEL];
    [self ff_instancenSwizzleWithClass:classM originSelector:@selector(removeObjectAtIndex:) swizzleSelector:@selector(ff_removeObjectAtIndexArrayM:)];

    
    
    Class placeHolderClass = NSClassFromString(@"__NSPlaceholderArray");
    [self ff_instancenSwizzleWithClass:placeHolderClass originSelector:@selector(initWithObjects:count:) swizzleSelector:@selector(ff_initWithObjects:count:)];
    
    
     
    Class transferClass = NSClassFromString(@"__NSArrayI_Transfer");
    [self ff_instancenSwizzleWithClass:transferClass originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(ff_objectAtIndex:)];
    [self ff_instancenSwizzleWithClass:transferClass originSelector:@selector(getObjects:range:) swizzleSelector:@selector(ff_getObjects:range:)];
    [self ff_instancenSwizzleWithClass:transferClass originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(ff_objectAtIndexedSubscript:)];


    Class frozenClass = NSClassFromString(@"__NSFrozenArrayM");
    [self ff_instancenSwizzleWithClass:frozenClass originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(ff_objectAtIndex:)];
    [self ff_instancenSwizzleWithClass:frozenClass originSelector:@selector(getObjects:range:) swizzleSelector:@selector(ff_getObjects:range:)];
    [self ff_instancenSwizzleWithClass:frozenClass originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(ff_objectAtIndexedSubscript:)];

    
    Class reverseClass = NSClassFromString(@"__NSArrayReversed");
    [self ff_instancenSwizzleWithClass:reverseClass originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(ff_objectAtIndex:)];
    [self ff_instancenSwizzleWithClass:reverseClass originSelector:@selector(subarrayWithRange:) swizzleSelector:@selector(ff_subarrayWithRange:)];
    [self ff_instancenSwizzleWithClass:reverseClass originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(ff_objectAtIndexedSubscript:)];
    
//    这个是系统内部用到的，hook后会崩溃
//    Class classCFArray__ = NSClassFromString(@"__NSCFArray");
//    [self ff_instancenSwizzleWithClass:classCFArray__ originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(ff_objectAtIndex:)];

    // 这个没看到有用到
//    Class classCFArray = NSClassFromString(@"NSCFArray");
//    [self ff_instancenSwizzleWithClass:classCFArray originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(ff_objectAtIndexCFArray:)];
}

- (BOOL)ff_writeToURL:(NSURL *)url error:(NSError * _Nullable __autoreleasing *)error
{
    if (!url) {
        return NO;
    }
    
    return [self ff_writeToURL:url error:error];
}

- (id)ff_objectAtIndexedSubscript:(NSUInteger)index
{
    if (index < self.count) {
        return [self ff_objectAtIndexedSubscript:index];
    }
    
    NSLog(@"数组越界，index = %lu, count = %lu", index, self.count);
    
    return nil;
}

- (id)ff_objectAtIndexedSubscriptArrayM:(NSUInteger)index
{
    if (index < self.count) {
        return [self ff_objectAtIndexedSubscriptArrayM:index];
    }
    
    NSLog(@"数组越界，index = %lu, count = %lu", index, self.count);
    
    return nil;
}

- (id)ff_objectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self ff_objectAtIndex:index];
    }
    
    return nil;
}

/*
- (id)ff_objectAtIndexArrayI:(NSUInteger)index
{
    if (index < self.count) {
        return [self ff_objectAtIndexArrayI:index];
    }
    
    return nil;
}

- (id)ff_objectAtIndexSingleArrayI:(NSUInteger)index
{
    if (index < self.count) {
        return [self ff_objectAtIndexSingleArrayI:index];
    }
    
    return nil;
}

- (id)ff_objectAtIndexArray0:(NSUInteger)index
{
    if (index < self.count) {
        return [self ff_objectAtIndexArray0:index];
    }
    
    return nil;
}

- (id)ff_objectAtIndexArrayM:(NSUInteger)index
{
    if (index < self.count) {
        return [self ff_objectAtIndexArrayM:index];
    }
    
    return nil;
}
*/

/*
- (id)ff_objectAtIndexCFArray__:(NSUInteger)index
{
    if (index < self.count) {
        return [self ff_objectAtIndexCFArray__:index];
    }
    
    return nil;
}

- (id)ff_objectAtIndexCFArray:(NSUInteger)index
{
    if (index < self.count) {
        return [self ff_objectAtIndexCFArray:index];
    }
    
    return nil;
}
*/

- (instancetype)ff_initWithObjects:(const id _Nonnull [_Nullable])objects count:(NSUInteger)cnt
{
    NSUInteger realCount = 0;
    id  _Nonnull __unsafe_unretained realObjects[cnt];
    
    // cnt比数组长度大，objects[i]会读取到其他内存对象比如控制器啊什么的，所以cnt要慎重不能乱写
    for (NSUInteger i = 0; i < cnt; i++) {
        if (objects[i]) {
            realObjects[realCount] = objects[i];
            realCount++;
        } else {
            NSLog(@"出错啦，第 %lu 个值为空", i);
        }
    }
    
    return [self ff_initWithObjects:realObjects count:realCount];
}

- (NSArray *)ff_arrayByAddingObject:(id)anObject
{
    if (anObject) {
        return [self ff_arrayByAddingObject:anObject];
    }
    
    return self;
}

///< 给除了NSArray之外的子类用
- (void)ff_getObjects:(id _Nonnull __unsafe_unretained [_Nonnull])objects range:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self ff_getObjects:objects range:range];
    }
    
    NSLog(@"self.count = %lu. range max location = %lu", self.count, range.location+range.length);
}

///< 给NSArray用
- (void)ff_getObjectsForSuperClass:(id _Nonnull __unsafe_unretained [_Nonnull])objects range:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self ff_getObjectsForSuperClass:objects range:range];
    }
    
    NSLog(@"self.count = %lu. range max location = %lu", self.count, range.location+range.length);
}

/*
- (void)ff_getObjectsArrayI:(id _Nonnull __unsafe_unretained [_Nonnull])objects range:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self ff_getObjectsArrayI:objects range:range];
    }
    
    NSLog(@"self.count = %lu. range max location = %lu", self.count, range.location+range.length);
}

- (void)ff_getObjectsArrayM:(id _Nonnull __unsafe_unretained [_Nonnull])objects range:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self ff_getObjectsArrayM:objects range:range];
    }
    
    NSLog(@"self.count = %lu. range max location = %lu", self.count, range.location+range.length);
}


- (void)ff_getObjectsSingleArrayI:(id _Nonnull __unsafe_unretained [_Nonnull])objects range:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self ff_getObjectsSingleArrayI:objects range:range];
    }
    
    NSLog(@"self.count = %lu. range max location = %lu", self.count, range.location+range.length);
}
*/


- (NSUInteger)ff_indexOfObject:(id)anObject inRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self ff_indexOfObject:anObject inRange:range];
    }
    
    return 0;
}

- (NSUInteger)ff_indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self ff_indexOfObjectIdenticalTo:anObject inRange:range];
    }
    
    return 0;
}

- (NSArray *)ff_subarrayWithRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self ff_subarrayWithRange:range];
    }
    
    return nil;
}

- (NSArray *)ff_objectsAtIndexes:(NSIndexSet *)indexes
{
    if (!indexes) {
        NSLog(@"有问题呀");
        return nil;
    }
    
    __block BOOL flag = NO;
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > self.count) {
            flag = YES;
            *stop = YES;
        }
    }];
    
    if (flag) {
        NSLog(@"有问题呀");
        return nil;
    }
    
    return [self ff_objectsAtIndexes:indexes];
}

- (void)ff_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject && index <= self.count) {
        return [self ff_insertObject:anObject atIndex:index];
    }
    
    
}

- (void)ff_removeObjectsInRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self ff_removeObjectsInRange:range];
    }
    
    NSLog(@"扑街啦");
}

- (void)ff_removeObjectsAtIndexes:(NSIndexSet *)indexes
{
    if (!indexes) {
        NSLog(@"有问题呀");
        return;
    }
    
    __block BOOL flag = NO;
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > self.count) {
            flag = YES;
            *stop = YES;
        }
    }];
    
    if (flag) {
        NSLog(@"有问题呀");
        return;
    }
    
    return [self ff_removeObjectsAtIndexes:indexes];
}

- (void)ff_removeObject:(id)anObject inRange:(NSRange)range
{
    if (anObject && range.location + range.length <= self.count) {
        return [self ff_removeObject:anObject inRange:range];
    }
}

- (void)ff_removeObjectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self ff_removeObjectAtIndex:index];
    }
    
    NSLog(@"index = %lu 越界", index);
}

- (void)ff_removeObjectAtIndexArrayM:(NSUInteger)index
{
    if (index < self.count) {
        return [self ff_removeObjectAtIndexArrayM:index];
    }
    
    NSLog(@"index = %lu 越界", index);
}

- (void)ff_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (anObject && index < self.count) {
        return [self ff_replaceObjectAtIndex:index withObject:anObject];
    }
}

- (void)ff_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2
{
    if (idx1 < self.count && idx2 < self.count) {
        return [self ff_exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
    }
    
}

- (void)ff_removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range
{
    if (anObject && range.location + range.length <= self.count) {
        return [self ff_removeObjectIdenticalTo:anObject inRange:range];
    }
}

- (void)ff_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
    if (obj && idx < self.count) {
        return [self ff_setObject:obj atIndexedSubscript:idx];
    }
    
}

- (void)ff_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray
{
    if (range.location + range.length <= self.count) {
        return [self ff_replaceObjectsInRange:range withObjectsFromArray:otherArray];
    }
}

- (void)ff_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange
{
    if (!otherArray) {
        return;
    }
    
    if (range.location + range.length <= self.count) {
        if (otherRange.location + otherRange.length <= otherArray.count) {
            return [self ff_replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
        }
    }
}

- (void)ff_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes
{
    if (!objects || !indexes) {
        return;
    }
    
    if (objects.count != indexes.count) {
        return;
    }
    

    __block BOOL flag = NO;
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > self.count) {
            flag = YES;
            *stop = YES;
        }
    }];
    
    if (flag) {
        NSLog(@"有问题呀");
        return;
    }
    
    return [self ff_insertObjects:objects atIndexes:indexes];
}

- (void)ff_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects
{
    if (!objects || !indexes) {
        return;
    }
    
    if (objects.count != indexes.count) {
        return;
    }
    
    __block BOOL flag = NO;
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > self.count) {
            flag = YES;
            *stop = YES;
        }
    }];
    
    if (flag) {
        NSLog(@"有问题呀");
        return;
    }
    
    return [self ff_replaceObjectsAtIndexes:indexes withObjects:objects];
}

- (NSUInteger)ff_indexOfObjectIdenticalTo:(id)anObject
{
    
    return 0;
}

@end
