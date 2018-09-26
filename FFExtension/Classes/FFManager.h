//
//  FFManager.h
//  FFExtension
//
//  Created by hufeng on 21/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, FFHookOption){
    FFHookOptionNone = 0,
    FFHookOptionUnrecognizedSelector = 1 << 0,
    FFHookOptionNSString = 1 << 1,
    FFHookOptionNSArray = 1 << 2,
    FFHookOptionNSDictionary = 1 << 3,
    FFHookOptionNSData = 1 << 4,
    FFHookOptionNSSet = 1 << 5,
    FFHookOptionNSUserDefaults = 1 << 6,
    FFHookOptionNSCache = 1 << 7,
    FFHookOptionAll = 0xFF,
};

@interface FFManager : NSObject



/**
 you must call one of the method below to start work.

 @param option hook的类型
 */
+ (void)startWorkWithOption:(FFHookOption)option;

/**
 call method below by set the last variable need to YES
 */
+ (void)startWorkWithOption:(FFHookOption)option unrecogziedSelectorClassPrefixs:(NSArray<NSString *> *)classPrefixs;

/**
 
 @param option - type of hook
 @param classPrefixs - for your own class, add unrecognized selector sent to instance exception hook, default is nil.
 @param need - set Yes to use defaults classes, default is YES.
 */
+ (void)startWorkWithOption:(FFHookOption)option unrecogziedSelectorClassPrefixs:(NSArray<NSString *> *)classPrefixs needDefault:(BOOL)need;


@end
