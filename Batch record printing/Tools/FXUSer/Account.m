//
//  Account.m
//  CityCook
//
//  Created by yang on 16/3/1.
//  Copyright © 2016年 Sichuan City Cooking Brother. All rights reserved.
//

#import "Account.h"

@implementation Account

MJCodingImplementation

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"userId" : @"id"};
}

@end
