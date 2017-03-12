//
//  SubHealthModel.h
//  华粹堂-员工端
//
//  Created by baichun on 17/3/2.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubHealthModel : NSObject
/* 精神值 */
@property (nonatomic, copy) NSString *dic_mind_values;
/* 精神其它 */
@property (nonatomic, copy) NSString *dic_mind_others;
/* 面色值 */
@property (nonatomic, copy) NSString *dic_cp_values;
/* 面色其它 */
@property (nonatomic, copy) NSString *dic_cp_others;
/* 体感值 */
@property (nonatomic, copy) NSString *dic_ss_values;
/* 体感其它 */
@property (nonatomic, copy) NSString *dic_ss_others;
/* 妇科值 */
@property (nonatomic, copy) NSString *dic_gnl_values;
/* 妇科其它 */
@property (nonatomic, copy) NSString *dic_gnl_others;
/* 肾气值 */
@property (nonatomic, copy) NSString *dic_kidneyQi_values;
/* 肾气其它 */
@property (nonatomic, copy) NSString *dic_kidneyQi_others;
/* 心值(火) */
@property (nonatomic, copy) NSString *dic_heart_values;
/* 心其它(火其他) */
@property (nonatomic, copy) NSString *dic_heart_others;
/* 肝值 (木)*/
@property (nonatomic, copy) NSString *dic_liver_values;
/* 肝其它(木其他) */
@property (nonatomic, copy) NSString *dic_liver_others;
/* 脾值 （土）*/
@property (nonatomic, copy) NSString *dic_spleen_values;
/* 脾其它(土其他) */
@property (nonatomic, copy) NSString *dic_spleen_others;
/* 肺值 (金)*/
@property (nonatomic, copy) NSString *dic_lung_values;
/* 肺其它(金其他) */
@property (nonatomic, copy) NSString *dic_lung_others;
/* 肾值  (水)*/
@property (nonatomic, copy) NSString *dic_kidney_values;
/* 肾其它(水其他) */
@property (nonatomic, copy) NSString *dic_kidney_others;
/* 首要需求 */

@property (nonatomic, copy) NSString *solve_problem;
/* 症状备注 */
@property (nonatomic, copy) NSString *symptom_remark;
/* 舌质值*/
@property (nonatomic, copy) NSString *dic_tongueZ_values;
/* 舌质其他 */
@property (nonatomic, copy) NSString *dic_tongueZ_others;
/* 舌苔值 */
@property (nonatomic, copy) NSString *dic_tongueT_values;
/* 舌苔其他 */
@property (nonatomic, copy) NSString *dic_tongueT_others;

@end
