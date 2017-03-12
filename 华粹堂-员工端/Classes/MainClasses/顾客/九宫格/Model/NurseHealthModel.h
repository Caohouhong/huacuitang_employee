//
//  NurseHealthModel.h
//  华粹堂-员工端
//
//  Created by baichun on 17/3/3.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NurseHealthModel : NSObject


@property (nonatomic, copy) NSString *home_health_req;

/* 调理方案 */
@property (nonatomic, copy) NSString *d_program_detail;
/*咨询辩证/调理项目/其它项目 */
@property (nonatomic, copy) NSString *dialectics_program;
/* 总分 */
@property (nonatomic, copy) NSString *con_home_heal_value_total;
/* 8个分 */
@property (nonatomic, copy) NSString *total_string;
/* 到店情况 */
@property (nonatomic, copy) NSString *con_home_heal;
//客户综合反馈
@property (nonatomic, copy) NSString *con_eva;

/*院长审核意见*/
@property (nonatomic, copy) NSString *dean_check_view;
@property (nonatomic, copy) NSString *dean_check_date;
@property (nonatomic, copy) NSString *dean_name;


/*专家审核意见*/
@property (nonatomic, copy) NSString *expert_check_view;
@property (nonatomic, copy) NSString *expert_check_date;
@property (nonatomic, copy) NSString *expert_name;


@property (nonatomic, copy) NSString *track_date;


@end
