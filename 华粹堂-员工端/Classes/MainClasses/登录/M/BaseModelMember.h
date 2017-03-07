//
//  BaseModelMember.h
//  ZhouMo
//
//  Created by liqiang on 16/9/18.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ModelLive;

@interface BaseModelMember : NSObject

@property (nonatomic, copy) NSString *memberId; //用户id
@property (nonatomic, copy) NSString *employee_no;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *name_letter;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *alternate_phone;
@property (nonatomic, copy) NSString *QQ;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *wechat;
@property (nonatomic, copy) NSString *entry_date;
@property (nonatomic, copy) NSString *departure_date;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *r_id;
@property (nonatomic, copy) NSString *o_id;
@property (nonatomic, copy) NSString *s_id; //店id
@property (nonatomic, copy) NSString *d_id;
@property (nonatomic, copy) NSString *login_name;
@property (nonatomic, copy) NSString *login_password;
@property (nonatomic, copy) NSString *last_login_time;
@property (nonatomic, copy) NSString *last_login_ip;
@property (nonatomic, copy) NSString *login_status;
@property (nonatomic, copy) NSString *warehouse_ids;
@property (nonatomic, copy) NSString *account_ids;
@property (nonatomic, copy) NSString *store_auths;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *login_password_new;
@property (nonatomic, copy) NSString *portrait;
@property (nonatomic, copy) NSString *signature;
@property (nonatomic, copy) NSString *shopName;
/* IM用户名，用于调用第三方IM时传入的用户名参数 */
@property (nonatomic, copy) NSString *imUserName;
/* IM密码，用于调用第三方IM时传入的用户名参数 */
@property (nonatomic, copy) NSString *imPasswd;

@end
