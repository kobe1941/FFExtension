//
//  FFExceptionProxy.m
//  FFExtension
//
//  Created by hufeng on 26/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import "FFExceptionProxy.h"

@implementation FFExceptionProxy

+ (instancetype)sharedInstance
{
    static FFExceptionProxy *g_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_instance = [[self alloc] init];
    });
    
    return g_instance;
}

- (void)reportExceptionWithMessage:(NSString *)message extraDic:(NSDictionary *)extraDic
{
    NSArray<NSString *> *allThreads = [NSThread callStackSymbols];
    
    NSDictionary *errorDic = @{
                              @"reason" : message?:@"",
                              @"extraDic" : extraDic?:@{},
                              @"callStackSymbols" : allThreads?:@"",
                              };

    if ([self.delegate respondsToSelector:@selector(captureExceptionWithErrorDic:)]) {
        [self.delegate captureExceptionWithErrorDic:errorDic];
    }
}

@end
