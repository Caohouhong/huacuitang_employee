//
//  DataManage.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/29.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "DataManage.h"
#import "ModelTrackManage.h"
#import "HuiFangModel.h"

#define DBName @"member.db"
#define TiaoLiTableName @"user_TiaoLi"
#define HuiFangTableName @"user_HuiFang"

static DataManage *dataManage = nil;

@implementation DataManage

+ (DataManage *)sharedMemberMySelf
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dataManage = [[DataManage alloc] init];
        
        YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:DBName];
        NSString *tableName1 = TiaoLiTableName;
        NSString *tableName2 = HuiFangTableName;
        [store createTableWithName:tableName1];
        [store createTableWithName:tableName2];
    });
    return dataManage;
}

#pragma mark - sengleton setting
+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (dataManage == nil)
        {
            dataManage = [super allocWithZone:zone];
        }
    }
    return dataManage;
}

+ (id)copyWithZone:(NSZone *)zone
{
    return self;
}

/**
 保存调理数据

 @param modelArray 需要保存的调理的数组
 */
- (void)saveTiaoLiDataWithModelArray:(NSArray *)modelArray
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:DBName];
    NSString *tableName = TiaoLiTableName;
    [store createTableWithName:tableName];
    
    for (ModelTrackManage *model in modelArray)
    {
        NSDictionary *dic = [model mj_keyValues];
        NSString *key = model.sid;
        [store putObject:dic withId:key intoTable:tableName];
    }
}

/**
 获取数据库中调理的数据数组
 */
- (NSArray *)getTiaoLiModelArray
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:DBName];
    NSString *tableName = TiaoLiTableName;
    [store createTableWithName:tableName];
    
    NSArray *arry = [store getAllItemsFromTable:tableName];
    
    NSMutableArray *modelArray = [NSMutableArray array];
    for (YTKKeyValueItem *valueItem in arry)
    {
        ModelTrackManage *model = [ModelTrackManage mj_objectWithKeyValues:valueItem.itemObject];
        [modelArray addObject:model];
    }
    
    return modelArray;
}

/**
 根据id获取指定调理数据model
 */
- (ModelTrackManage *)getModelTrackManageWithSid:(NSString *)sid
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:DBName];
    NSString *tableName = TiaoLiTableName;
    [store createTableWithName:tableName];
    
    YTKKeyValueItem *valueItem = [store getObjectById:sid fromTable:tableName];
    
    ModelTrackManage *model = [ModelTrackManage mj_objectWithKeyValues:valueItem.itemObject];
    return model;
}

/**
 删除指定调理数据
 */
- (void)deleteModelTrackManageWithSid:(NSString *)sid
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:DBName];
    NSString *tableName = TiaoLiTableName;
    [store createTableWithName:tableName];
    
    [store deleteObjectById:sid fromTable:tableName];

}

/**
 保存回访数据
 @param modelArray 需要保存的回访的数组
 */
- (void)saveHuiFangDataWithModelArray:(NSArray *)modelArray
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:DBName];
    NSString *tableName = HuiFangTableName;
    [store createTableWithName:tableName];
    
    for (HuiFangModel *model in modelArray)
    {
        NSDictionary *dic = [model mj_keyValues];
        NSString *key = model.sid;
        [store putObject:dic withId:key intoTable:tableName];
    }
}

/**
 获取数据库中回访的数据数组
 */
- (NSArray *)getHuiFangModelArray
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:DBName];
    NSString *tableName = HuiFangTableName;
    [store createTableWithName:tableName];
    
    NSArray *arry = [store getAllItemsFromTable:tableName];
    
    NSMutableArray *modelArray = [NSMutableArray array];
    for (YTKKeyValueItem *valueItem in arry)
    {
        HuiFangModel *model = [HuiFangModel mj_objectWithKeyValues:valueItem.itemObject];
        [modelArray addObject:model];
    }
    return modelArray;
}

/**
 更具id获取指定回访数据model
 */
- (HuiFangModel *)getHuiFangModelWithSid:(NSString *)sid
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:DBName];
    NSString *tableName = HuiFangTableName;
    [store createTableWithName:tableName];
    
    YTKKeyValueItem *valueItem = [store getObjectById:sid fromTable:tableName];
    
    HuiFangModel *model = [HuiFangModel mj_objectWithKeyValues:valueItem.itemObject];
    return model;
}

/**
 删除指定调理数据
 */
- (void)deletHuiFangModelWithSid:(NSString *)sid
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:DBName];
    NSString *tableName = HuiFangTableName;
    [store createTableWithName:tableName];
    
    [store deleteObjectById:sid fromTable:tableName];
}

@end
