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

typedef void(^FFExceptionBlock)(NSDictionary *exceptionDic);

@interface FFManager : NSObject

+ (instancetype)sharedInstance;


- (void)startWorkWithOption:(FFHookOption)option callBackBlock:(FFExceptionBlock)block;

- (void)startWorkWithOption:(FFHookOption)option unrecogziedSelectorClassPrefixs:(NSArray<NSString *> *)classPrefixs callBackBlock:(FFExceptionBlock)block;

/**
 you must call one of the method to start work.

 @param option - type of hook
 @param classPrefixs - for your own class(Case Sensitive), add unrecognized selector sent to instance exception hook, default is nil.
 @param need - set Yes to add default classPrefixs class array, default is YES.
 @param block - callBack to upload exception logs to server
 */
- (void)startWorkWithOption:(FFHookOption)option unrecogziedSelectorClassPrefixs:(NSArray<NSString *> *)classPrefixs needDefault:(BOOL)need callBackBlock:(FFExceptionBlock)block;


@end
