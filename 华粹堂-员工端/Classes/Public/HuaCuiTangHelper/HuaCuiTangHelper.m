//
//  HuaCuiTangHelper.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/23.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "HuaCuiTangHelper.h"

@implementation HuaCuiTangHelper

/**********日期处理**********/
/**
 获取当前日期格式为2017年12月
 */
+ (NSString *)getCurrentDateWithStyleYYYYMM{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY年MM月"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

/**
 获取当前日期格式为2017年12月1日
 */
+ (NSString *)getCurrentDateWithStyleYYYYMMDD{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

/**
 获取当前日期格式自定义
 */
+ (NSString *)getCurrentDateWithStyleStr:(NSString *)style{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:style];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

/**
 给生日计算岁数 (1991-01-01)
*/
+ (NSString *)getYearsWithBirthDay:(NSString *)Str
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *oldData = [dateFormatter dateFromString:Str];
    [dateFormatter setDateFormat:@"YYYY"];
    NSString *oldStr = [dateFormatter stringFromDate:oldData];
    NSString *newStr = [dateFormatter stringFromDate:[NSDate date]];

    NSString *year = [NSString stringWithFormat:@"%i",(int)newStr - (int)oldStr];
    
    return year;
    
}
/**
   当前月份的上一个月下一月 (-1上一月  ＋3下三月)
 */
+ (NSString *)getPriousorLaterDateFromNowWithMonth:(int)month
{
    NSDate *date = [[NSDate alloc] init];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setMonth:month];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY年MM月"];
    NSString *dateString = [dateFormatter stringFromDate:mDate];
    
    return dateString;
}

/**
 当前日期的上一天下一天 (-1上一天  ＋3下三天)
 */
+ (NSString *)getPriousorLaterDateFromNowWithDay:(int)day
{
    NSDate *date = [[NSDate alloc] init];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setDay:day];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日"];
    NSString *dateString = [dateFormatter stringFromDate:mDate];
    
    return dateString;
}

/**
 根据时间戳转时间
 */
+ (NSString *)changeTimeStyleWithTimeStemp:(NSString *)time{
    //时间戳转日期
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日 HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

/**
   NSDate转时间戳
*/
+ (NSString *)changeDateToTimeStmp:(NSDate *)date{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];

    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[localeDate timeIntervalSince1970]];
    return timeSp;
}

/**
   "visit_time" : "2017-01-23 09:52",转时间戳
 */
+ (NSString *)changeTimeToTimeStmp:(NSString *)string{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *mDate = [dateFormatter dateFromString:string];
    
    NSString *timeStmp = [self changeDateToTimeStmp:mDate];

    return timeStmp;
}

/*********字体处理**********/
/**
 改变具体字的颜色
 */
+ (NSMutableAttributedString *)changeTextColorWithRestltStr:(NSString *)result changeText:(NSString *)text andColor:(UIColor *)color{
    
    NSMutableAttributedString *attributuStr = [[NSMutableAttributedString alloc] initWithString:result];
    if (text.length > 0){
        
        NSRange textRange = NSMakeRange([[attributuStr string] rangeOfString:text].location, [[attributuStr string] rangeOfString:text].length);
        [attributuStr addAttribute:NSForegroundColorAttributeName value:color range:textRange];
    }
    return attributuStr;
}


//转json
+(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//NSString - json
+(NSString *)JSONString:(NSString *)aString {
    NSMutableString *s = [NSMutableString stringWithString:aString];
    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}

@end
