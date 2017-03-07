//
//  HuiFangModel.h
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/28.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 "id": 47350,
 "c_id": 90,
 "e_id": 21,
 "s_id": 9,
 "status": 1,
 "visit_time": "2017-02-08 10:09",
 "feedback": "短信问候给其拜年，跟其说我们正常工作了，有时间过来调理。",
 "remark": "",
 "kfsh": 0,
 "dzsh": 1,
 "method": 3,
 "state": 3,
 "customerName": "黄宜玲",
 "customerTel": "18018391801",
 "customerAge": 57,
 "sex": 1,
 "birthday": "1960-07-06",
 "last_consume_time": "2016-12-23 09:40",
 "serverTime": 1487829266

 */

@interface HuiFangModel : NSObject
//预约时间
@property (nonatomic, copy) NSString *serverTime;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *portrait;
@property (nonatomic, copy) NSString *feedback;
@property (nonatomic, copy) NSString *kfsh;
@property (nonatomic, copy) NSString *lastModified;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *visit_time;
@property (nonatomic, copy) NSString *customerAge;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *e_id;
@property (nonatomic, copy) NSString *sid;
@property (nonatomic, copy) NSString *dzsh;
@property (nonatomic, copy) NSString *customerTel;
@property (nonatomic, copy) NSString *c_id;
@property (nonatomic, copy) NSString *s_id;
@property (nonatomic, copy) NSString *last_consume_time;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *customerName;

@property (nonatomic, copy) NSString *uuid;
//员工手机号
@property (nonatomic,copy) NSString *employeeTel;
//是否专家（1－是 0-否）
@property (nonatomic, copy) NSString *isExpert;


@end
