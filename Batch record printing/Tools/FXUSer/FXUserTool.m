//
//  FXUserTool.m
//  CityCook
//
//  Created by yang on 16/3/1.
//  Copyright © 2016年 Sichuan City Cooking Brother. All rights reserved.
//

#import "FXUserTool.h"

//保存账户信息
#define kAccountFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation FXUserTool

single_implementation(FXUserTool)

- (id)init{
    if (self = [super init]) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountFile];
    }
    return self;
}

- (void)saveAccount:(Account*)account
{
    _account = account;
    [NSKeyedArchiver archiveRootObject:account toFile:kAccountFile];
    
}

@end
