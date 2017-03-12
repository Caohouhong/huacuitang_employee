//
//  BodyDetailModel.h
//  华粹堂-员工端
//
//  Created by baichun on 17/3/2.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BodyDetailModel : NSObject
/* 基本体质值 */
@property (nonatomic, copy) NSString *dic_bp_values;
/* 相关证型值*/
@property (nonatomic, copy) NSString *dic_rs_values;
/* 所属脏腑值 */
@property (nonatomic, copy) NSString *dic_organs_values;
/* 所属脏腑其他*/
@property (nonatomic, copy) NSString *dic_organs_others;

/* 客户主诉 */
@property (nonatomic, copy) NSString *customers_complained;
/* 咨询辩证 */
@property (nonatomic, copy) NSString *consulting_dialectical;
/* 调理方案 */
@property (nonatomic, copy) NSString *conditioning_program;
/* 家居养生要求 */
@property (nonatomic, copy) NSString *home_health_req;

@end
