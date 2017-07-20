//
//  NSDictionary+Swizzling.m
//  CureFunNew
//
//  Created by modong on 2017/5/18.
//  Copyright © 2017年 TLQ. All rights reserved.
//

#import "NSDictionary+Swizzling.h"

@implementation NSDictionary (Swizzling)

+ (void)load
{
    Method methodOld = class_getClassMethod(self, @selector(dictionaryWithObjects:forKeys:count:));
    Method methodNew = class_getClassMethod(self, @selector(dictionaryNewWithObjects:forKeys:count:));
    method_exchangeImplementations(methodOld, methodNew);
}

+ (instancetype)dictionaryNewWithObjects:(const id [])objects forKeys:(const id <NSCopying> [])keys count:(NSUInteger)cnt
{
    id nObjects[cnt];
    id nKeys[cnt];
    int i=0, j=0;
    for (; i<cnt && j<cnt; i++) {
        if (objects[i] && keys[i]) {
            nObjects[j] = objects[i];
            nKeys[j] = keys[i];
            j++;
        }
    }
    
    return [self dictionaryNewWithObjects:nObjects forKeys:nKeys count:j];
}

@end


@implementation NSMutableDictionary (Swizzling)

+ (void)load
{
    Class cls = NSClassFromString(@"__NSDictionaryM");
    
    Method methodSetObjectOld = class_getInstanceMethod(cls, @selector(setObject:forKey:));
    Method methodSetObjectNew = class_getInstanceMethod(cls, @selector(setNewObject:forKey:));
    method_exchangeImplementations(methodSetObjectOld, methodSetObjectNew);
}

- (void)setNewObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject && aKey)
    {
        [self setNewObject:anObject forKey:aKey];
    }
    else
    {
        @try
        {
            [self setNewObject:anObject forKey:aKey];
        }
        @catch (NSException *exception)
        {
            NSLog(@"%@", [exception callStackSymbols]);
        }
        @finally
        {
            
        }
    }
}

@end
