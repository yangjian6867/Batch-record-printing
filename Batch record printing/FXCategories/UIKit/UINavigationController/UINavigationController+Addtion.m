//
//  UINavigationController+Addtion.m
//  Batch record printing
//
//  Created by 杨健 on 2019/6/25.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "UINavigationController+Addtion.h"

@implementation UINavigationController (Addtion)
+(UINavigationController *)getNavWithVC:(UIViewController *)vc{
    return [[self alloc]initWithRootViewController:vc];
}
@end
