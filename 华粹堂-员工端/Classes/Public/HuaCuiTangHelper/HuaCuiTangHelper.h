//
//  HuaCuiTangHelper.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/23.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HuaCuiTangHelper : NSObject

+ (NSString *)getCurrentDateWithStyleYYYYMM;
+ (NSString *)getCurrentDateWithStyleYYYYMMDD;
+ (NSString *)getPriousorLaterDateFromNowWithMonth:(int)month;
+ (NSString *)getPriousorLaterDateFromNowWithDay:(int)day;
+ (NSString *)getYearsWithBirthDay:(NSString *)Str;
+ (NSString *)getCurrentDateWithStyleStr:(NSString *)style;
+ (NSString *)changeTimeStyleWithTimeStemp:(NSString *)time;

+ (NSMutableAttributedString *)changeTextColorWithRestltStr:(NSString *)result changeText:(NSString *)text andColor:(UIColor *)color;

//转json
+(NSString*)DataTOjsonString:(id)object;
+(NSString *)JSONString:(NSString *)aString;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end
