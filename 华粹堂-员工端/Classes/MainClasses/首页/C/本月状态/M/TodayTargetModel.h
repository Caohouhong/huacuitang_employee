//
//  TodayTargetModel.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/23.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodayTargetModel : NSObject
/**
 "id": 1,
 "e_id": 21,
 "datetime": "2017-02-22",
 "task_type": 2,
 "target_customer": "张三",
 "target_contenet": "经络12",
 "target_money": 20012,
 "is_finished": 0,
 "target_sum": 0,
 "bedding_sum": 0,
 "sales_sum": 0,
 "service_sum": 0
*/

/* 编号 */
@property (nonatomic, copy) NSString *sid;
/* 患者姓名 */
@property (nonatomic, copy) NSString *target_customer;
/* 预约项目 */
@property (nonatomic, copy) NSString *target_content;
/* 钱数 */
@property (nonatomic, copy) NSString *target_money;

@end
