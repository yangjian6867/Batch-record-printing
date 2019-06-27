//
//  NSArray+Addition.h
//  NeiHan
//
//  Created by Charles on 16/5/9.
//  Copyright © 2016年 Com.Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Addition)

/**
 *  数组去重 
 */
- (instancetype)noRepeatArray;

//从json文件读取数组
+ (NSArray *)readLocalFileWithName:(NSString *)name;

@end 
