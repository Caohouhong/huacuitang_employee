//
//  RedDotManager.h
//  lingdaozhe
//
//  Created by aliviya on 16/7/13.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RedDotManager : NSObject
/*  所有已读 没有红点*/
@property (nonatomic,assign,readonly) BOOL isAllRead;
/*  单例对象*/
+ (instancetype)sharedManager;
/*  服务器获取消息 查看时候是否所有已读 设置 isAllRead */
-(void)requestMessages;
/*  设置 所有已读 或者 有未读 */
-(void)setIsAllRead:(BOOL)isAllRead;
@end
