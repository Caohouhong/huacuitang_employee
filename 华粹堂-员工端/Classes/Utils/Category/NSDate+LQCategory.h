//
//  NSDate+LQCategory.h
//  lingdaozhe
//
//  Created by liqiang on 16/4/27.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LQCategory)

/**
 *  秒转分返回string类型
 */
+ (NSString*)TimeformatFromSeconds:(long)seconds;

/**
 *  时戳转string
 *
 *  @param timeFormatStr 时间格式
 *  @param time          时戳
 */
+ (NSString *)dateWithTimeStamp:(long long)timeStamp dateFormat:(NSString *)dateFormat;

/**
 *  NSDate转string
 *
 *  @param timeDate   date
 *  @param dateFormat 时间格式
 *
 *  @return
 */
+ (NSString *)dateStringWithTimeDate:(NSDate *)timeDate dateFormat:(NSString *)dateFormat;

/**
 *  时戳转NSDate
 *
 *  @param timeIntervalInMilliSecond 时戳
 */
+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;

/**
 *  距离当前的时间间隔描述
 */
- (NSString *)timeIntervalDescription;


/**
 *  NSData 转农历字符串
 */
+ (NSString*)getChineseCalendarWithDate:(NSDate *)date;

/**
 *  NSData转中文星期几
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

/**
 *  时间转时戳
 */
+ (long)timeIntervalWithDate:(NSDate *)date;

/**
 获取指定日期的零点时戳
 */
+ (long)getZeroPointTimeIntervalWithDate:(NSDate *)date;

/**
 获取指定日期的24点时戳
 */
+ (long)getTwentyFourPointTimeIntervalWithDate:(NSDate *)date;

/**
 获取今天零点的时间戳
 */
+ (long)getTodayZeroPointTimeInterval;

/**
 获取今天24点的时间戳
 */
+ (long)getTodayTwentyFourPointTimeInterval;

/**
 判断两个日期是否是同一天
 */
+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;


/**
 获取指定date是几号
 */
+ (NSString *)getDayWithDate:(NSDate *)date;

/**
 获取指定date是星期几
 */
+ (NSString *)getWeekdayWithDate:(NSDate *)date;

@end
