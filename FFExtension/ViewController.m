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
//    [self testNSStringHook];
    [self testArrayHook];
    
    
    
    /*测试 ff_objectAtIndex:
    __NSArrayI
    __NSArray0
    __NSSingleObjectArrayI
    __NSArrayM
    */
//    SEL sel = NSSelectorFromString(@"objectAtIndex:"); //
    SEL sel = NSSelectorFromString(@"getObjects:range:");
    Method method = class_getInstanceMethod(NSClassFromString(@"NSArray"), sel);
    NSLog(@"NSArray Method = %p", method);
    
    NSArray *classes = @[@"__NSArrayI",@"__NSArray0",@"__NSSingleObjectArrayI",@"__NSArrayM"];
    for (NSString *className in classes) {
        Class arrClass = NSClassFromString(className);
        
        
        Method originMethod = class_getInstanceMethod(arrClass, sel);
        IMP imp = method_getImplementation(originMethod);
        NSLog(@"className = %@, Method = %p", arrClass, originMethod);
    }
    
    
    
}

- (void)testArrayHook
{
    NSArray *tempArr = [[self class] findAllOf:[NSMutableArray class]];
    NSLog(@"NSMutableArray result = %@", tempArr);
    
     unsigned int count;
    Class classCFArray__ = NSClassFromString(@"__NSCFArray");
        Method *methods = class_copyMethodList(classCFArray__, &count);
    
        for (int i = 0; i < count; i++)
    {
                Method method = methods[i];
        
                SEL selector = method_getName(method);
        
                NSString *name = NSStringFromSelector(selector);
        NSLog(@"array %@ method name = %@", [classCFArray__ class], name);
    }
    
    
    NSArray *array = @[@"1,", @"2"];
    array[3];
    [array objectAtIndex:4];
    [array arrayByAddingObject:nil];
    [array containsObject:nil];
    
    array = [[NSArray alloc] initWithObjects:@"1", @"2", nil, nil];
    array = [[NSArray alloc] initWithArray:nil];
    
    array[3];
    [array objectAtIndex:4];
    
    [array arrayByAddingObject:nil];
    [array arrayByAddingObjectsFromArray:nil];
    
    NSString *str = nil;
    array = @[@"1", @"2", str, @"4"];
    
    [array arrayByAddingObject:nil];
    [array arrayByAddingObjectsFromArray:nil];
    [array containsObject:nil];
    
    NSString *temp[5];
    temp[1] = @"111";
    array = [[NSArray alloc] initWithObjects:temp count:4];
    array = [NSArray arrayWithObjects:temp count:4];
    
    array = [[NSArray alloc] initWithArray:nil copyItems:YES];
    array = [[NSArray alloc] initWithContentsOfFile:nil];
    array = [[NSArray alloc] initWithContentsOfURL:nil];
    
    array = [NSArray array];
    array[3];
    [array objectAtIndex:4];
    [array arrayByAddingObject:nil];
    
    array = [NSArray new];
    array[3];
    [array objectAtIndex:4];
    [array arrayByAddingObject:nil];
    
    array = [NSArray arrayWithObjects:@"1", @"2", NULL, nil, nil];
    array = [NSArray arrayWithArray:nil];
    array = [NSArray arrayWithObject:nil];
    array = [NSArray arrayWithObjects:temp count:4];
    array = [NSArray arrayWithContentsOfURL:nil];
    array = [NSArray arrayWithContentsOfFile:nil];
    if (@available(iOS 11.0, *)) {
        array = [NSArray arrayWithContentsOfURL:nil error:nil];
    }
    
    
    array = @[@"12", @"g", @"uty",@"fwef",@"gerg"];
    [array arrayByAddingObject:nil];
    [array arrayByAddingObjectsFromArray:nil];
    array[4];
    [array objectAtIndex:56];
    [array firstObjectCommonWithArray:nil];
    
    [array indexOfObject:nil];
    [array indexOfObject:@23 inRange:NSMakeRange(10, 2)];
    
    NSRange range = NSMakeRange(2, 20);
    
    
    __unsafe_unretained id cArray[1];
    
    array = @[@"1", @"2", @"3"];//__NSArrayI
    array[10];
    [array objectAtIndex:12];
    [array getObjects:cArray range:NSMakeRange(5, 10)];
    [array subarrayWithRange:NSMakeRange(20, 12)];
    [array indexOfObjectIdenticalTo:nil];
    [array indexOfObjectIdenticalTo:nil inRange:NSMakeRange(20, 10)];
    [array isEqualToArray:nil];
    
    [array indexOfObject:nil inRange:NSMakeRange(10, 2)];
    array = @[@"1"];//__NSSingleObjectArrayI
    array[10];
    [array objectAtIndex:12];
    [array objectAtIndexedSubscript:23];
    [array subarrayWithRange:NSMakeRange(20, 12)];
    [array indexOfObject:nil inRange:NSMakeRange(10, 2)];
    array = @[];//NSArray0
    array[10];
    [array objectAtIndex:12];
    [array subarrayWithRange:NSMakeRange(20, 12)];
    [array indexOfObject:nil inRange:NSMakeRange(10, 2)];
    [array indexOfObjectIdenticalTo:nil];
    
    [array getObjects:cArray range:range];
    
    [array objectAtIndexedSubscript:23];
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:67];
    [array objectsAtIndexes:nil];
    [array objectsAtIndexes:set];
    
    NSString *tempStr = [array componentsJoinedByString:nil];
    
    
    array = [NSMutableArray arrayWithContentsOfURL:nil];
    NSMutableArray *mutableArray = array.mutableCopy;
    array[10];
    [array objectAtIndex:12];
    [mutableArray containsObject:nil];
    [array subarrayWithRange:NSMakeRange(20, 12)];
    mutableArray = [NSMutableArray new];
    [mutableArray subarrayWithRange:NSMakeRange(20, 12)]; // __NSArrayM
    mutableArray[10];
    [mutableArray objectAtIndex:12];
    [mutableArray addObject:nil];
    [mutableArray insertObject:nil atIndex:0];
    [mutableArray insertObject:@212 atIndex:12];
    
    [mutableArray removeObject:nil];
    [mutableArray removeObjectAtIndex:23];
    [mutableArray removeObjectsInArray:nil];
    [mutableArray removeObjectsAtIndexes:[NSIndexSet indexSetWithIndex:34]];
    [mutableArray removeObjectsInRange:NSMakeRange(20, 12)];
    [mutableArray removeObject:nil inRange:NSMakeRange(12, 12)];
    [mutableArray removeObject:@12 inRange:NSMakeRange(12, 12)];
    
    [mutableArray addObjectsFromArray:nil];
    [mutableArray removeObjectIdenticalTo:nil];
    
    [mutableArray replaceObjectAtIndex:1 withObject:nil];
    [mutableArray replaceObjectAtIndex:12 withObject:@12];
    
    [mutableArray exchangeObjectAtIndex:1 withObjectAtIndex:10];
    [mutableArray removeObjectIdenticalTo:nil];
    [mutableArray removeObjectIdenticalTo:@12 inRange:NSMakeRange(2, 1)];
    [mutableArray setObject:nil atIndexedSubscript:2];
    [mutableArray setObject:@12 atIndexedSubscript:23];
    [mutableArray replaceObjectsInRange:NSMakeRange(0, 1) withObjectsFromArray:@[@12,@23,@12333]];
    [mutableArray replaceObjectsInRange:NSMakeRange(0, 1) withObjectsFromArray:nil];
    [mutableArray replaceObjectsInRange:NSMakeRange(10, 13) withObjectsFromArray:@[@12,@23,@12333]];
    [mutableArray setArray:nil];
    
    [mutableArray replaceObjectsInRange:NSMakeRange(0, 1) withObjectsFromArray:@[@"hufeng", @"kobe"] range:NSMakeRange(0, 2)];
    [mutableArray replaceObjectsInRange:NSMakeRange(0, 1) withObjectsFromArray:@[@"hufeng", @"kobe"] range:NSMakeRange(0, 2)];
    [mutableArray replaceObjectsInRange:NSMakeRange(0, 1) withObjectsFromArray:@[@"hufeng", @"kobe"] range:NSMakeRange(0, 2)];
    [mutableArray replaceObjectsInRange:NSMakeRange(0, 1) withObjectsFromArray:nil range:NSMakeRange(0, 2)];
    
    // 数组个数跟indexset的个数要相等
    NSMutableIndexSet *mutableSet = [NSMutableIndexSet indexSetWithIndex:1];
    
    [mutableArray insertObjects:@[@234534, @909] atIndexes:mutableSet];
    [mutableArray insertObjects:nil atIndexes:[NSIndexSet indexSetWithIndex:0]];
    [mutableArray insertObjects:@[@234,@234534] atIndexes:[NSIndexSet indexSetWithIndex:23]];
    [mutableArray replaceObjectsAtIndexes:mutableSet withObjects:nil];
    
    [mutableSet addIndex:20];
    [mutableArray replaceObjectsAtIndexes:nil withObjects:nil];
    [mutableArray replaceObjectsAtIndexes:mutableSet withObjects:@[@"jordan"]];
    mutableArray[20];
    [mutableArray objectAtIndex:23];
    
    [mutableArray getObjects:cArray range:range];
    [mutableArray arrayByAddingObject:nil];
    [mutableArray indexOfObject:@23 inRange:NSMakeRange(10, 2)];
    [mutableArray indexOfObjectIdenticalTo:nil inRange:NSMakeRange(20, 10)];
    [mutableArray objectsAtIndexes:nil];
    [mutableArray objectsAtIndexes:mutableSet];
    [mutableArray objectAtIndexedSubscript:45];
    
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
    [str stringByReplacingOccurrencesOfString:@"s" withString:nil];
    [str stringByReplacingCharactersInRange:NSMakeRange(5, 2) withString:nil];
    NSArray *arr = [str componentsSeparatedByString:nil];
    
    
    NSMutableString *mutableStr = [NSMutableString stringWithString:@"mutableString"];
    [mutableStr characterAtIndex:90];
    [mutableStr replaceCharactersInRange:NSMakeRange(0, 30) withString:nil];
    [mutableStr insertString:nil atIndex:57];
    [mutableStr deleteCharactersInRange:NSMakeRange(5, 20)];
    [mutableStr appendString:nil];

    mutableStr.string = nil;
    
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
