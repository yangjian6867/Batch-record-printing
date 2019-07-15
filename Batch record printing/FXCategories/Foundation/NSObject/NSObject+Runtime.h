//
//  NSObject+Runtime.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)

/**
*  动态替换方法
*/
+ (void)swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod;

//动态交互方法
- (void)swizzleMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

+(void)getProtocolList;
/**
 *  动态为某个类添加方法
 */
+ (void)appendMethod:(SEL)newMethod fromClass:(Class)klass;

//获取一个对象中说有的属性值、
//class_copyPropertyList返回的仅仅是对象类的属性(@property申明的属性)，
//class_copyIvarList返回类的所有属性和变量(包括在@interface大括号中声明的变量)
-(NSMutableArray *)getPropertValues:(id)obj;

/**
 *  动态为某个类替换方法
 */
+ (void)replaceMethod:(SEL)method fromClass:(Class)klass;

/**
 Check whether the receiver implements or inherits a specified method up to and exluding a particular class in hierarchy.
 
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)respondsToSelector:(SEL)selector untilClass:(Class)stopClass;

/**
 Check whether a superclass implements or inherits a specified method.
 
 @param selector A selector that identifies a method.
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)superRespondsToSelector:(SEL)selector;

/**
 Check whether a superclass implements or inherits a specified method.
 
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)superRespondsToSelector:(SEL)selector untilClass:(Class)stopClass;

/**
 Check whether the receiver's instances implement or inherit a specified method up to and exluding a particular class in hierarchy.
 
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
+ (BOOL)instancesRespondToSelector:(SEL)selector untilClass:(Class)stopClass;
@end
