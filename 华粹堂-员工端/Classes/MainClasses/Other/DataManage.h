//
//  DataManage.h
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/29.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ModelTrackManage;
@class HuiFangModel;

@interface DataManage : NSObject

+ (DataManage *)sharedMemberMySelf;

/**
 保存调理数据
 
 @param modelArray 需要保存的调理的数组
 */
- (void)saveTiaoLiDataWithModelArray:(NSArray *)modelArray;

/**
 获取数据库中调理的数据
 */
- (NSArray *)getTiaoLiModelArray;

/**
 更具id获取指定调理数据model
 */
- (ModelTrackManage *)getModelTrackManageWithSid:(NSString *)sid;

/**
 删除指定调理数据
 */
- (void)deleteModelTrackManageWithSid:(NSString *)sid;

/**
 保存回访数据
 
 @param modelArray 需要保存的回访的数组
 */
- (void)saveHuiFangDataWithModelArray:(NSArray *)modelArray;

/**
 获取数据库中调理的数据数组
 */
- (NSArray *)getHuiFangModelArray;

/**
 更具id获取指定调理数据model
 */
- (HuiFangModel *)getHuiFangModelWithSid:(NSString *)sid;

/**
 删除指定调理数据
 */
- (void)deletHuiFangModelWithSid:(NSString *)sid;

@end
