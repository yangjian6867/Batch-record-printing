//
//  NSObject+MJParse.m
//  Supervise
//
//  Created by djh on 2017/4/27.
//  Copyright © 2017年 com.sofn.lky.government. All rights reserved.
//

#import "NSObject+MJParse.h"

@implementation NSObject (MJParse)
+ (id)parse:(id)responseObj
{
    if ([responseObj isKindOfClass:[NSDictionary class]]) {
        return [self mj_objectWithKeyValues:responseObj];
    }
    if ([responseObj isKindOfClass:[NSArray class]]) {
        return [self mj_objectArrayWithKeyValuesArray:responseObj];
    }
    return responseObj;
}
@end
