//
//  AccountModel.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"sid" : @"id"};
}
//必需实现这个方法，防止后台返回的字段多一个后者少一个会崩溃的问题
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
