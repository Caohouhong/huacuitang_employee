//
//  ServeModel.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/23.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServeModel : NSObject

/*
 "id": 65721,
 "c_id": 3067,
 "e_cd_id": 177,
 "s_id": 9,
 "book_start_time": "2017-02-10 16:30",
 "book_end_time": "2017-02-10 18:00",
 "book_result": 0,
 "book_program": "灸",
 "book_type": 0,
 "remark": "",
 "name": "赵博",
 "seriveNum": 0,
 "serviceTotal": 12
 */

/* 编号 */
@property (nonatomic, copy) NSString *sid;
/* 客户编号 */
@property (nonatomic, copy) NSString *c_id;
/* 调理师编号 */
@property (nonatomic, copy) NSString *e_cd_id;
/* 门店编号 */
@property (nonatomic, copy) NSString *s_id;
/* 预约开始时间 */
@property (nonatomic, copy) NSString *book_start_time;
/* 预约结束时间 */
@property (nonatomic, copy) NSString *book_end_time;
/* 预约结果 */
@property (nonatomic, copy) NSString *book_result;
/* 预约项目 */
@property (nonatomic, copy) NSString *book_program;
/* 预约类型 1－专家看诊 0-非 */
@property (nonatomic, copy) NSString *book_type;
/* 患者姓名 */
@property (nonatomic, copy) NSString *name;
/* 已服务次数 */
@property (nonatomic, copy) NSString *serviceNum;
/* 已服务人次 */
@property (nonatomic, copy) NSString *serviceTotal;
/* 到店提醒  1 已提醒  0 － 未提醒 */
@property (nonatomic, copy) NSString *isRemind;
/* 电话 */
@property (nonatomic, copy) NSString *mobile_phone;
/* 门面名字 */
@property (nonatomic, copy) NSString *s_name;
@end
