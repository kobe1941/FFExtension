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
#import "NSAttributedString+FFExtension.h"
#import "FFExceptionProxy.h"

@interface FFManager ()<FFExceptionDelegate>

@property (nonatomic, copy) FFExceptionBlock callBackBlock;

@end

@implementation FFManager

+ (instancetype)sharedInstance
{
    static FFManager *g_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_instance = [[self alloc] init];
    });
    
    return g_instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [FFExceptionProxy sharedInstance].delegate = self;
    }
    
    return self;
}

- (void)startWorkWithOption:(FFHookOption)option callBackBlock:(FFExceptionBlock)block
{
    [self startWorkWithOption:option unrecogziedSelectorClassPrefixs:nil callBackBlock:block];
}

- (void)startWorkWithOption:(FFHookOption)option unrecogziedSelectorClassPrefixs:(NSArray<NSString *> *)classPrefixs callBackBlock:(FFExceptionBlock)block
{
    if (option == FFHookOptionNone) {
        return;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (block) {
            self.callBackBlock = block;
        }
        
        [NSObject addUnrecognizedSelectorWithClassPrefixs:classPrefixs];
        
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
        
        if (option & FFHookOptionNSAttributedString) {
            [NSAttributedString startHook];
        }
    });
}

#pragma mark - FFExceptionDelegate
- (void)ff_captureExceptionWithErrorDic:(NSDictionary *)errorDic
{
    if (self.callBackBlock) {
        self.callBackBlock(errorDic);
    }
}


@end
