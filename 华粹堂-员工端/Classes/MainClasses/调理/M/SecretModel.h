//
//  SecretModel.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/3/9.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 "tagId": 76,
 "state": 0,
 "tagName": "开奥迪Q3",
 "tagNum": 21,
 "createdTimestamp": 1487818599,
 "customerId": 3128,
 "tagType": 2
 
 */
@interface SecretModel : NSObject
@property (nonatomic, copy) NSString *tagId;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *tagName;
@property (nonatomic, copy) NSString *tagNum;
@property (nonatomic, copy) NSString *createdTimestamp;
@property (nonatomic, copy) NSString *customerId;
@property (nonatomic, copy) NSString *tagType;
@end
