//
//  NSArray+FFExtension.m
//  FFExtension
//
//  Created by hufeng on 21/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import "NSArray+FFExtension.h"
#import "NSObject+methodSwizzle.h"
#import "FFExceptionProxy.h"

@implementation NSArray (FFExtension)

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
    ///< 据说低于11.0交换此方法会导致有键盘显示的地方，此时退到后台会crash? [UIKeyboardLayoutStar release]: message sent to deallocated instance
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
    
    
    /*
     addObject:
     objectAtIndex:
     getObjects:range:
     insertObject:atIndex:
     removeObjectAtIndex:
     countByEnumeratingWithState:objects:count:
     replaceObjectAtIndex:withObject:
     objectAtIndexedSubscript:
     //    这个是系统内部用到的，hook后会崩溃on ios11
    Class classCFArray__ = NSClassFromString(@"__NSCFArray");
    [self ff_instancenSwizzleWithClass:classCFArray__ originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(ff_objectAtIndex:)];
     */
}

- (BOOL)ff_writeToURL:(NSURL *)url error:(NSError * _Nullable __autoreleasing *)error
{
    if (!url) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], url can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
        [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        return NO;
    }
    
    return [self ff_writeToURL:url error:error];
}

- (id)ff_objectAtIndexedSubscript:(NSUInteger)index
{
    if (index < self.count) {
        return [self ff_objectAtIndexedSubscript:index];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index %ld is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)index, count];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (id)ff_objectAtIndexedSubscriptArrayM:(NSUInteger)index
{
    if (index < self.count) {
        return [self ff_objectAtIndexedSubscriptArrayM:index];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index %ld is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)index, count];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (id)ff_objectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self ff_objectAtIndex:index];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index %ld is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)index, count];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (instancetype)ff_initWithObjects:(const id _Nonnull [_Nullable])objects count:(NSUInteger)cnt
{
    NSUInteger realCount = 0;
    id  _Nonnull __unsafe_unretained realObjects[cnt];
    
    // cnt比数组长度大，objects[i]会读取到其他内存对象比如控制器啊什么的，所以cnt要慎重不能乱写
    BOOL capture = NO;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (objects && objects[i]) {
            realObjects[realCount] = objects[i];
            realCount++;
        } else {
            if (!capture) {
                capture = YES;
                
                NSString *msg = [NSString stringWithFormat:@"+[%@ %@], the %lu object is nil in   0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)i, (long)cnt];
                [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
            }
        }
    }
    
    return [self ff_initWithObjects:realObjects count:realCount];
}

- (NSArray *)ff_arrayByAddingObject:(id)anObject
{
    if (anObject) {
        return [self ff_arrayByAddingObject:anObject];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return self;
}

///< 给除了NSArray之外的子类用
- (void)ff_getObjects:(id _Nonnull __unsafe_unretained [_Nonnull])objects range:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self ff_getObjects:objects range:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

///< 给NSArray用
- (void)ff_getObjectsForSuperClass:(id _Nonnull __unsafe_unretained [_Nonnull])objects range:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self ff_getObjectsForSuperClass:objects range:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (NSUInteger)ff_indexOfObject:(id)anObject inRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self ff_indexOfObject:anObject inRange:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return 0;
}

- (NSUInteger)ff_indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self ff_indexOfObjectIdenticalTo:anObject inRange:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return 0;
}

- (NSArray *)ff_subarrayWithRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self ff_subarrayWithRange:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (NSArray *)ff_objectsAtIndexes:(NSIndexSet *)indexes
{
    if (!indexes) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], NSIndexset can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
        [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
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
        return nil;
    }
    
    return [self ff_objectsAtIndexes:indexes];
}

- (void)ff_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject && index <= self.count) {
        return [self ff_insertObject:anObject atIndex:index];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object is %@, index is %lu, array bounds is 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), anObject, (long)index, count];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_removeObjectsInRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self ff_removeObjectsInRange:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_removeObjectsAtIndexes:(NSIndexSet *)indexes
{
    if (!indexes) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], NSIndexset can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
        [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
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
        return;
    }
    
    return [self ff_removeObjectsAtIndexes:indexes];
}

- (void)ff_removeObject:(id)anObject inRange:(NSRange)range
{
    if (anObject && range.location + range.length <= self.count) {
        return [self ff_removeObject:anObject inRange:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object is %@, range is %@, array bounds is 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), anObject, NSStringFromRange(range), count];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_removeObjectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self ff_removeObjectAtIndex:index];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index %lu is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)index, count];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_removeObjectAtIndexArrayM:(NSUInteger)index
{
    if (index < self.count) {
        return [self ff_removeObjectAtIndexArrayM:index];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index %lu is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)index, count];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (anObject && index < self.count) {
        return [self ff_replaceObjectAtIndex:index withObject:anObject];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object is %@, index is %lu, array bounds is 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), anObject, (long)index, count];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2
{
    if (idx1 < self.count && idx2 < self.count) {
        return [self ff_exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index1 is %lu, index2 is %lu, array bounds is 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)idx1, (long)idx2, count];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range
{
    if (anObject && range.location + range.length <= self.count) {
        return [self ff_removeObjectIdenticalTo:anObject inRange:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object is %@, range is %@, array bounds is 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), anObject, NSStringFromRange(range), count];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
     ///< idx can equal self.count here, it will add to the last of array when equal.
    if (obj && idx <= self.count) {
        return [self ff_setObject:obj atIndexedSubscript:idx];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object is %@, index is %lu, array bounds is 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), obj, (long)idx, count];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray
{
    if (range.location + range.length <= self.count) {
        return [self ff_replaceObjectsInRange:range withObjectsFromArray:otherArray];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange
{
    if (!otherArray) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], otherArray can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
        [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        return;
    }
    
    if (range.location + range.length <= self.count) {
        if (otherRange.location + otherRange.length <= otherArray.count) {
            return [self ff_replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
        }
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ or othreRange %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), NSStringFromRange(otherRange), count];
    [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)ff_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes
{
    if (!objects || !indexes) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], objects %@ or indexes %@ can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd), objects, indexes];
        [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        return;
    }
    
    if (objects.count != indexes.count) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], objects count %lu must equal indexes count %lu", NSStringFromClass([self class]), NSStringFromSelector(_cmd), (long)objects.count, (long)indexes.count-1];
        [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        return;
    }
    

    __block BOOL flag = NO;
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > objects.count) {
            flag = YES;
            *stop = YES;
        }
    }];
    
    if (flag) {
        return;
    }
    
    return [self ff_insertObjects:objects atIndexes:indexes];
}

- (void)ff_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects
{
    if (!objects || !indexes) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], objects %@ or indexes %@ can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd), objects, indexes];
        [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        return;
    }
    
    if (objects.count != indexes.count) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], objects count %lu must equal indexes count %lu", NSStringFromClass([self class]), NSStringFromSelector(_cmd), (long)objects.count, (long)indexes.count-1];
        [[FFExceptionProxy sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
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
        return;
    }
    
    return [self ff_replaceObjectsAtIndexes:indexes withObjects:objects];
}

@end
