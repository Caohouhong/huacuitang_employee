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
@end
