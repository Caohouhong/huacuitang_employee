//
//  NetUrlMacro.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/22.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#ifndef NetUrlMacro_h
#define NetUrlMacro_h
#endif /* NetUrlMacro_h */

//#define BASE_URL_REl @"http://115.28.148.32/App"

//#define BASE_URL_REl @"http://192.168.1.167:8080/zmapiprj"

#define BASE_URL_REl @"http://luwl.s1.natapp.cc"

/*******************首页*********************/
//1.0 首页信息
#define HOME_GET_EMPLOY_HOME_PAGE_INFO   BASE_URL_REl@"/webService/employee/getEmployeeHomePageInof"

//1.1本月已(待)服务
#define HOME_MONTH_SERVE         BASE_URL_REl@"/webService/healthBooking/listHealthBookingForMonth"

//1.2今明日待服务
#define HOME_HEALTH_TOMORROW     BASE_URL_REl@"/webService/healthBooking/listHealthBookingForTomorrow"

//1.3本月充值（消费）业绩
#define HOME_EMPLOY_PERFORMANCE         BASE_URL_REl@"/webService/employee/getEmployeePerformance"

//1.4今日目标
#define HOME_GET_DAILY_WORK      BASE_URL_REl@"/webService/employee/getDaliyWorkOfToday"

//1.5顾客预约列表
#define HOME_HEALTHBOOKING_V2    BASE_URL_REl@"/webService/healthBooking/listHealthBookingsV2"

//1.6顾客预约详情
#define HOME_GET_HEALTHBOOKING_V2    BASE_URL_REl@"/webService/healthBooking/getHealthBookingV2"

//1.7首页调理备忘列表
#define HOME_GET_TRACK_FORGET_EMPLOYEE    BASE_URL_REl@"/webService/trackManage/listTrackManageOfForgetForEmployee"

//1.8今日总结列表
#define HOME_GET_WORK_SUM_TODAY    BASE_URL_REl@"/webService/employee/getWorkSummaryToday"

//1.9某人某时总结
#define HOME_GET_ADD_MY_WORK_SUM   BASE_URL_REl@"/webService/employee/getSomeOneWorkSummary"

//1.10提交总结
#define HOME_GET_ADD_WORK_SUM   BASE_URL_REl@"/webService/employee/addWorkSummary"

//1.11明日计划列表
#define HOME_GET_LIST_DAILY_WORK_BY_TIME   BASE_URL_REl@"/webService/employee/listDaliyWorkByTime"

//1.12添加员工计划
#define HOME_GET_ADD_DAILY_WORK   BASE_URL_REl@"/webService/employee/addDaliyWork"

//1.13修改员工计划
#define HOME_GET_MODIFY_DAILY_WORK   BASE_URL_REl@"/webService/employee/modifyDaliyWork"

//1.14服务回访
#define HOME_GET_LIST_TELE_VISIT_V2   BASE_URL_REl@"/webService/telephonevisit/listTelephonevisitsV2"

//1.15 获取家居养生方案和调理方案
#define HOME_GET_PRODETAIL_HOME_HEALTH   BASE_URL_REl@"/webService/trackManage/getProgramDetailAndHomeHealth"

//1.16 顾客_添加顾客标签
#define HOME_ADD_CUSTOMER_TAG_V2   BASE_URL_REl@"/webService/customer/addCustomerTagV2"

//1.17 提交调理
#define HOME_SUBMIT_TRACK_MANAGER_V2   BASE_URL_REl@"/webService/trackManage/submitTrackManageV2"

//1.18 获取调理详情
#define HOME_GET_TRACK_MANAGE_V2   BASE_URL_REl@"/webService/trackManage/getTrackManageV2"

//1.19 回访编辑提交
#define HOME_GET_MODIFY_TEL_VISIT   BASE_URL_REl@"/webService/telephonevisit/modifyTelephonevisit"

//1.20 添加回访信息
#define HOME_GET_ADD_TEL_VISIT   BASE_URL_REl@"/webService/telephonevisit/addTelephonevisit"

//1.21 回访详情
#define HOME_GET_TEL_VISIT   BASE_URL_REl@"/webService/telephonevisit/getTelephonevisit"

/********************2.顾客详情(customer)***********************/
//2.1顾客列表
#define CUSTOMER_GET_LIST_CUSTOMER_V2    BASE_URL_REl@"/webService/customer/listCustomersV2"

//2.2顾客详情页
#define CUSTOMER_GET_CUSTOMER_V2    BASE_URL_REl@"/webService/customer/getCustomerV2"

//2.3账户信息
#define CUSTOMER_ACCOUNT_INFO    BASE_URL_REl@"/webService/customer/viewCustomerAccountInfo"
//2.4 客户资料
#define CUSTOMER_CUSTOMER_INFO    BASE_URL_REl@"/webService/customer/viewCustomerInfo"
//2.5 生活起居
#define CUSTOMER_AIRMED    BASE_URL_REl@"/webService/customer/viewAirmedicalhealth"
//2.6 气医亚健康
#define CUSTOMER_HEALTH    BASE_URL_REl@"/webService/customer/viewAirmedicalhealth2"

//2.7 体质辨证
#define CUSTOMER_TIZHIBIANZHENG    BASE_URL_REl@"/webService/customer/viewAirmedicalhealth3"
//2.8 调理备忘
#define TRACK_FIRSTTRACK    BASE_URL_REl@"/webService/trackManage/getTrackManageForCustomerView"
//2.9 体检报告
#define CUSTOMER_TIJIAN    BASE_URL_REl@"/webService/customer/viewtijianReport"
//3.0 复诊跟踪
#define TRACK_FOR    BASE_URL_REl@"/webService/trackManage/getTrackManageForCustomerView"
//3.1 高科技跟踪
#define TRACK_FORDOCTOR    BASE_URL_REl@"/webService/trackManage/getTrackManageForCustomerView"
//3.2 月度规划
#define EMPLOYEE_FOR    BASE_URL_REl@"/webService/employee/getMcspForCustomer"

//3.3 回访
#define TELEPHONE    BASE_URL_REl@"/webService/telephonevisit/getTelephoneVisitLately"
//3.4 私密生活话题
#define TOMERTAGS    BASE_URL_REl@"/webService/customer/listCustomerTagsV2"


/**************3.其它（Others）***************/
//3.0 版本更新
#define O_IS_UPDATE_URL    BASE_URL_REl@"/webService/employee/isPpgrade"

//3.1 短信提醒
#define O_IS_SEND_AUTH_CODE    BASE_URL_REl@"/webService/customer/sendAuthCode"

