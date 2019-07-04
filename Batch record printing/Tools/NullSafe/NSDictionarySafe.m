//
//  NSDictionarySafe.m
//  Batch record printing
//
//  Created by 杨健 on 2019/7/4.
//  Copyright © 2019 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSDictionary (NullSafe)

+(instancetype)dictionaryWithObjects:(const id[])objects forKeys:(const id[])keys count:(NSUInteger)cnt
{
    NSMutableArray *validKeys = [NSMutableArray new];
    NSMutableArray *validObjs = [NSMutableArray new];
    
    for (NSUInteger i = 0; i < cnt; i ++) {
        if (objects[i] && keys[i])
        {
            [validKeys addObject:keys[i]];
            [validObjs addObject:objects[i]];
        }
    }
    return [self dictionaryWithObjects:validObjs forKeys:validKeys];
}

@end

