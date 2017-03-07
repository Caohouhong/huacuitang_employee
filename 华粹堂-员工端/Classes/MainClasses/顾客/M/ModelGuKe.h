//
//  ModelGuKe.h
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/28.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelGuKe : NSObject

@property (nonatomic, copy) NSString *family_associate;
@property (nonatomic, copy) NSString *traffic;
@property (nonatomic, copy) NSString *sid;
@property (nonatomic, copy) NSString *profession;
@property (nonatomic, copy) NSString *into_store_time;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *last_contact_time;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *phonetic_code;
@property (nonatomic, copy) NSString *mr_consume_habits;
@property (nonatomic, copy) NSString *salary;
@property (nonatomic, copy) NSString *family_salary;
@property (nonatomic, copy) NSString *last_consume_time;
@property (nonatomic, copy) NSString *child;
@property (nonatomic, copy) NSString *mobile_phone;
@property (nonatomic, copy) NSString *QQ;
@property (nonatomic, copy) NSString *sex; //0-男 1-女
@property (nonatomic, copy) NSString *allergy_history;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *e_id;
@property (nonatomic, copy) NSString *past_history;
@property (nonatomic, copy) NSString *dic_pink_id;
@property (nonatomic, copy) NSString *portrait; //头像地址
@property (nonatomic, copy) NSString *weichat;
@property (nonatomic, copy) NSString *dic_status_id;
@property (nonatomic, copy) NSString *dic_source_id;
@property (nonatomic, copy) NSString *hobby;
@property (nonatomic, copy) NSString *alternate_mobile_phone;
@property (nonatomic, copy) NSString *work_unit;
@property (nonatomic, copy) NSString *istec;
@property (nonatomic, copy) NSString *dic_libie_id;
@property (nonatomic, copy) NSString *customerAge;
@property (nonatomic, copy) NSString *vip_card;
@property (nonatomic, copy) NSString *point;
@property (nonatomic, copy) NSString *s_id;
@property (nonatomic, copy) NSString *c_id;
@property (nonatomic, copy) NSString *concept_health;
@property (nonatomic, copy) NSString *login_password_new;
@property (nonatomic, copy) NSString *signature;
@property (nonatomic, copy) NSString *dic_source;
@property (nonatomic, copy) NSString *marriage;

@property (nonatomic, copy) NSString *ename;  //调理师
@property (nonatomic, copy) NSString *shopName; //门店

@property (nonatomic, copy) NSString *last3_into_store_num; //最近3个月到店次数
@property (nonatomic, copy) NSString *last_into_store_time; //最后到店时间
/* IM用户名，用于调用第三方IM时传入的用户名参数 */
@property (nonatomic, copy) NSString *imUserName;
/* IM密码，用于调用第三方IM时传入的用户名参数 */
@property (nonatomic, copy) NSString *imPasswd;

@end
