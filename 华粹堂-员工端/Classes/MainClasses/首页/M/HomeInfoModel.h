//
//  HomeInfoModel.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/3/8.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 "employee_name": "徐有萍",
 "shopName": "无锡奥林",
 "employee_level": 3,
 "service_finished_sum": 2,
 "service_wait_sum": 1,
 "service_twoDay_wait_sum": 0,
 "money_in_sum": 0,
 "money_out_sum": 0,
 "goal_sum": 0

 */
@interface HomeInfoModel : NSObject

@property (nonatomic, copy) NSString * employee_name;

@property (nonatomic, copy) NSString * shopName;

@property (nonatomic, copy) NSString * employee_level; //等级

@property (nonatomic, copy) NSString * service_finished_sum;//本月已服务

@property (nonatomic, copy) NSString * service_wait_sum;//待服务

@property (nonatomic, copy) NSString * service_twoDay_wait_sum;

@property (nonatomic, copy) NSString * money_in_sum;

@property (nonatomic, copy) NSString * money_out_sum;

@property (nonatomic, copy) NSString * goal_sum;

@end
