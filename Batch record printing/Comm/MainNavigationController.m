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


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}



@end
