//
//  NSFileManager+Paths.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Paths)

/**
 Get URL of Documents directory.
 
 @return Documents directory URL.
 */
+ (NSURL *)documentsURL;

/**
 Get path of Documents directory.
 
 @return Documents directory path.
 */
+ (NSString *)documentsPath;

/**
 Get URL of Library directory.
 
 @return Library directory URL.
 */
+ (NSURL *)libraryURL;

/**
 Get path of Library directory.
 
 @return Library directory path.
 */
+ (NSString *)libraryPath;

/**
 Get URL of Caches directory.
 
 @return Caches directory URL.
 */
+ (NSURL *)cachesURL;

/**
 Get path of Caches directory.
 
 @return Caches directory path.
 */
+ (NSString *)cachesPath;

+(NSString *)accountPath;

/**
 Adds a special filesystem flag to a file to avoid iCloud backup it.
 如果我们的APP需要存放比较大的文件的时候，同时又不希望被系统清理掉，那我么我们就需要把我们的资源保存在Documents目录下，但是我们又不希望他会被iCloud备份，
 @param path Path to a file to set an attribute.
 */
+ (BOOL)addSkipBackupAttributeToFile:(NSString *)path;

/**
 Get available disk space.
 
 @return An amount of available disk space in Megabytes.
 */
+ (double)availableDiskSpace;

//判断文件是否存在
+(BOOL)isFileExistInDirectory:(NSSearchPathDirectory)directory with:(NSString *)fileName;

@end
