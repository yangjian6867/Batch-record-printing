//
//  NSDate+Addition.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NSDate+Addition.h"

@implementation NSDate (Addition)

- (BOOL)isYesterday {

    NSDate * now = [NSDate date];
    NSDate *date = self;
    NSDateFormatter * format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd";
    NSString *createdDate = [format stringFromDate:self];
    NSString *nowDate = [format stringFromDate:now];
    date = [format dateFromString:createdDate];
    now = [format dateFromString:nowDate];
    NSCalendar * celendar = [NSCalendar currentCalendar];
    NSDateComponents * Components = [celendar components:NSCalendarUnitMonth | NSCalendarUnitDay fromDate:now toDate:date options:0];
    return Components.month == 0 && Components.day == 1 && Components.year == 0;
}

- (BOOL)isToday {
    
    NSDate *now = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd";
    NSString *nowDate = [format stringFromDate:now];
    NSString *createDate = [format stringFromDate:self];
    
    return [nowDate isEqualToString:createDate];
    
}

- (BOOL)isThisYear {
    
    //创建日历进行比对
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //获取当前数据年
    NSDateComponents *created =[calendar components:NSCalendarUnitYear fromDate:self];
    
    NSDateComponents *now =[calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return created.year == now.year;
}

- (NSString *)stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFromat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    // yyyy-MM-dd HH:mm:ss zzz
    [dateFormatter setDateFormat:dateFromat];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}


+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
}

//字符串转换为日期
+(NSDate *)nsstringConversionNSDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}

//时间转时间戳
+(NSString *)dateConversionTimeStamp:(NSDate *)date
{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]*1000];
    return timeSp;
}

//获取当前的时间戳
+(NSTimeInterval)getNowTimestamp{
    [self setFormatterWith:@"yyyy-MM-dd HH:mm:ss"];
    //时间转时间戳的方法:
    NSString*timeString = [NSString stringWithFormat:@"%0.f", [[NSDate date] timeIntervalSince1970]];
    return [timeString doubleValue];
}

//将用户选择的日期转换为时间戳
+(NSTimeInterval)getTimestampWith:(NSString *)formatTime andFormatter:(NSString *)format{
    NSDate* date = [[self setFormatterWith:format] dateFromString:formatTime];
    //时间转时间戳的方法:
    NSString*timeString = [NSString stringWithFormat:@"%0.f", [date timeIntervalSince1970]];
    return [timeString doubleValue];
}

//时间戳转时间字符串用于服务器返回的时间戳处理
+ (NSString *)getDateStrFromTimeStamp:(NSTimeInterval)timeStamp format:(NSString *)format{//1561430045000
    NSNumber *timeStampNum = [NSNumber numberWithDouble:timeStamp];
    NSString *timeStampStr = [NSString stringWithFormat:@"%@",timeStampNum];
    
    //获取当前时间戳的位数
    if (timeStampStr.length > 10) {
        timeStamp = timeStamp/1000;
    }
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDateFormatter *formatter = [self setFormatterWith:format];
    NSString *returnString =[formatter stringFromDate:detailDate];
    return returnString;
}

//设置日期格式已经时区
+(NSDateFormatter *)setFormatterWith:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    return formatter;
}


@end
