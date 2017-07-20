//
//  NSArray+Swizzling.m
//  Template
//
//  Created by yuwenhua on 2016/10/24.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "NSArray+Swizzling.h"

#import <objc/runtime.h>

@implementation NSArray (Swizzling)

+ (void)load {
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(swizzling_objectAtIndex:));
    method_exchangeImplementations(fromMethod, toMethod);
}

- (id)swizzling_objectAtIndex:(NSUInteger)index {
    
    if (index < self.count)
    {
        return [self swizzling_objectAtIndex:index];
    }
    else
    {
        // 数据越界，异常处理
        @try {
            return [self swizzling_objectAtIndex:index];
        } @catch (NSException *exception) {
            // 打印崩溃信息
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        } @finally {
            
        }
    }
}

@end

@implementation NSMutableArray (Swizzling)

+ (void)load
{
    Class cls = NSClassFromString(@"__NSArrayM");
    Method methodOld = class_getInstanceMethod(cls, @selector(objectAtIndex:));
    Method methodNew = class_getInstanceMethod(cls, @selector(objectAtIndexNew:));
    method_exchangeImplementations(methodOld, methodNew);
    
    Method methodOldInsert = class_getInstanceMethod(cls, @selector(insertObject:atIndex:));
    Method methodNewInsert = class_getInstanceMethod(cls, @selector(insertObjectNew:atIndex:));
    method_exchangeImplementations(methodOldInsert, methodNewInsert);
    
    Method methodSetOld = class_getInstanceMethod(cls, @selector(setObject:atIndex:));
    Method methodSetNew = class_getInstanceMethod(cls, @selector(setNewObject:atIndex:));
    method_exchangeImplementations(methodSetOld, methodSetNew);
}

- (id)objectAtIndexNew:(NSUInteger)index
{
    if (index < self.count)
    {
        return [self objectAtIndexNew:index];
    }
    else
    {
        @try
        {
            return [self objectAtIndexNew:index];
        }
        @catch (NSException *exception)
        {
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        }
        @finally
        {
            
        }
    }
}

- (void)insertObjectNew:(id)anObject atIndex:(NSUInteger)index
{
    if (nil != anObject && index < self.count)
    {
        return [self insertObjectNew:anObject atIndex:index];
    }
    else
    {
        @try
        {
            return [self insertObjectNew:anObject atIndex:index];
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

- (void)setNewObject:(id)obj atIndex:(NSUInteger)idx
{
    if (nil != obj)
    {
        return [self setNewObject:obj atIndex:idx];
    }
    else
    {
        @try
        {
            return [self setNewObject:obj atIndex:idx];
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
