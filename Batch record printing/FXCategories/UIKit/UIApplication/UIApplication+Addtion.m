//
//  UIApplication+Addtion.m
//  Batch record printing
//
//  Created by 杨健 on 2019/6/25.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "UIApplication+Addtion.h"

@implementation UIApplication (Addtion)

+(void)changeRootVC:(UIViewController *)rootVC{
    [self sharedApplication].keyWindow.rootViewController = rootVC;
}

@end
