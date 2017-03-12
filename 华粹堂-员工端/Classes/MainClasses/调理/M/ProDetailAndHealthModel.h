//
//  ProDetailAndHealthModel.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/3/7.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProDetailAndHealthModel : NSObject

@property (nonatomic, copy) NSString *sid;
@property (nonatomic, copy) NSString *d_program_detail; //调理方案
@property (nonatomic, copy) NSString *home_health_req;  //家居养生方案
@end
