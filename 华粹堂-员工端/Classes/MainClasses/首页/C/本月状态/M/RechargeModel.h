//
//  RechargeModel.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/23.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RechargeModel : NSObject
/**
 "id": 1,
 "perf_month": 11,
 "money_out_sum": 208,
 "perf_year": 2016,
 "goods0_in_sum": 0,
 "goods0_out_sum": 2,
 "goods1_in_sum": 3,
 "goods1_out_sum": 0,
 "goods2_in_sum": 0,
 "goods2_out_sum": 6,
 "goods3_in_sum": 0,
 "goods3_out_sum": 8,
 "goods4_in_sum": 0,
 */

/* 编号 */
@property (nonatomic, copy) NSString *sid;
/* 患者姓名 */
@property (nonatomic, copy) NSString *money_out_sum;
/* 针灸充值 */
@property (nonatomic, copy) NSString *goods0_in_sum;
/* 针灸消费 */
@property (nonatomic, copy) NSString *goods0_out_sum;

/* 经络充值 */
@property (nonatomic, copy) NSString *goods1_in_sum;
/* 经络消费 */
@property (nonatomic, copy) NSString *goods1_out_sum;

/* 体质充值 */
@property (nonatomic, copy) NSString *goods2_in_sum;
/* 体质消费 */
@property (nonatomic, copy) NSString *goods2_out_sum;

/* 服务充值 */
@property (nonatomic, copy) NSString *goods3_in_sum;
/* 服务消费 */
@property (nonatomic, copy) NSString *goods3_out_sum;

/* 其它充值 */
@property (nonatomic, copy) NSString *goods4_in_sum;
/* 其它消费 */
@property (nonatomic, copy) NSString *goods4_out_sum;


@end
