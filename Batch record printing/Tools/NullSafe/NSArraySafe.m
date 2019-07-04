//
//  NSArraySafe.m
//  Batch record printing
//
//  Created by 杨健 on 2019/7/4.
//  Copyright © 2019 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSArray (NullSafe)

+(instancetype)arrayWithObjects:(const id [])objects count:(NSUInteger)cnt
{
    NSMutableArray *ma = [NSMutableArray new];
    
    for (NSUInteger i = 0; i < cnt; i ++) {
        if (objects[i])
        {
            [ma addObject:objects[i]];
        }
    }
    return [[NSArray alloc] initWithArray:ma];
}

@end
