//
//  ViewController.m
//  FFExtension
//
//  Created by hufeng on 21/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import "ViewController.h"
#import "SSZTestObject.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self testUnrecognizedSelector];
    [self testNSStringHook];
}

- (void)testNSStringHook
{
    NSString *str = @"nsstring";
    
    [str characterAtIndex:80];
    
    [str hasPrefix:nil];
    [str hasSuffix:nil];
    [str containsString:nil];
    [str rangeOfString:nil];
    [str rangeOfString:nil options:0];
    [str rangeOfComposedCharacterSequenceAtIndex:30];
    [str stringByAppendingString:nil];
    
    NSArray *arr = [str componentsSeparatedByString:nil];
    
    
    NSMutableString *mutableStr = [NSMutableString stringWithString:@"mutableString"];
    
    [mutableStr characterAtIndex:90];
}

- (void)testUnrecognizedSelector
{
    SSZTestObject *test = [SSZTestObject new];
    
    [test performSelector:@selector(efgaegggre:) withObject:@"fwe"];
    
//    NSArray *tempArr = [[self class] findAllOf:[NSString class]];
//    NSLog(@"NSString result = %@", tempArr);
//
//    tempArr = [[self class] findAllOf:[NSNumber class]];
//    NSLog(@"NSNumber result = %@", tempArr);
    
    [@"aewgaw" performSelector:@selector(ioghgohepgegwe)];
    NSMutableString *str = [NSMutableString stringWithString:@"ewfwef"];
    [str performSelector:@selector(dsknseghggpg)];
    
    [str performSelector:@selector(efawf:) withObject:@"fewf"];
    
//    [self performSelector:@selector(gaegsegreg)];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (NSArray *)findAllOf:(Class)defaultClass
{
    int count = objc_getClassList(NULL, 0);
    if (count <= 0) {
        return @[defaultClass];
    }
    
    NSMutableArray *output = @[].mutableCopy;
    Class *classes = (Class *) malloc(sizeof(Class) * count);
    objc_getClassList(classes, count);
    
    for (int i = 0; i < count; ++i) {
        Class tempClass = classes[i];
        // 遍历获取所有非NSObject的父类
        const char *name = class_getName(tempClass);
        NSString *className = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        
        while(tempClass && ![className isEqualToString:@"NSObject"]){
            if (defaultClass == class_getSuperclass(tempClass))
            {
                [output addObject:classes[i]];
                break;
            } else {
                tempClass = class_getSuperclass(tempClass);
            }
        }
    }
    
    free(classes);
    
    return output.copy;
}

@end
