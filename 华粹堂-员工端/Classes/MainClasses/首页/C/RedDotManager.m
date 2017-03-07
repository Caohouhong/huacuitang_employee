//
//  RedDotManager.m
//  lingdaozhe
//
//  Created by aliviya on 16/7/13.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import "RedDotManager.h"
#import "ModelMessage.h"
@implementation RedDotManager
{
    NSMutableArray *messageArray;
}
+ (instancetype)sharedManager
{
    static RedDotManager *sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [[RedDotManager alloc] init];
        sessionManager.isAllRead = YES;

    });
    return sessionManager;
}



-(void)setIsAllRead:(BOOL)isAllRead
{
    if (_isAllRead != isAllRead) {
        _isAllRead = isAllRead;
    }
}

-(void)requestMessages
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[ModelMember sharedMemberMySelf].memberId forKey:@"memberId"];
    [params setObject:[UtilString getNoNilString:[UserDefaults valueForKey:@"deviceToken"]] forKey:@"deviceId"];
    [params setObject:@"2" forKey:@"deviceType"];
    
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"message/listLastMessagesOfGroup" parameters:params showTips:@"" success:^(id responseObject) {
        
        if (responseObject)
        {
            if (!messageArray)
            {
                messageArray = [[NSMutableArray alloc] init];
            }
            messageArray = [ModelMessage mj_objectArrayWithKeyValuesArray:responseObject];
        }
        if (messageArray.count>0) {
            if ([self checkIfHasMessageUnread])
            {
                //                [self setIsAllRead:NO];
                _isAllRead = NO;
            }
            else
            {
                //                [self setIsAllRead:YES];
                _isAllRead = YES;
            }
        }
    } successBackfailError:^(id responseObject) {
    } failure:^(NSError *error) {
    }];
}

-(BOOL)checkIfHasMessageUnread
{
    for (ModelMessage *message in messageArray)
    {
        if (message.isViewed ==0)
        {
            return YES;
        }
    }
    return NO;
}

@end
