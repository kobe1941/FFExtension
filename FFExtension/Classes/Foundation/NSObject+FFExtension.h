//
//  NSObject+FFExtension.h
//  FFExtension
//
//  Created by hufeng on 21/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FFExtension)

+ (void)startHook;

+ (void)addUnrecognizedSelectorWithClassPrefixs:(NSArray <NSString *> *)classPrefixs;

+ (void)updateUnrecogziedSelectorClassPrefixs:(NSArray<NSString *> *)classPrefixs;

@end
