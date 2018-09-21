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

@implementation FFManager

+ (void)startWorkWithOption:(FFHookOption)option
{
    if (option == FFHookOptionNone) {
        return;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (option & FFHookOptionNSString) {
            [NSString startHook];
        }
        
        if (option & FFHookOptionNSArray) {
            [NSArray startHook];
        }
        
        if (option & FFHookOptionNSDictionary) {
            [NSDictionary startHook];
        }
        
        if (option & FFHookOptionUnrecognizedSelector) {
            [NSObject startHook];
        }
    });
}

+ (void)addUnrecognizedSelectorWithClassPrefixs:(NSArray<NSString *> *)classPrefixs
{
    [NSObject addUnrecognizedSelectorWithClassPrefixs:classPrefixs];
}



@end
