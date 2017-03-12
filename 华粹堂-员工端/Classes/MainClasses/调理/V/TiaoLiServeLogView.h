//
//  TiaoLiServeLogView.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiaoliOnceCellView.h"

typedef NS_ENUM(NSInteger, TiaoLiServeLogViewButtonTag) {
    ///调理方案
    TiaoLiServeLogViewButtonTagPlan      = 0,
    ///私密生活
    TiaoLiServeLogViewButtonTagLift   = 1,
    ///私密话题
    TiaoLiServeLogViewButtonTagTopic      = 2,
};

typedef void(^clickButtonBlock)(TiaoLiServeLogViewButtonTag);

typedef void(^TiaoLiServeLogViewBlock)(NSString *,NSString *,NSString *);

@interface TiaoLiServeLogView : UIView

@property (nonatomic, copy) clickButtonBlock block;

@property (nonatomic, copy) TiaoLiServeLogViewBlock viewBlock;

@property (nonatomic, strong) NSString *trackTime;

@property (nonatomic, strong)TiaoliOnceCellView *lifeCell;
@property (nonatomic, strong)TiaoliOnceCellView *topicCell;

@property (nonatomic, strong) NSString *projectText;
@property (nonatomic, strong) NSString *LiLiaoResult;
@property (nonatomic, strong) NSString *feedBackResult;


@end
