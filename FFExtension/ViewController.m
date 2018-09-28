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


///< NSSet/NSMutableSet, NSOrderedSet/NSMutableOrderedSet, NSUserDefault
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self testUnrecognizedSelector];
//    [self testNSStringHook];
//    [self testArrayHook];
    
    NSNull *null = [NSNull null];
    [null performSelector:@selector(length)];
    
    
//    [self testNSDictionaryHook];
//    [self testStringMore];
//    [self testForNSCacheHook];
//    [self testForNSUserDefaultsHook];
//    [self testForNSDataHook];
//    [self testForNSSetHook];
    
//    [self logAllMethods:NSClassFromString(@"__NSArrayM")];
    
    [self testExtraTestForString];
    
    [self testExtraForNSArrayHook];
}

- (void)testExtraForNSArrayHook
{
    NSArray *array = @[@1,@2,@3];
    NSMutableArray *mutable = [NSMutableArray arrayWithArray:array];
    
    [array objectAtIndex:2];
    [array objectAtIndex:3];
    [array objectAtIndexedSubscript:2];
    [array objectAtIndexedSubscript:3];
    [array objectAtIndexedSubscript:4];
    
    [mutable objectAtIndex:2];
    [mutable objectAtIndex:3];
    [mutable objectAtIndexedSubscript:2];
    [mutable objectAtIndexedSubscript:3];
    [mutable objectAtIndexedSubscript:4];
    
    [mutable removeObjectAtIndex:3];
    [mutable removeObjectAtIndex:4];
    [mutable removeObjectAtIndex:2];
    
    [mutable replaceObjectAtIndex:2 withObject:@"huuu"];
    [mutable replaceObjectAtIndex:3 withObject:@"huuu"];
    [mutable replaceObjectAtIndex:4 withObject:@"huuu"];
    
    [mutable exchangeObjectAtIndex:1 withObjectAtIndex:2];
    [mutable exchangeObjectAtIndex:0 withObjectAtIndex:1];
}

- (void)testExtraTestForString
{
    NSString *timeStr = @"2018-02-24T11:00:00.000Z";
    
    NSDate *date = [[self class] dateFromUTC:timeStr];
    NSLog(@"date = %@", date);
    
    NSString *str = @"hufeng";
    NSMutableString *mutableStr = [NSMutableString stringWithString:str];
    [str substringFromIndex:5];
    [str substringFromIndex:6];
    [str substringToIndex:5];
    [str substringToIndex:6];
    [str substringWithRange:NSMakeRange(0, 5)];
    [str substringWithRange:NSMakeRange(0, 6)];
    [str characterAtIndex:5];
    [str characterAtIndex:6];
    [str rangeOfComposedCharacterSequenceAtIndex:5];
    [str rangeOfComposedCharacterSequenceAtIndex:6];
    
    
    
    [mutableStr substringFromIndex:5];
    [mutableStr substringFromIndex:6];
    [mutableStr substringToIndex:5];
    [mutableStr substringToIndex:6];
    [mutableStr substringWithRange:NSMakeRange(0, 5)];
    [mutableStr substringWithRange:NSMakeRange(0, 6)];
    [mutableStr characterAtIndex:5];
    [mutableStr characterAtIndex:6];
    [mutableStr rangeOfComposedCharacterSequenceAtIndex:5];
    [mutableStr rangeOfComposedCharacterSequenceAtIndex:6];
    
    [mutableStr insertString:@"000" atIndex:6];
    [mutableStr insertString:@"111" atIndex:6];
}

+ (NSDate*)dateFromUTC:(NSString*)utcStr
{
    static NSDateFormatter* _utcDateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _utcDateFormatter = [[NSDateFormatter alloc] init];
        [_utcDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    });
    
    return [_utcDateFormatter dateFromString:utcStr];
}

