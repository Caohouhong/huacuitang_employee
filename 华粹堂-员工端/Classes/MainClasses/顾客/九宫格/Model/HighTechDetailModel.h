//
//  HighTechDetailModel.h
//  华粹堂-员工端
//
//  Created by baichun on 17/3/3.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HighTechDetailModel : NSObject
/*客户姓名*/
@property (nonatomic, copy) NSString *customerName;
/*客户主诉 */
@property (nonatomic, copy) NSString *customers_complained;
/*咨询辩证/调理项目/其它项目 */
@property (nonatomic, copy) NSString *dialectics_program;
/*调理方案 */
@property (nonatomic, copy) NSString *d_program_detail;
/*家居养生要求 */
@property (nonatomic, copy) NSString *home_health_req;
/*其它说明/调理说明/项目说明 */
@property (nonatomic, copy) NSString *other_description;
/*方案制定人 */
@property (nonatomic, copy) NSString *makers;
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, copy) NSString *exEva;
/*院长审核意见*/
@property (nonatomic, copy) NSString *dean_check_view;
/*专家审核意见*/
@property (nonatomic, copy) NSString *expert_check_view;
/*院长审核日期 */
@property (nonatomic, copy) NSString *dean_check_date;
@property (nonatomic, copy) NSString *dean_name;


/*专家审核日期 */
@property (nonatomic, copy) NSString *expert_check_date;
@property (nonatomic, copy) NSString *expert_name;


@property (nonatomic, copy) NSString *con_eva;

@end
