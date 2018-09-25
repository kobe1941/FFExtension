//
//  NSSet+FFExtension.m
//  FFExtension
//
//  Created by hufeng on 25/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import "NSSet+FFExtension.h"

@implementation NSSet (FFExtension)


+ (void)startHook
{
//    Class dataClass = NSClassFromString(@"__NSCFData");
//    [self ff_instancenSwizzleWithClass:dataClass originSelector:@selector(writeToURL:options:error:) swizzleSelector:@selector(ff_writeToURL:options:error:)];
//    
//    Class mutableClass = NSClassFromString(@"NSConcreteMutableData");
//    [self ff_instancenSwizzleWithClass:mutableClass originSelector:@selector(writeToURL:options:error:) swizzleSelector:@selector(mutable_writeToURL:options:error:)];
    
}

@end

/*
 
 __NSPlaceholderSet initWithObjects:count:
 
 
 - (instancetype)initWithObjects:(const ObjectType _Nonnull [_Nullable])objects count:(NSUInteger)cnt NS_DESIGNATED_INITIALIZER;
 - (BOOL)containsObject:(ObjectType)anObject;
 - (BOOL)intersectsSet:(NSSet<ObjectType> *)otherSet;
 - (BOOL)isEqualToSet:(NSSet<ObjectType> *)otherSet;
 - (BOOL)isSubsetOfSet:(NSSet<ObjectType> *)otherSet;
 
 - (NSSet<ObjectType> *)setByAddingObject:(ObjectType)anObject API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
 - (NSSet<ObjectType> *)setByAddingObjectsFromSet:(NSSet<ObjectType> *)other API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
 - (NSSet<ObjectType> *)setByAddingObjectsFromArray:(NSArray<ObjectType> *)other API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
 
 + (instancetype)setWithObject:(ObjectType)object;
 + (instancetype)setWithObjects:(const ObjectType _Nonnull [_Nonnull])objects count:(NSUInteger)cnt;
 + (instancetype)setWithObjects:(ObjectType)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
 + (instancetype)setWithSet:(NSSet<ObjectType> *)set;
 + (instancetype)setWithArray:(NSArray<ObjectType> *)array;
 
 - (instancetype)initWithObjects:(ObjectType)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
 - (instancetype)initWithSet:(NSSet<ObjectType> *)set;
 - (instancetype)initWithSet:(NSSet<ObjectType> *)set copyItems:(BOOL)flag;
 - (instancetype)initWithArray:(NSArray<ObjectType> *)array;
 
 
 ------NSMutableSet---------
 - (void)addObject:(ObjectType)object;
 - (void)removeObject:(ObjectType)object;
 
 - (void)addObjectsFromArray:(NSArray<ObjectType> *)array;
 - (void)intersectSet:(NSSet<ObjectType> *)otherSet;
 - (void)minusSet:(NSSet<ObjectType> *)otherSet;
 - (void)removeAllObjects;
 - (void)unionSet:(NSSet<ObjectType> *)otherSet;
 - (void)setSet:(NSSet<ObjectType> *)otherSet;
 
 
 --------NSCountedSet--------
 - (instancetype)initWithArray:(NSArray<ObjectType> *)array;
 - (instancetype)initWithSet:(NSSet<ObjectType> *)set;
 
 - (NSUInteger)countForObject:(ObjectType)object;
 
 - (NSEnumerator<ObjectType> *)objectEnumerator;
 - (void)addObject:(ObjectType)object;
 - (void)removeObject:(ObjectType)object;
 
 
 -------NSOrderedSet--------
 - (ObjectType)objectAtIndex:(NSUInteger)idx;
 - (instancetype)initWithObjects:(const ObjectType _Nonnull [_Nullable])objects count:(NSUInteger)cnt NS_DESIGNATED_INITIALIZER;
 - (NSArray<ObjectType> *)objectsAtIndexes:(NSIndexSet *)indexes;
 - (BOOL)isEqualToOrderedSet:(NSOrderedSet<ObjectType> *)other;
 
 - (BOOL)containsObject:(ObjectType)object;
 - (BOOL)intersectsOrderedSet:(NSOrderedSet<ObjectType> *)other;
 - (BOOL)intersectsSet:(NSSet<ObjectType> *)set;
 
 - (BOOL)isSubsetOfOrderedSet:(NSOrderedSet<ObjectType> *)other;
 - (BOOL)isSubsetOfSet:(NSSet<ObjectType> *)set;
 
 - (ObjectType)objectAtIndexedSubscript:(NSUInteger)idx API_AVAILABLE(macos(10.8), ios(6.0), watchos(2.0), tvos(9.0));
 
 + (instancetype)orderedSetWithObject:(ObjectType)object;
 + (instancetype)orderedSetWithObjects:(const ObjectType _Nonnull [_Nonnull])objects count:(NSUInteger)cnt;
 + (instancetype)orderedSetWithObjects:(ObjectType)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
 + (instancetype)orderedSetWithOrderedSet:(NSOrderedSet<ObjectType> *)set;
 + (instancetype)orderedSetWithOrderedSet:(NSOrderedSet<ObjectType> *)set range:(NSRange)range copyItems:(BOOL)flag;
 + (instancetype)orderedSetWithArray:(NSArray<ObjectType> *)array;
 + (instancetype)orderedSetWithArray:(NSArray<ObjectType> *)array range:(NSRange)range copyItems:(BOOL)flag;
 + (instancetype)orderedSetWithSet:(NSSet<ObjectType> *)set;
 + (instancetype)orderedSetWithSet:(NSSet<ObjectType> *)set copyItems:(BOOL)flag;
 
 - (instancetype)initWithObject:(ObjectType)object;
 - (instancetype)initWithObjects:(ObjectType)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
 - (instancetype)initWithOrderedSet:(NSOrderedSet<ObjectType> *)set;
 - (instancetype)initWithOrderedSet:(NSOrderedSet<ObjectType> *)set copyItems:(BOOL)flag;
 - (instancetype)initWithOrderedSet:(NSOrderedSet<ObjectType> *)set range:(NSRange)range copyItems:(BOOL)flag;
 - (instancetype)initWithArray:(NSArray<ObjectType> *)array;
 - (instancetype)initWithArray:(NSArray<ObjectType> *)set copyItems:(BOOL)flag;
 - (instancetype)initWithArray:(NSArray<ObjectType> *)set range:(NSRange)range copyItems:(BOOL)flag;
 - (instancetype)initWithSet:(NSSet<ObjectType> *)set;
 - (instancetype)initWithSet:(NSSet<ObjectType> *)set copyItems:(BOOL)flag;
 
 ----------NSMutableOrderedSet-----------
 - (ObjectType)objectAtIndex:(NSUInteger)idx;
 - (void)insertObject:(ObjectType)object atIndex:(NSUInteger)idx;
 - (void)removeObjectAtIndex:(NSUInteger)idx;
 - (void)replaceObjectAtIndex:(NSUInteger)idx withObject:(ObjectType)object;
 - (void)addObject:(ObjectType)object;
 - (void)addObjects:(const ObjectType _Nonnull [_Nullable])objects count:(NSUInteger)count;
 - (void)addObjectsFromArray:(NSArray<ObjectType> *)array;
 
 - (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
 - (void)moveObjectsAtIndexes:(NSIndexSet *)indexes toIndex:(NSUInteger)idx;
 
 - (void)insertObjects:(NSArray<ObjectType> *)objects atIndexes:(NSIndexSet *)indexes;
 
 - (void)setObject:(ObjectType)obj atIndex:(NSUInteger)idx;
 - (void)setObject:(ObjectType)obj atIndexedSubscript:(NSUInteger)idx API_AVAILABLE(macos(10.8), ios(6.0), watchos(2.0), tvos(9.0));
 
 - (void)replaceObjectsInRange:(NSRange)range withObjects:(const ObjectType _Nonnull [_Nullable])objects count:(NSUInteger)count;
 - (void)replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray<ObjectType> *)objects;
 
 - (void)removeObjectsInRange:(NSRange)range;
 - (void)removeObjectsAtIndexes:(NSIndexSet *)indexes;
 - (void)removeObject:(ObjectType)object;
 - (void)removeObjectsInArray:(NSArray<ObjectType> *)array;
 
 - (void)intersectOrderedSet:(NSOrderedSet<ObjectType> *)other;
 - (void)minusOrderedSet:(NSOrderedSet<ObjectType> *)other;
 - (void)unionOrderedSet:(NSOrderedSet<ObjectType> *)other;
 
 - (void)intersectSet:(NSSet<ObjectType> *)other;
 - (void)minusSet:(NSSet<ObjectType> *)other;
 - (void)unionSet:(NSSet<ObjectType> *)other;
 
 */
