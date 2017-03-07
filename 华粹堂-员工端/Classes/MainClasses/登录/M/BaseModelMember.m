//
//  BaseModelMember.m
//  ZhouMo
//
//  Created by liqiang on 16/9/18.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "BaseModelMember.h"

@implementation BaseModelMember

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"memberId":@"id"};
}

@end
