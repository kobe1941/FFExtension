//
//  FFManager.m
//  FFExtension
//
//  Created by hufeng on 21/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import "FFManager.h"
#import "NSString+FFExtension.h"
#import "NSArray+FFExtension.h"
#import "NSDictionary+FFExtension.h"
#import "NSObject+FFExtension.h"
#import "NSData+FFExtension.h"
#import "NSSet+FFExtension.h"
#import "NSUserDefaults+FFExtension.h"
#import "NSCache+FFExtension.h"

@implementation FFManager

+ (void)startWorkWithOption:(FFHookOption)option
{
    [self startWorkWithOption:option unrecogziedSelectorClassPrefixs:nil needDefault:YES];
}

+ (void)startWorkWithOption:(FFHookOption)option unrecogziedSelectorClassPrefixs:(NSArray<NSString *> *)classPrefixs
{
    [self startWorkWithOption:option unrecogziedSelectorClassPrefixs:classPrefixs needDefault:YES];
}

+ (void)startWorkWithOption:(FFHookOption)option unrecogziedSelectorClassPrefixs:(NSArray<NSString *> *)classPrefixs needDefault:(BOOL)need
{
    if (option == FFHookOptionNone) {
        return;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [NSObject addUnrecognizedSelectorWithClassPrefixs:classPrefixs needDefault:need];
        
        if (option & FFHookOptionUnrecognizedSelector) {
            [NSObject startHook];
        }
        
        if (option & FFHookOptionNSString) {
            [NSString startHook];
        }
        
        if (option & FFHookOptionNSArray) {
            [NSArray startHook];
        }
        
        if (option & FFHookOptionNSDictionary) {
            [NSDictionary startHook];
        }
        
        
        if (option & FFHookOptionNSData) {
            [NSData startHook];
        }
        
        
        if (option & FFHookOptionNSSet) {
            [NSSet startHook];
        }
        
        if (option & FFHookOptionNSUserDefaults) {
            [NSUserDefaults startHook];
        }
        
        if (option & FFHookOptionNSCache) {
            [NSCache startHook];
        }
    });
}


@end
