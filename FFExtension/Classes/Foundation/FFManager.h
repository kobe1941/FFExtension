//
//  FFManager.h
//  FFExtension
//
//  Created by hufeng on 21/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFCommonMacro.h"

typedef NS_OPTIONS(NSUInteger, FFHookOption){
    FFHookOptionNone = 0,
    FFHookOptionUnrecognizedSelector = 1 << 0,
    FFHookOptionNSString = 1 << 1,
    FFHookOptionNSArray = 1 << 2,
    FFHookOptionNSDictionary = 1 << 3,
//    FFHookOptionNSData = 1 << 4, ///< 会跟高德SDK的加解密函数冲突，暂时无法解决，先去掉
    FFHookOptionNSSet = 1 << 5,
    FFHookOptionNSUserDefaults = 1 << 6,
    FFHookOptionNSCache = 1 << 7,
    FFHookOptionNSAttributedString = 1 << 8,
    FFHookOptionAll = 0xFFFF,
};

typedef void(^FFExceptionBlock)(NSDictionary *exceptionDic);

@interface FFManager : NSObject

+ (instancetype)sharedInstance;


- (void)startWorkWithOption:(FFHookOption)option callBackBlock:(FFExceptionBlock)block;

/**
 you must call one of the method to start work.

 @param option - type of hook
 @param classPrefixs - for your own class(Case Sensitive), add unrecognized selector sent to instance exception hook, default is nil.
 @param block - callBack to upload exception logs to server
 */
- (void)startWorkWithOption:(FFHookOption)option unrecogziedSelectorClassPrefixs:(NSArray<NSString *> *)classPrefixs callBackBlock:(FFExceptionBlock)block;


@end
