//
//  UserDefalutModel.h
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/28.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefalutModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *serverTime;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *portrait;
@property (nonatomic, copy) NSString *feedback;
@property (nonatomic, copy) NSString *kfsh;
@property (nonatomic, copy) NSString *lastModified;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *visit_time;
@property (nonatomic, copy) NSString *customerAge;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *e_id;
@property (nonatomic, copy) NSString *sid;
@property (nonatomic, copy) NSString *dzsh;
@property (nonatomic, copy) NSString *customerTel;
@property (nonatomic, copy) NSString *c_id;
@property (nonatomic, copy) NSString *s_id;
@property (nonatomic, copy) NSString *last_consume_time;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *customerName;


+(void)setUserM:(UserDefalutModel *)modelM;

+(UserDefalutModel *)getmodelM;

@end
