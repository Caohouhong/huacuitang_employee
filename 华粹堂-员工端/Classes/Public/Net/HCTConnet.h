//
//  HCTConnet.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/22.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCTConnet : NSObject
//1.0首页信息
+(void)getHomeEmployeePageInfo:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.1本月已（待）服务
+(void)getHomeMonthServe:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.2今明日待服务
+(void)getHomeHealthTomorrow:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.3今日目标
+(void)getHomeDailyWork:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.4本月充值消费业绩
+(void)getHomeEmployPerformance:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.5顾客预约列表
+(void)getHomeHealthBookingV2:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.6顾客预约详情
+(void)getHomeGetHealthBookingDetailV2:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.7调理备忘列表
+(void)getHomeTrack_Forget_List:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.8获取近日总结列表
+(void)getHomeGetWorkSumToday:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.9某人某时的总结
+(void)getHomeAddMyWorkSum:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.10提交自己的总结
+(void)getHomeAddWorkSum:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.11明日计划列表
+(void)getHomeListDailyWorkByTime:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.12添加员工计划
+(void)getHomeAddDailyWork:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.13修改员工计划
+(void)getHomeModifyDailyWork:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.14服务回访
+(void)getHomeTelVisitListV2:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.15获取家居养生方案和调理方案
+(void)getHomeProDetailAndHomeHealth:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.16顾客_添加顾客标签
+(void)getHomeAddCustomerTagV2:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.17提交调理
+(void)getHomeSubmitTrackManagerV2:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.18获取调理详情
+(void)getHomeTrackManagerV2:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.19回访编辑提交
+(void)getHomeModifyTelVisit:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.20添加回访信息
+(void)getHomeAddTelVisit:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.21获得回访详情
+(void)getHomeTelVisit:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

/******************2.顾客详情******************/
// 2.1顾客列表页
+(void)getCustomerListCustomerV2:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

// 2.2顾客详情
+(void)getCustomerInfoV2:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

// 2.3顾客账户详情
+(void)getCustomerAccountInfo:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

// 2.4客户资料
+(void)getCustomerInfo:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
// 2.5生活起居
+(void)getLifeViewController:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
// 2.6气医亚健康
+(void)getSubHealthVC:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
// 2.7体质辩证
+(void)getBodyDetailVC:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
// 2.8调理备忘
+(void)getNurseHealthVC:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
// 2.9体检报告
+(void)getHealthFormVC:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

// 2.10复查跟踪
+(void)getHighTechDetailVC:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
// 2.11高科技跟踪
+(void)getHighTechD2:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
// 2.12月度计划
+(void)getMonthDetailVC:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
// 2.13回访
+(void)getReturnVisitVC:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
// 2.14 私密生活话题
+(void)getSecretTopicVC:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

/**************3.其它（Other）***********/
//3.1版本更新
+(void)getOtherIsUpdate:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//3.2 短信提醒
+(void)getOtherSendAuthCode:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
@end