- (void)testForNSSetHook
{
    NSSet *set = [NSSet setWithObject:nil];
    set = [NSSet setWithObject:@123];
    NSMutableSet *mutableSet = [NSMutableSet setWithObject:@3435435];
    [set containsObject:nil];
    [mutableSet containsObject:nil];
    [set intersectsSet:nil];
    [set isEqualToSet:nil];
    [set isSubsetOfSet:nil];
    [mutableSet intersectsSet:nil];
    [mutableSet isEqualToSet:nil];
    [mutableSet isSubsetOfSet:nil];
    set = [set setByAddingObject:nil];
    set = [set setByAddingObjectsFromSet:set];
    set = [set setByAddingObjectsFromSet:nil];
    set = [set setByAddingObjectsFromArray:@[]];
    set = [set setByAddingObjectsFromArray:nil];
    
    mutableSet = [mutableSet setByAddingObject:nil];
    mutableSet = [mutableSet setByAddingObjectsFromSet:set];
    mutableSet = [mutableSet setByAddingObjectsFromSet:nil];
    mutableSet = [mutableSet setByAddingObjectsFromArray:@[]];
    mutableSet = [mutableSet setByAddingObjectsFromArray:nil];
    
    [[NSSet alloc] initWithObjects:nil, nil];
    [[NSSet alloc] initWithSet:nil];
    [[NSSet alloc] initWithSet:nil copyItems:YES];
    [[NSSet alloc] initWithArray:nil];
    
    [NSSet setWithObject:nil];
    [NSSet setWithObjects:nil, nil];
    [NSSet setWithArray:nil];
    [NSSet setWithSet:nil];
    [NSSet setWithObjects:nil count:0];
    
    
    [[NSMutableSet alloc] initWithObjects:nil, nil];
    [[NSMutableSet alloc] initWithSet:nil];
    [[NSMutableSet alloc] initWithSet:nil copyItems:YES];
    [[NSMutableSet alloc] initWithArray:nil];
    
    [NSMutableSet setWithObject:nil];
    [NSMutableSet setWithObjects:nil, nil];
    [NSMutableSet setWithArray:nil];
    [NSMutableSet setWithSet:nil];
    [NSMutableSet setWithObjects:nil count:2];
    
    [mutableSet addObject:nil];
    [mutableSet removeObject:nil];
    [mutableSet addObjectsFromArray:nil];
    [mutableSet intersectSet:nil];
    [mutableSet minusSet:nil];
    [mutableSet unionSet:nil];
    [mutableSet setSet:nil];
}

