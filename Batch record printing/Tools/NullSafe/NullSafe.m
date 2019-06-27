//
//  NullSafe.m
//
//  Version 2.0
//
//  Created by Nick Lockwood on 19/12/2012.
//  Copyright 2012 Charcoal Design
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/NullSafe
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//
/*
 当我们给一个 NSNull 对象发送消息的话，可能会崩溃（ null 是有内存的），而发送给 nil 的话，是不会崩溃的。发送给 NSNull 而 NSNull 又无法处理的消息要经过如下几步做转发处理:
 
 创建一个方法缓存，这个缓存会缓存项目中类的所有类名。
 遍历缓存，寻找是否已经有可以执行此方法的类。
 如果有的话，返回这个 NSMethodSignature 。
 如果没有的话，返回 nil , 接下来会走 forwardInvocation:方法。
 [invocation invokeWithTarget:nil]; 将消息转发给 nil。
 
 那么，如何判断NSNull无法处理这个消息呢，在OC中，系统如果对某个实例发送消息之后，它（及其父类）无法处理（比如，没有这个方法等），系统就会发送 methodSignatureForSelector 消息，如果这个方法返回非空，那么就去执行返回的方法，如果为 nil, 则发送 forwardInvocation 消息。这样就完成整个转发链了
 
 作者：择势勤
 链接：https://www.jianshu.com/p/96332619f2dd
 来源：简书
 简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
 */

#import <Foundation/Foundation.h>


#ifndef NULLSAFE_ENABLED
#define NULLSAFE_ENABLED 1
#endif


#pragma clang diagnostic ignored "-Wgnu-conditional-omitted-operand"


@implementation NSNull (NullSafe)

#if NULLSAFE_ENABLED


- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    //look up method signature
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if (!signature)
    {
        for (Class someClass in @[
            [NSMutableArray class],
            [NSMutableDictionary class],
            [NSMutableString class],
            [NSNumber class],
            [NSDate class],
            [NSData class]
           
        ])
        {
            @try
            {
                if ([someClass instancesRespondToSelector:selector])
                {
                    signature = [someClass instanceMethodSignatureForSelector:selector];
                    break;
                }
            }
            @catch (__unused NSException *unused) {}
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    invocation.target = nil;
    [invocation invoke];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector{
    
}

#endif

@end
