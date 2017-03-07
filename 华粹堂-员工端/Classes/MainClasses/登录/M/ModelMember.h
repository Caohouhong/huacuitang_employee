//
//  ModelMember.h
//  ZhouMo
//
//  Created by liqiang on 16/9/18.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "BaseModelMember.h"

/* 二维码信息的模板 */
#define QRCODEINFO_TEMPLATE @"{serveId}"
/* 会员默认头像 */
#define MEMBER_PORTRAIT_DEFAULT @"/default/default.png"

/* 状态-正常 */
#define STATE_NORMAL 1
/* 状态-禁用*/
#define STATE_DISABLED  9

/* 注册方式-手机号 */
#define REGISTERMODE_MOBILEPHONE 1
/* 注册方式-QQ */
#define REGISTERMODE_QQ 2
/* 注册方式-微信 */
#define REGISTERMODE_WEIXIN 3
/* 注册方式-微博 */
#define REGISTERMODE_WEIBO 4

/* 性别-男 */
#define GENDER_MALE 1
/* 性别-女 */
#define GENDER_FEMALE 2
/* 性别-其他 */
#define GENDER_OTHERS  9

/* 会员等级1级 */
#define MEMBER_LEVEL_ONE 1
/* 会员等级2级 */
#define MEMBER_LEVEL_TWO 2

@interface ModelMember : BaseModelMember

+ (ModelMember *)sharedMemberMySelf;
- (void)logOut;
+ (BOOL)isLogin;

+ (void)doLoginWithMemberDic:(NSDictionary *)dic;

@end
