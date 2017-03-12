//
//  UserInfoModel.h
//  华粹堂-员工端
//
//  Created by baichun on 17/3/2.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject
/*
"id": 46,
"name": "吴洁",
"phonetic_code": "wj",
"sex": 1,
"birthday": "1954-01-01",
"address": "五爱家园，镇江",
"telephone": "",
"mobile_phone": "18994628456",
"alternate_mobile_phone": "13888888888",
"QQ": "",
"weichat": "",
"profession": "退休",
"work_unit": "",
"family_salary": "很好    消费10000",
"salary": "1",
"marriage": 1,
"child": 1,
"traffic": "私家车",
"past_history": "乳腺增生、甲状腺炎肩颈增生",
"allergy_history": "春季过敏（颜面和皮肤发痒）",
"s_id": 6,
"e_id": 11,
"dic_pink_id": 320,
"dic_status_id": 465,
"dic_source_id": 287,
"dic_source": "隔壁会所老板，由同事介绍过来调理",
"dic_libie_id": 265,
"vip_card": "",
"into_store_time": "2015-06-11 00:00",
"last_consume_time": "2016-01-09 12:50",
"last_contact_time": "2016-06-15 18:35",
"hobby": "-",
"concept_health": "尚可",
"family_associate": "叶祖传",
"mr_consume_habits": "-",
"remark": "",
"istec": 0,
"login_password_new": "",
"imUserName": "aaadsd",
"customerAge": 63,
"ename": "王亚丽"
*/
@property (nonatomic, copy) NSString *ename;

@property (nonatomic, copy) NSString *name;
	/* 新密码(加密) */
@property (nonatomic, copy) NSString *login_password_new;
@property (nonatomic, copy) NSString *sex;
//婚姻
@property (nonatomic, copy) NSString *marriage;
/* 生育情况 */
@property (nonatomic, assign) NSInteger child;
/* 绑定的调理师编号 */
@property (nonatomic, copy) NSString *e_id;
/* 是否桃红会员 */
@property (nonatomic, assign) NSInteger dic_pink_id;
/* 客户状态编号 */
@property (nonatomic, assign) NSInteger dic_status_id;
/* 客户来源 */
@property (nonatomic, copy) NSString *dic_source_id;
/* 来源说明 */
@property (nonatomic, copy) NSString *dic_source;
/* 客户例别 */
@property (nonatomic, assign) NSInteger dic_libie_id;
/* 会员卡号 */
@property (nonatomic, copy) NSString *vip_card;
/* 爱好 */
@property (nonatomic, copy) NSString *hobby;
/* 养生观念 */
@property (nonatomic, copy) NSString *concept_health;
	/* 会员等级 A AA AAA AAAA */
@property (nonatomic, assign) NSInteger vip_level;
/* 是否高科技 */
@property (nonatomic, assign) NSInteger istec;


@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *mobile_phone;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *QQ;
@property (nonatomic, copy) NSString *address;
/* 交通工具 */
@property (nonatomic, copy) NSString *traffic;

@property (nonatomic, copy) NSString *family_salary;
@property (nonatomic, copy) NSString *profession;
/* 门店编号 */
@property (nonatomic, copy) NSString *s_id;
//薪资
@property (nonatomic, copy) NSString *salary;

//工作单位
@property (nonatomic, copy) NSString *work_unit;

// 过敏史
@property (nonatomic, copy) NSString *allergy_history;
/* 既往史 */
@property (nonatomic, copy) NSString *past_history;

// 进店时间
@property (nonatomic, copy) NSString *into_store_time;
// 最后消费时间
@property (nonatomic, copy) NSString *last_consume_time;
@property (nonatomic, copy) NSString *activityStatus;
@property (nonatomic, copy) NSString *customer_rating;


// 最后联系时间
@property (nonatomic, copy) NSString *last_contact_time;

/* 家庭关联会员 */
@property (nonatomic, copy) NSString *family_associate;
/* 美容院消费习惯 */
@property (nonatomic, copy) NSString *mr_consume_habits;
/* 备注 */
@property (nonatomic, copy) NSString *remark;

@end
