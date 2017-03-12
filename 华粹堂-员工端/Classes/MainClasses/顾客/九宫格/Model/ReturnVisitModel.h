//
//  ReturnVisitModel.h
//  华粹堂-员工端
//
//  Created by baichun on 17/3/6.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReturnVisitModel : NSObject
/*备注*/
@property (nonatomic, copy) NSString *remark;
/*客户名字*/
@property (nonatomic, copy) NSString *customerName;
/*回访时间*/
@property (nonatomic, copy) NSString *visit_time;
/*反馈信息*/
@property (nonatomic, copy) NSString *feedback;
/*院长审核意见*/
@property (nonatomic, copy) NSString *dean_check_view;
/*专家审核意见*/
@property (nonatomic, copy) NSString *expert_check_view;

@property (nonatomic, copy) NSString *employeeName;

/*院长审核意见*/

@property (nonatomic, copy) NSString *dean_check_date;
@property (nonatomic, copy) NSString *dean_name;


/*专家审核意见*/

@property (nonatomic, copy) NSString *expert_check_date;
@property (nonatomic, copy) NSString *expert_name;
@end
