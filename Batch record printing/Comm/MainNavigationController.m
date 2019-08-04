//
//  MainNavigationController.m
//  Enterprise
//
//  Created by SG on 2017/3/21.
//  Copyright © 2017年 com.sofn.lky.enterprise. All rights reserved.
//

#import "MainNavigationController.h"
@interface MainNavigationController ()

@end

@implementation MainNavigationController

+(void)initialize{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBarTintColor:[UIColor colorWithRed:85.0/255.0 green:178.0/255.0 blue:50.0/255.0 alpha:1.0]];
    [bar setTintColor:[UIColor whiteColor]];
    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0f],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
