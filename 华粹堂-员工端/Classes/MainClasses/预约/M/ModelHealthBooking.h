//
//  ModelHealthBooking.h
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/16.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelHealthBooking : NSObject

/* 状态 1-已 0－未 */
@property (nonatomic, copy) NSString *state;

/* 编号 */
@property (nonatomic, copy) NSString *sid;
/* 客户编号 */
@property (nonatomic, copy) NSString *c_id;
/* 专家编号 */
@property (nonatomic, copy) NSString *e_expert_id;
/* 陪诊人员编号 */
@property (nonatomic, copy) NSString *e_pz_id;
/* 调理师编号 */
@property (nonatomic, copy) NSString *e_cd_id;
/* 门店编号 */
@property (nonatomic, copy) NSString *s_id;
/* 初诊/复诊，常量 */
@property (nonatomic, copy) NSString *first_or_more;
/* 预约开始时间 */
@property (nonatomic, copy) NSString *book_start_time;
/* 预约结束时间 */
@property (nonatomic, copy) NSString *book_end_time;
/* 预约结果 */
@property (nonatomic, copy) NSString *book_result;
/* 预约项目 */
@property (nonatomic, copy) NSString *book_program;
/* 首要需求 */
@property (nonatomic, copy) NSString *book_purpose;
/* 预约类型 1－专家看诊 0-非 */
@property (nonatomic, copy) NSString *book_type;
/* 备注 */
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *portrait;
@property (nonatomic, copy) NSString *mobile_phone;
@property (nonatomic, copy) NSString *name;
/* 冗余 */
/*店面 */
@property (nonatomic, copy) NSString *s_name;

/////////////////////////////////////////////////////////////////
/*客户姓名*/
@property (nonatomic, copy) NSString *customerName;
/* 调理师姓名 */
@property (nonatomic, copy) NSString *employeeName;
/*跟踪日期/调理日期/项目日期 */
@property (nonatomic, copy) NSString *track_date;
/*填写人编号 */
@property (nonatomic, copy) NSString *e_id;
/*年龄*/
@property (nonatomic, copy) NSString *customerAge;
/*回访时间*/
@property (nonatomic, copy) NSString *visit_time;

//手机号
@property (nonatomic, copy) NSString *employeeTel;

//回访手机号
@property (nonatomic ,copy) NSString *customerTel;
//调理手机号
@property (nonatomic,copy) NSString *customerMobilePhone;

//性别（1-女 2-男） //H 测试
@property (nonatomic,copy) NSString *sex;

/* 目标 */
@property (nonatomic,copy) NSString *aims;
/* 目标项目 */
@property (nonatomic,copy) NSString *aimContent;

@end
