//
//  SecretLiftModel.h
//  华粹堂-员工端
//
//  Created by baichun on 17/3/6.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecretLiftModel : NSObject
@property (nonatomic, copy) NSString *tagName;
@property (nonatomic, copy) NSString *tagNum;


-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
