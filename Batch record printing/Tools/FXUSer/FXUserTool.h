//
//  FXUserTool.h
//  CityCook
//
//  Created by yang on 16/3/1.
//  Copyright © 2016年 Sichuan City Cooking Brother. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Account.h"

@interface FXUserTool : NSObject

single_interface(FXUserTool)

- (void)saveAccount:(Account*)account;

@property (nonatomic,strong)Account *account;

@end
