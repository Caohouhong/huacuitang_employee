//
//  Connect.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/22.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "Connect.h"

@implementation Connect
+ (Connect *)sharedInstance {
    static Connect * _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[Connect alloc] init];
    });
    
    return _sharedInstance;
}

//get
-(void)doTestGetNetWorkWithUrl:(NSString*)url parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *operation, NSDictionary *responseDic))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    [self doGetWithUrl:url parameters:parameters success:^(NSURLSessionDataTask *operation, NSDictionary *responseDic) {
        success(operation, responseDic);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

//post
-(void)doTestPostNetWorkWithUrl:(NSString*)url parameters:(id)parameters success:(void (^)(id responseObject))success
           successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    
    [self doPostWithUrl:url parameters:parameters success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

-(void)doGetWithUrl:(NSString*)url parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *operation, NSDictionary *responseDic))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success){
            success(task,responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure){
            failure(task,error);
        }
    }];
    
}
-(void)doPostWithUrl:(NSString*)url parameters:(id)parameters success:(void (^)(id responseObject))success
successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
      DLog(@"request param:%@",parameters);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success){
             DLog(@"result:%@",responseObject);
             [self parsingRequestBack:responseObject sucess:success successBackfailError:successBackfailError];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure){
            failure(task,error);
            [LCProgressHUD showFailure:@"网络异常，请稍后再试"];
        }
    }];
}

/**
 *  请求成功后的数据解析
 */

- (void)parsingRequestBack:(id)responseObject
                    sucess:(void (^)(id responseObject))success
      successBackfailError:(void (^)(id responseObject))successBackfailError
{
    BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
    
    if(baseModel.state == 0) //0是成功
    {
        [LCProgressHUD hide];
        
        success(baseModel.data);
        return;
    }
    
    if (baseModel.fieldErrors.count)
    {
        ModelFieldError *modelFieldError = [baseModel.fieldErrors firstObject];
        
        if (modelFieldError.field != -6) { //请求失败
            [LCProgressHUD showFailure:modelFieldError.message];
        }else{
            [LCProgressHUD hide];
        }
        
        successBackfailError(modelFieldError);
    }
}

@end
