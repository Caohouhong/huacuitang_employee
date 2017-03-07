//
//  DailyDetailModel.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/3/1.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyDetailModel : NSObject
/*id */
@property (nonatomic, copy) NSString *sid;
/*e-id*/
@property (nonatomic, copy) NSString *e_id;

@property (nonatomic, copy) NSString *service_sum;

@property (nonatomic, copy) NSString *service_sum_end;

@property (nonatomic, copy) NSString *money_in_sum;

@property (nonatomic, copy) NSString *money_in_sum_end;

@property (nonatomic, copy) NSString *basetarget_sum;

@property (nonatomic, copy) NSString *basetarget_sum_end;

@property (nonatomic, copy) NSString *money_out_sum;

@property (nonatomic, copy) NSString *money_out_sum_end;

@property (nonatomic, copy) NSString *track_sum;

@property (nonatomic, copy) NSString *visit_sum;

@property (nonatomic, copy) NSString *booking_sum;

@property (nonatomic, copy) NSString *track_sum_unfinish;

@property (nonatomic, copy) NSString *visit_sum_unfinish;

@property (nonatomic, copy) NSString *booking_sum_unfinish;

@property (nonatomic, copy) NSString *flag; //0 - 未填写  1-填写

@property (nonatomic, copy) NSString *contenet;

@end
