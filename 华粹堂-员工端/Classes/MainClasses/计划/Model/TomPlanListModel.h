//
//  TomPlanListModel.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/3/2.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 "id": 2,
 "e_id": 21,
 "datetime": "2017-02-23",
 "task_type": 1,
 "target_customer": "李三",
 "target_content": "针灸",
 "target_money": 200,
 "target_sum": 0,
 "bedding_sum": 0,
 "sales_sum": 0,
 "service_sum": 0

 */
@interface TomPlanListModel : NSObject
/* 编号 */
@property (nonatomic, copy) NSString *sid;

@property (nonatomic, copy) NSString *e_id;

@property (nonatomic, copy) NSString *datetime;

@property (nonatomic, copy) NSString *task_type;

@property (nonatomic, copy) NSString *target_customer;

@property (nonatomic, copy) NSString *target_content;

@property (nonatomic, copy) NSString *target_money;

@property (nonatomic, copy) NSString *target_sum;

@property (nonatomic, copy) NSString *bedding_sum;

@property (nonatomic, copy) NSString *sales_sum;

@property (nonatomic, copy) NSString *service_sum;

@end
