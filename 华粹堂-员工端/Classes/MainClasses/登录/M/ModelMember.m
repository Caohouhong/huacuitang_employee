//
//  ModelMember.m
//  ZhouMo
//
//  Created by liqiang on 16/9/18.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "ModelMember.h"
#import "AppDelegate.h"

static ModelMember *instanceModel = nil;

@implementation ModelMember

+ (ModelMember *)sharedMemberMySelf
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instanceModel = [[ModelMember alloc] init];
        BOOL isLogin = [[UserDefaults valueForKey:@"isLogin"] boolValue];
        if (isLogin)
        {
            YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"member.db"];
            NSString *tableName = @"user";
            [store createTableWithName:tableName];
            
            NSDictionary *queryUser = [store getObjectById:@"member" fromTable:tableName];
            NSLog(@"member: %@", queryUser);
            instanceModel = [ModelMember mj_objectWithKeyValues:queryUser];
        }
    });
    return instanceModel;
}

//限制当前对象创建多实例
#pragma mark - sengleton setting
+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (instanceModel == nil) {
            instanceModel = [super allocWithZone:zone];
        }
    }
    return instanceModel;
}

+ (id)copyWithZone:(NSZone *)zone {
    return self;
}

+ (BOOL)isLogin
{
    return [[UserDefaults valueForKey:@"isLogin"] boolValue];
}

+ (void)doLoginWithMemberDic:(NSDictionary *)dic
{
    NSLog(@"=====>%@",dic);
    
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"member.db"];
    NSString *tableName = @"user";
    [store createTableWithName:tableName];
    
    NSString *key = @"member";
    [store putObject:dic withId:key intoTable:tableName];
    
    [UserDefaults setValue:@"1" forKey:@"isLogin"];
    [UserDefaults synchronize];
}

- (void)logOut
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"member.db"];
    NSString *tableName = @"user";
    [store clearTable:tableName];
    
    [UserDefaults removeObjectForKey:@"isLogin"];
    [UserDefaults synchronize];
    
    AppDelegate *del = APPDELEGATE;
    [del logOutHuanXing];
}

@end
