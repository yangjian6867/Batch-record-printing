//
//  NSObject+Runtime.m
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>
BOOL method_swizzle(Class klass, SEL origSel, SEL altSel)
{
    if (!klass)
        return NO;
    
    Method __block origMethod, __block altMethod;
    
    void (^find_methods)(void) = ^
    {
        unsigned methodCount = 0;
        Method *methodList = class_copyMethodList(klass, &methodCount);
        
        origMethod = altMethod = NULL;
        
        if (methodList)
            for (unsigned i = 0; i < methodCount; ++i)
            {
                if (method_getName(methodList[i]) == origSel)
                    origMethod = methodList[i];
                
                if (method_getName(methodList[i]) == altSel)
                    altMethod = methodList[i];
            }
        
        free(methodList);
    };
    
    find_methods();
    
    if (!origMethod)
    {
        origMethod = class_getInstanceMethod(klass, origSel);
        
        if (!origMethod)
            return NO;
        
        if (!class_addMethod(klass, method_getName(origMethod), method_getImplementation(origMethod), method_getTypeEncoding(origMethod)))
            return NO;
    }
    
    if (!altMethod)
    {
        altMethod = class_getInstanceMethod(klass, altSel);
        
        if (!altMethod)
            return NO;
        
        if (!class_addMethod(klass, method_getName(altMethod), method_getImplementation(altMethod), method_getTypeEncoding(altMethod)))
            return NO;
    }
    
    find_methods();
    
    if (!origMethod || !altMethod)
        return NO;
    
    method_exchangeImplementations(origMethod, altMethod);
    
    return YES;
}

void method_append(Class toClass, Class fromClass, SEL selector)
{
    if (!toClass || !fromClass || !selector)
        return;
    
    Method method = class_getInstanceMethod(fromClass, selector);
    
    if (!method)
        return;
    
    class_addMethod(toClass, method_getName(method), method_getImplementation(method), method_getTypeEncoding(method));
}

void method_replace(Class toClass, Class fromClass, SEL selector)
{
    if (!toClass || !fromClass || ! selector)
        return;
    
    Method method = class_getInstanceMethod(fromClass, selector);
    
    if (!method)
        return;
    
    class_replaceMethod(toClass, method_getName(method), method_getImplementation(method), method_getTypeEncoding(method));
}

@implementation NSObject (Runtime)

+(void)getProtocolList{
    unsigned int count;
    __unsafe_unretained Protocol **protocoList = class_copyProtocolList([self class], &count);
    for (unsigned int i = 0; i<count; i++) {
        Protocol *pro = protocoList[i];
        const char *proName = protocol_getName(pro);
        NSLog(@"proName = %@",[NSString stringWithUTF8String:proName]);
    }
}

+ (void)swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod
{
    method_swizzle(self.class, originalMethod, newMethod);
}


-(NSMutableArray *)getPropertValues:(id)obj{
    unsigned int count;
    NSMutableArray *arr = [NSMutableArray array];
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    for(int i=0;i<count;i++){
        objc_property_t property = properties[i];
        const char *propertyName =  property_getName(property);
        NSString *key = [[NSString alloc]initWithCString:propertyName encoding:NSUTF8StringEncoding];
        //kvc读值
        NSString *value = [obj valueForKey:key];
        [arr addObject:value];
    }
    return arr;
}

-(void)swizzleMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector{
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    
    Method swizzledMehtod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMehtod), method_getTypeEncoding(swizzledMehtod));
    
    //如果YES意味着以前的originalSelector不存在，会给类添加一个新方法originalSelector，然后给originalSelector 添加实现为swizzledSelector
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        //originalSelector添加实现失败，因为以前就已经实现了，就进行叫唤。
        method_exchangeImplementations(originalMethod, swizzledMehtod);
    }
}

+ (void)appendMethod:(SEL)newMethod fromClass:(Class)klass
{
    method_append(self.class, klass, newMethod);
}

+ (void)replaceMethod:(SEL)method fromClass:(Class)klass
{
    method_replace(self.class, klass, method);
}

- (BOOL)respondsToSelector:(SEL)selector untilClass:(Class)stopClass
{
    return [self.class instancesRespondToSelector:selector untilClass:stopClass];
}

- (BOOL)superRespondsToSelector:(SEL)selector
{
    return [self.superclass instancesRespondToSelector:selector];
}

- (BOOL)superRespondsToSelector:(SEL)selector untilClass:(Class)stopClass
{
    return [self.superclass instancesRespondToSelector:selector untilClass:stopClass];
}

+ (BOOL)instancesRespondToSelector:(SEL)selector untilClass:(Class)stopClass
{
    BOOL __block (^ __weak block_self)(Class klass, SEL selector, Class stopClass);
    BOOL (^block)(Class klass, SEL selector, Class stopClass) = [^
                                                                 (Class klass, SEL selector, Class stopClass)
                                                                 {
                                                                     if (!klass || klass == stopClass)
                                                                         return NO;
                                                                     
                                                                     unsigned methodCount = 0;
                                                                     Method *methodList = class_copyMethodList(klass, &methodCount);
                                                                     
                                                                     if (methodList)
                                                                         for (unsigned i = 0; i < methodCount; ++i)
                                                                             if (method_getName(methodList[i]) == selector)
                                                                                 return YES;
                                                                     
                                                                     return block_self(klass.superclass, selector, stopClass);
                                                                 } copy];
    
    block_self = block;
    
    return block(self.class, selector, stopClass);
}

@end
