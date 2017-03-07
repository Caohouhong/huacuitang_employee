//
//  UserDefalutModel.m
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/28.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "UserDefalutModel.h"

#define MODELM @"modelM"
@implementation UserDefalutModel

MJCodingImplementation

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"sid" : @"id"};
}

+(void)setUserM:(UserDefalutModel *)modelM {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:modelM];
    [userDefaults setObject:data
                     forKey:MODELM];
    [userDefaults synchronize];
}

+(UserDefalutModel *)getmodelM {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults
                    objectForKey:MODELM];
    UserDefalutModel *modelM = nil;
    if (data) {
        modelM = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return modelM;
}


@end
