//
//  MonthDetailModel.h
//  华粹堂-员工端
//
//  Created by baichun on 17/3/3.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MonthDetailModel : NSObject
/* 客户姓名 */
@property (nonatomic, copy) NSString *customerName;
/* 总结时间 */
@property (nonatomic, copy) NSString *summary_date;
/* 客户类别 */
@property (nonatomic, copy) NSString *customer_dic_libie_id;
/* 客户状态编号 */
@property (nonatomic, copy) NSString *customer_dic_status_id;
/* 本月完成项目 */
@property (nonatomic, copy) NSString *cmpp;
@property (nonatomic, copy) NSString *nmpp;
@property (nonatomic, copy) NSString *nmss;
@property (nonatomic, copy) NSString *nmpm;

/* 本月完成金额 */
@property (nonatomic, copy) NSString *cmpm;
/* 业务经理审核意见 */
@property (nonatomic, copy) NSString *service_manage_view;
/* 总结结果 0 已总结 1未总结 */
@property (nonatomic, copy) NSString *result;
//审核时间
@property (nonatomic, copy) NSString *administrative_date;
@property (nonatomic, copy) NSString *administrative_view;
@property (nonatomic, copy) NSString *administrative_id;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;


@end
