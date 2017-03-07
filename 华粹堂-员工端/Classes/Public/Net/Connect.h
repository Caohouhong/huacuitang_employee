//
//  Connect.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/22.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Connect : NSObject
+ (Connect *)sharedInstance;
-(void)doTestGetNetWorkWithUrl:(NSString*)url parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *operation, NSDictionary *responseDic))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
-(void)doTestPostNetWorkWithUrl:(NSString*)url parameters:(id)parameters success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
@end