- (void)testForNSDataHook
{
    NSArray *dataClasses = [[self class] findAllOf:[NSData class]];
//    NSLog(@"dataClasses = %@", dataClasses);
    
//    [self logAllMethods:NSClassFromString(@"NSData")];
    
    NSData *data = [@"hufeng" dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [[NSMutableData alloc] initWithData:data];
    NSData *subData = [data subdataWithRange:NSMakeRange(2, 2)];
    const void * str = "fewfewgfewfew";
    
    
    [mutableData subdataWithRange:NSMakeRange(9, 40)];
    [data rangeOfData:subData options:NSDataSearchAnchored range:NSMakeRange(90, 12)];
    [mutableData rangeOfData:subData options:NSDataSearchAnchored range:NSMakeRange(90, 12)];
    [data rangeOfData:subData options:NSDataSearchAnchored range:NSMakeRange(90, 12)];
    [mutableData rangeOfData:subData options:NSDataSearchAnchored range:NSMakeRange(90, 12)];
    [data getBytes:NULL length:40];
    [data subdataWithRange:NSMakeRange(0, 30)];
    [subData subdataWithRange:NSMakeRange(9, 12)];
    [data getBytes:str range:NSMakeRange(3, 90)];
    [data getBytes:str length:40];
    [mutableData getBytes:str range:NSMakeRange(3, 90)];
    [mutableData getBytes:str length:40];
    [mutableData getBytes:nil length:90];
    
    
    data = [NSData data];
    [data subdataWithRange:NSMakeRange(10, 200)];
    [data rangeOfData:subData options:NSDataSearchAnchored range:NSMakeRange(90, 12)];
    [mutableData rangeOfData:subData options:NSDataSearchAnchored range:NSMakeRange(90, 12)];
    [data rangeOfData:subData options:NSDataSearchAnchored range:NSMakeRange(90, 12)];
    [mutableData rangeOfData:subData options:NSDataSearchAnchored range:NSMakeRange(90, 12)];
    [data getBytes:str range:NSMakeRange(3, 90)];
    [data getBytes:str length:40];
    [mutableData getBytes:str range:NSMakeRange(3, 90)];
    [mutableData getBytes:str length:40];
    [data getBytes:NULL length:40];
    [mutableData getBytes:nil length:90];
    
    
    
    data = [NSData dataWithBytes:str length:10];
    [data subdataWithRange:NSMakeRange(5, 40)];
    [data rangeOfData:subData options:NSDataSearchAnchored range:NSMakeRange(90, 12)];
    [mutableData rangeOfData:subData options:NSDataSearchAnchored range:NSMakeRange(90, 12)];
    [data rangeOfData:subData options:NSDataSearchAnchored range:NSMakeRange(90, 12)];
    [mutableData rangeOfData:subData options:NSDataSearchAnchored range:NSMakeRange(90, 12)];
    [data getBytes:str range:NSMakeRange(3, 90)];
    [data getBytes:str length:40];
    [mutableData getBytes:str range:NSMakeRange(3, 90)];
    [mutableData getBytes:str length:40];
    [data getBytes:NULL length:40];
    [mutableData getBytes:nil length:90];
    
    data = [[NSData alloc] initWithBase64EncodedString:nil options:NSDataBase64DecodingIgnoreUnknownCharacters];
    data = [[NSData alloc] initWithBase64EncodedData:nil options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    
    [mutableData appendData:nil];
    [mutableData appendBytes:nil length:0];
    [mutableData appendBytes:nil length:100];
    [mutableData appendBytes:str length:100];
    
    [mutableData replaceBytesInRange:NSMakeRange(10, 10) withBytes:nil];
    [mutableData replaceBytesInRange:NSMakeRange(120, 10) withBytes:str];
    [mutableData replaceBytesInRange:NSMakeRange(0, 10) withBytes:str length:60];
    [mutableData replaceBytesInRange:NSMakeRange(0, 1000) withBytes:nil length:6];
    [mutableData replaceBytesInRange:NSMakeRange(0, 1000) withBytes:str length:600];
    [mutableData resetBytesInRange:NSMakeRange(21, 900)];
    
//    [data increaseLengthBy:2034];
    [mutableData increaseLengthBy:353];
    [mutableData setData:nil];
}

- (void)testForNSCacheHook
{
    NSCache *cache = [NSCache new];
    
    [cache removeObjectForKey:nil];
    [cache objectForKey:nil];
    [cache setObject:@4234 forKey:nil];
    [cache setObject:nil forKey:@"ewr"];
    [cache setObject:nil forKey:nil];
    [cache setObject:@"fgf" forKey:nil cost:0];
    
    
}

- (void)testForNSUserDefaultsHook
{
    NSUserDefaults *useDefaults = [NSUserDefaults standardUserDefaults];
    [useDefaults setObject:@"fewf" forKey:@"key"];
    [useDefaults setObject:nil forKey:@"key"];
    [useDefaults setObject:@"fewf" forKey:nil];
    [useDefaults objectForKey:nil];
    [useDefaults removeObjectForKey:nil];
    
    [useDefaults stringForKey:nil];
    [useDefaults arrayForKey:nil];
    [useDefaults dictionaryForKey:nil];
    [useDefaults dataForKey:nil];
    [useDefaults stringArrayForKey:nil];
    
    
    [useDefaults integerForKey:nil];
    [useDefaults floatForKey:nil];
    [useDefaults doubleForKey:nil];
    [useDefaults boolForKey:nil];
    [useDefaults URLForKey:nil];
    
    [useDefaults setInteger:nil forKey:nil];
    [useDefaults setFloat:0 forKey:nil];
    [useDefaults setBool:0 forKey:nil];
    [useDefaults setURL:nil forKey:nil];
    [useDefaults registerDefaults:nil];
    [useDefaults addSuiteNamed:nil];
    [useDefaults removeSuiteNamed:nil];
    
    [useDefaults volatileDomainForName:nil];
    [useDefaults setVolatileDomain:@{} forName:nil];
    [useDefaults setVolatileDomain:nil forName:@"efe"];
    [useDefaults removeVolatileDomainForName:nil];
    
    [useDefaults objectIsForcedForKey:nil];
    [useDefaults objectIsForcedForKey:nil inDomain:@"ewf"];
}



- (void)testStringMore
{
    [NSString  stringWithUTF8String:nil];
    [NSString  stringWithUTF8String:NULL];
    [NSString stringWithCString:nil encoding:NSUTF8StringEncoding];
    [[NSString alloc] initWithUTF8String:nil];
    [[NSString alloc] initWithCString:nil encoding:NSUTF8StringEncoding];
    [[NSString alloc] initWithString:nil];
    
    [NSMutableString stringWithCString:nil encoding:NSUTF8StringEncoding];
    [NSMutableString stringWithUTF8String:nil];
    [[NSMutableString alloc] initWithCString:nil encoding:NSUTF8StringEncoding];
    [[NSMutableString alloc] initWithUTF8String:nil];
    [[NSMutableString alloc] initWithString:nil];
    
    NSString *str = @"feawfwefwef";
    
//    [self logAllMethods:NSClassFromString(@"NSTaggedPointerString")];
    
    
    [[str copy] substringToIndex:90];
    NSMutableString *mutableStr = [str mutableCopy];
    [mutableStr substringToIndex:90];
    
    mutableStr = [NSMutableString stringWithString:@"fewf"];
    [mutableStr substringToIndex:243];
//    [[mutableStr copy] substringToIndex:3434];
    [[mutableStr mutableCopy] substringToIndex:133];
}

- (void)testNSDictionaryHook
{
    
//    NSArray *dicArray = [[self class] findAllOf:[NSDictionary class]];
//    NSLog(@"NSDictionary = %@", dicArray);
//
//    NSArray *mutableDic = [[self class] findAllOf:[NSMutableDictionary class]];
//    NSLog(@"NSMutalbeDictionary = %@", mutableDic);
    
    
    NSString *key = @"key";
    NSString *value = @"value";
//    key = nil;
//    value = nil;
    NSDictionary *dic;
    dic = [NSDictionary dictionaryWithObject:value forKey:key];
    dic = @{ key : value };
    
    [[dic copy] objectForKey:nil];
//    [[dic copy] setObject:nil forKey:nil];
    [[dic mutableCopy] objectForKey:nil];
    [[dic mutableCopy] setObject:@123 forKey:@"key"];
    [[dic mutableCopy] setObject:nil forKey:@"key"];
    [[dic mutableCopy] setObject:@12 forKey:nil];
    
    id objects[1];
    objects[0] = @"vaevewewf";
    
    id keys[2];
    keys[0] = @"wef";
    
    dic = [NSDictionary dictionaryWithObjects:objects forKeys:keys count:2];
    
    dic = [NSDictionary dictionaryWithObjects:@[@2,@2] forKeys:nil];
    dic = [NSMutableDictionary dictionaryWithObjects:@[@2,@2] forKeys:nil];
    [[NSDictionary alloc] initWithDictionary:nil];
    [[NSDictionary alloc] initWithDictionary:nil copyItems:YES];
    [[NSDictionary alloc] initWithObjects:@[@1,@2] forKeys:nil];
    
    [NSDictionary sharedKeySetForKeys:@[@"few", @2]];
//    [NSDictionary sharedKeySetForKeys:nil];
    [NSMutableDictionary sharedKeySetForKeys:nil];
    
    key = nil;
    dic[key];
    [dic objectForKey:nil];
    
    NSArray *array = [dic allKeysForObject:value];
    array = [dic allKeysForObject:nil];
    [dic isEqualToDictionary:@{@"wf":@"ewff"}];
    [dic isEqualToDictionary:nil];
    [dic isEqualToDictionary:NULL];
    
    [dic writeToFile:nil atomically:NO];
    [dic writeToURL:nil atomically:YES];
    [dic writeToURL:nil error:nil];
    
    NSMutableDictionary *mutableDic = [NSMutableDictionary new];
    [mutableDic setObject:@1312 forKey:@"key"];
    [mutableDic setObject:@"ewfefeg" forKeyedSubscript:@"hufeng"];
    
    [mutableDic setObject:@123 forKeyedSubscript:nil];
    [mutableDic setObject:nil forKey:@"key"];
    [mutableDic removeObjectForKey:@"hufeng"];
    [mutableDic setObject:nil forKeyedSubscript:@"hufeng"];
    
    [mutableDic objectForKey:nil];
    [NSMutableDictionary dictionaryWithSharedKeySet:nil];
    [mutableDic removeObjectForKey:nil];
    [mutableDic removeObjectsForKeys:nil];
    [mutableDic removeObjectsForKeys:@[@"ewf",@322]];
    [mutableDic setDictionary:nil];
    
    [mutableDic addEntriesFromDictionary:nil];
    [mutableDic setObject:@2342 forKey:nil];
    [mutableDic setObject:nil forKey:@"fewf"];
    [mutableDic setObject:nil forKey:@234324];
    [mutableDic setObject:nil forKey:nil];
    
//    [mutableDic setObject:@"ewf" forKeyedSubscript:nil];
    [mutableDic setObject:nil forKeyedSubscript:@"few"];
    [mutableDic setObject:nil forKeyedSubscript:nil];
    
    NSArray *tempArray = @[@"ef"];
    
    NSMutableArray *mutableArray = [tempArray mutableCopy];
    
    if (@available(iOS 11, *)) {
        [mutableDic writeToURL:nil error:nil];
        [tempArray writeToURL:nil error:nil];
        [mutableArray writeToURL:nil error:nil];
    }
    
    NSMutableData *data = [[NSMutableData alloc] init];
    [data writeToURL:nil atomically:YES];
    [data writeToURL:nil options:NSDataWritingFileProtectionMask error:nil];
    
    [dic objectForKeyedSubscript:nil];
    [mutableDic objectForKeyedSubscript:nil];
    
    [NSDictionary dictionaryWithDictionary:nil];
    
    
}

- (void)testArrayHook
{
    
    /*测试 ff_objectAtIndex:
     __NSArrayI
     __NSArray0
     __NSSingleObjectArrayI
     __NSArrayM
     */
    //    SEL sel = NSSelectorFromString(@"objectAtIndex:"); //
    SEL sel = NSSelectorFromString(@"getObjects:range:");
//    Method method = class_getInstanceMethod(NSClassFromString(@"__NSArrayI_Transfer"), sel);
//    NSLog(@"__NSArrayI_Transfer Method = %p", method);
    
    NSArray *classes = @[@"__NSArrayI",@"__NSArray0",@"__NSSingleObjectArrayI",@"__NSArrayM"];
    for (NSString *className in classes) {
        Class arrClass = NSClassFromString(className);
        
        
        Method originMethod = class_getInstanceMethod(arrClass, sel);
        IMP imp = method_getImplementation(originMethod);
        NSLog(@"className = %@, Method = %p", arrClass, originMethod);
    }
    
    
    NSArray *tempArr = [[self class] findAllOf:[NSArray class]];
//    NSLog(@"NSArray result = %@", tempArr);

    
    @[][0];
    [[NSArray new] indexOfObjectIdenticalTo:nil];
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
    array = [[NSArray alloc] initWithObjects:nil count:4];
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
    mutableArray = [NSMutableArray new];
    [mutableArray setObject:@"hufeng" atIndexedSubscript:0];
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
    [mutableArray addObjectsFromArray:@[@12,@234]];
    [mutableArray setObject:@124354 atIndexedSubscript:2];
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
    [str rangeOfComposedCharacterSequencesForRange:NSMakeRange(90, 90)];
    [str stringByAppendingString:nil];
    [str stringByReplacingOccurrencesOfString:@"s" withString:nil];
    [str stringByReplacingCharactersInRange:NSMakeRange(5, 2) withString:nil];
    
    [str substringFromIndex:14];
    [str substringToIndex:80];
    [str substringWithRange:NSMakeRange(90, 90)];
    
    
    NSArray *arr = [str componentsSeparatedByString:nil];
    
    
    NSMutableString *mutableStr = [NSMutableString stringWithString:@"mutableString"];
    
    [str isEqualToString:nil];
    [mutableStr isEqualToString:nil];
    
    [mutableStr hasPrefix:nil];
    [mutableStr hasSuffix:nil];
    [mutableStr containsString:nil];
    [mutableStr rangeOfString:nil];
    [mutableStr rangeOfString:nil options:0];
    [mutableStr rangeOfComposedCharacterSequenceAtIndex:30];
    [mutableStr rangeOfComposedCharacterSequencesForRange:NSMakeRange(90, 90)];
    [mutableStr stringByAppendingString:nil];
    [mutableStr stringByReplacingCharactersInRange:NSMakeRange(50, 2) withString:@"uu"];
    [mutableStr stringByReplacingOccurrencesOfString:@"s" withString:nil];
    [mutableStr stringByReplacingCharactersInRange:NSMakeRange(50, 2) withString:nil];
    
    [mutableStr substringFromIndex:14];
    [mutableStr substringToIndex:80];
    [mutableStr substringWithRange:NSMakeRange(90, 90)];
    
    [mutableStr characterAtIndex:90];
    [mutableStr replaceCharactersInRange:NSMakeRange(0, 30) withString:nil];
    [mutableStr insertString:nil atIndex:57];
    [mutableStr deleteCharactersInRange:NSMakeRange(5, 20)];
    [mutableStr appendString:nil];
//    [mutableStr appendFormat:nil];
    
    NSString *copyStr = [mutableStr copy];
    copyStr = [str copy];
    copyStr = [str mutableCopy];
    copyStr = [mutableStr mutableCopy];
    [copyStr isEqualToString:nil];
    [copyStr substringWithRange:NSMakeRange(90, 90)];
    [copyStr characterAtIndex:90];
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

- (void)logAllMethods:(Class)tempClass
{
    NSUInteger count = 0;
    Method *methods = class_copyMethodList(tempClass, &count);
    
    for (int i = 0; i < count; i++)
    {
        Method method = methods[i];

        SEL selector = method_getName(method);

        NSString *name = NSStringFromSelector(selector);
        NSLog(@"array %@ method name = %@", [tempClass class], name);
    }
}

@end
