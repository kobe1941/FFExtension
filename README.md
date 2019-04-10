# FFExtension   

![pod](https://img.shields.io/badge/pod-1.0.7-orange.svg)  [![LICENSE](https://img.shields.io/badge/license-Anti%20996-blue.svg)](https://github.com/996icu/996.ICU/blob/master/LICENSE) [![weibo status](https://img.shields.io/badge/weibo-%40Zombie%E7%AC%AC%E4%B8%83%E7%AB%A0-brightgreen.svg)](https://weibo.com/1247589445)

`ARC`  `iOS8.0+`



友情链接 [![996.icu](https://img.shields.io/badge/link-996.icu-red.svg)](https://996.icu)



### [中文介绍](http://www.zoomfeng.com/blog/ffextension.html)

主要用于降低iOS APP的常见崩溃，比如数组字典等容器的越界和插入空值，以及可选的unrecognized selector sent to instance这类崩溃。

最新版本已经去掉对NSData的hook，会跟高德的SDK用到的某个函数有点冲突，我这边测试用例过不了就直接去掉了。

所有被hook的函数都是直接从系统API选取的，基本上能拦截掉绝大部分的常见越界类和空值类数据引起的崩溃。

KVO，NSTimer强引用这类能用代码规范解决的，本库不做额外的防护。

To Avoid the classes out of bounds :

```objective-c
NSString
NSArray
NSDictionary
NSSet
NSCache
NSUserDefaults
NSAttributedString
```

also , avoid   `unrecognized selector sent to instance`   crash by user customize.





### Start

```objective-c
$ pod 'FFExtension'
```



You need import one head file just like  `import <FFManager.h>`  .

Then put the code below in your project,  maybe in `application:didFinishLaunchingWithOptions:`    method,  make sure the calss will not dealloc in all app life.

```objective-c
__weak typeof(self) weakSelf = self;
[[FFManager sharedInstance] startWorkWithOption:FFHookOptionAll unrecogziedSelectorClassPrefixs:@[@"SSZ"] callBackBlock:^(NSDictionary *exceptionDic) {
        [weakSelf reportExecptionToBugly:exceptionDic];
}];
```



just like this:

```objective-c
#pragma mark - Report Exception To Bugly
- (void)reportExecptionToBugly:(NSDictionary *)exceptionDic
{
    if (exceptionDic) {
        NSString *name = [exceptionDic objectForKey:FF_Name];
        NSString *reason = [exceptionDic objectForKey:FF_Reason];
        NSDictionary *extraDic = [exceptionDic objectForKey:FF_ExtraDic];
        NSArray *callStack = [exceptionDic objectForKey:FF_CallStackSymbols];
        
        [Bugly reportExceptionWithCategory:3 name:name reason:reason callStack:callStack 			extraInfo:extraDic terminateApp:NO];
    }
}
```



`Tips`:  classPrefixs is your own calsses that you want to avoid  `unrecogzied selector sent to instance   ` crash.  

```objective-c
- (void)startWorkWithOption:(FFHookOption)option unrecogziedSelectorClassPrefixs:(NSArray<NSString *> *)classPrefixs callBackBlock:(FFExceptionBlock)block;
```



---



Safe method for example

**NSArray**

```objective-c
- (BOOL)writeToURL:(NSURL *)url error:(NSError * _Nullable __autoreleasing *)error;
- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (id)objectAtIndexedSubscriptArrayM:(NSUInteger)index;
- (id)objectAtIndex:(NSUInteger)index;
- (instancetype)initWithObjects:(const id _Nonnull [_Nullable])objects count:(NSUInteger)cnt;
- (NSArray *)arrayByAddingObject:(id)anObject;
- (void)getObjects:(id _Nonnull __unsafe_unretained [_Nonnull])objects range:(NSRange)range;
- (NSUInteger)indexOfObject:(id)anObject inRange:(NSRange)range;
- (NSUInteger)indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range;
- (NSArray *)subarrayWithRange:(NSRange)range;
- (NSArray *)objectsAtIndexes:(NSIndexSet *)indexes;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)removeObjectsInRange:(NSRange)range;
- (void)removeObjectsAtIndexes:(NSIndexSet *)indexes;
- (void)removeObject:(id)anObject inRange:(NSRange)range;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)removeObjectAtIndexArrayM:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
- (void)removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range;
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;
- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray;
- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange;
- (void)insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects;
```

and so on ...



---



By use `method swizzle`  to do this , no  *` try-catch`* .



Have a nice day !