//
//  NSMutableArray+Safe.m
//  Batch record printing
//
//  Created by 杨健 on 2019/6/24.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import "NSObject+Runtime.h"
@implementation NSMutableArray (Safe)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *obj = [[NSMutableArray alloc]init];
        //对象方法 __NSArrayM 和__NSArrayI 都有实现，都要swizz
        //交互后addObject走的就是hookAddObjec,hookAddObjec实现的d是addObject
        [obj swizzleMethod:@selector(addObject:) swizzledSelector:@selector(hookAddObject:)];
    });
}

-(void)hookAddObject:(id)anObject{
    if (anObject) {
        [self hookAddObject:anObject];
    }else{
        [self hookAddObject:@"无"];
    }
}


@end
