//
//  FFExceptionProxy.h
//  FFExtension
//
//  Created by hufeng on 26/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FFExceptionDelegate <NSObject>
- (void)ff_captureExceptionWithErrorDic:(NSDictionary *)errorDic;
@end

@interface FFExceptionProxy : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, weak) id<FFExceptionDelegate> delegate;

- (void)reportExceptionWithMessage:(NSString *)message extraDic:(NSDictionary *)extraDic;

@end
