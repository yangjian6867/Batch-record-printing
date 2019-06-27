//
//  UIScreen+Addtion.m
//  Batch record printing
//
//  Created by 杨健 on 2019/6/25.
//  Copyright © 2019 杨健. All rights reserved.
//

#import "UIScreen+Addtion.h"

@implementation UIScreen (Addtion)
+(CGFloat)screen_width{
    return [self mainScreen].bounds.size.width;
}

+(CGFloat)screen_height{
    return [self mainScreen].bounds.size.height;
}

@end
