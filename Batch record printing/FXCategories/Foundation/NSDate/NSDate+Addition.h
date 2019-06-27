//
//  NSDate+Addition.h
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Addition)

/**
 *  判断是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  判断是否为今天
 */
- (BOOL)isToday;

/**
 *  判断是否为今年
 */
- (BOOL)isThisYear;

- (NSString *)stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFromat;

+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;


//获取当前时间戳
+(NSTimeInterval)getNowTimestamp;

//将用户选择的日期转换为时间戳
+(NSTimeInterval)getTimestampWith:(NSString *)formatTime andFormatter:(NSString *)format;
//通过时间戳来获取时间日期字符串用于服务器返回的时间戳处理
+(NSString *)getDateStrFromTimeStamp:(NSTimeInterval)timeStamp format:(NSString *)format;

@end
