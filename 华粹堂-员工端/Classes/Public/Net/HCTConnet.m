//
//  HCTConnet.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/22.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "HCTConnet.h"
#import "Connect.h"

@implementation HCTConnet

//1.0首页信息
+(void)getHomeEmployeePageInfo:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_GET_EMPLOY_HOME_PAGE_INFO parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}


//1.1本月已（待）服务
+(void)getHomeMonthServe:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_MONTH_SERVE parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

//1.2今明日待服务
+(void)getHomeHealthTomorrow:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_HEALTH_TOMORROW parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}


//1.3今日目标
+(void)getHomeDailyWork:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:HOME_GET_DAILY_WORK parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];

}

//1.4本月充值消费业绩
+(void)getHomeEmployPerformance:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:HOME_EMPLOY_PERFORMANCE parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

//1.5顾客预约列表
+(void)getHomeHealthBookingV2:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:HOME_HEALTHBOOKING_V2 parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

//1.6顾客预约详情
+(void)getHomeGetHealthBookingDetailV2:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:HOME_GET_HEALTHBOOKING_V2 parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

//1.7调理备忘列表
+(void)getHomeTrack_Forget_List:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:HOME_GET_TRACK_FORGET_EMPLOYEE parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

//1.8获取今日总结列表
+(void)getHomeGetWorkSumToday:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:HOME_GET_WORK_SUM_TODAY parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

//1.9某人某时总结
+(void)getHomeAddMyWorkSum:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:HOME_GET_ADD_MY_WORK_SUM parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

//1.10提交自己的总结
+(void)getHomeAddWorkSum:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:HOME_GET_ADD_WORK_SUM parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

//1.11明日计划列表
+(void)getHomeListDailyWorkByTime:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:HOME_GET_LIST_DAILY_WORK_BY_TIME parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

//1.12添加员工计划
+(void)getHomeAddDailyWork:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:HOME_GET_ADD_DAILY_WORK parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

//1.13修改员工计划
+(void)getHomeModifyDailyWork:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:HOME_GET_MODIFY_DAILY_WORK parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

//1.14服务回访
+(void)getHomeTelVisitListV2:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:HOME_GET_LIST_TELE_VISIT_V2 parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

//1.15获取家居养生方案和调理方案
+(void)getHomeProDetailAndHomeHealth:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:HOME_GET_PRODETAIL_HOME_HEALTH parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

//1.16顾客_添加顾客标签
+(void)getHomeAddCustomerTagV2:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:HOME_ADD_CUSTOMER_TAG_V2 parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

//1.17提交调理
+(void)getHomeSubmitTrackManagerV2:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:HOME_SUBMIT_TRACK_MANAGER_V2 parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

//1.18获取调理详情
+(void)getHomeTrackManagerV2:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:HOME_GET_TRACK_MANAGE_V2 parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

//1.19回访编辑提交
+(void)getHomeModifyTelVisit:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:HOME_GET_MODIFY_TEL_VISIT parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

//1.20添加回访信息
+(void)getHomeAddTelVisit:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:HOME_GET_ADD_TEL_VISIT parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

//1.21获得回访详情
+(void)getHomeTelVisit:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:HOME_GET_TEL_VISIT parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}



/******************2.顾客详情******************/
// 2.1顾客列表页
+(void)getCustomerListCustomerV2:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:CUSTOMER_GET_LIST_CUSTOMER_V2 parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

// 2.2顾客详情
+(void)getCustomerInfoV2:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:CUSTOMER_GET_CUSTOMER_V2 parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}



// 2.3账户信息
+(void)getCustomerAccountInfo:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:CUSTOMER_ACCOUNT_INFO parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}
// 2.4客户资料
+(void)getCustomerInfo:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:CUSTOMER_CUSTOMER_INFO parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}
//2.5生活起居
+(void)getLifeViewController:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:CUSTOMER_AIRMED parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}
// 2.6气医亚健康
+(void)getSubHealthVC:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:CUSTOMER_HEALTH parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];    
}
// 2.7体质辩证
+(void)getBodyDetailVC:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:CUSTOMER_TIZHIBIANZHENG parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}
// 2.8调理备忘
+(void)getNurseHealthVC:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:TRACK_FIRSTTRACK parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}
// 2.9体检报告
+(void)getHealthFormVC:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:CUSTOMER_TIJIAN parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
 
}
// 2.10复查跟踪
+(void)getHighTechDetailVC:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:TRACK_FOR parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}
// 2.11高科技跟踪
+(void)getHighTechD2:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:TRACK_FORDOCTOR parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}
// 2.12月度计划
+(void)getMonthDetailVC:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:EMPLOYEE_FOR parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}
// 2.13回访
+(void)getReturnVisitVC:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:TELEPHONE parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

//2.14 私密生活话题
+(void)getSecretTopicVC:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:TOMERTAGS parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

/*****************3.其它（other）******************/
//3.1 版本更新
+(void)getOtherIsUpdate:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:O_IS_UPDATE_URL parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

//3.2 短信提醒
+(void)getOtherSendAuthCode:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    Connect *con=[Connect sharedInstance];
    
    [con doTestPostNetWorkWithUrl:O_IS_SEND_AUTH_CODE parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}


@end
