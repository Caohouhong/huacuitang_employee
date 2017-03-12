//
//  HuiFangRecordView.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiaoliOnceCellView.h"
#import "HuiFangModel.h"
typedef NS_ENUM(NSInteger, HuiFangRecordViewButtonTag) {
    ///调理方案
    HuiFangRecordViewButtonTagPlan     = 0,
    //家居养生
    HuiFangRecordViewButtonTagLift     = 1,
    //回访时间
    HuiFangRecordViewButtonTagTime     = 2
  };

typedef void(^clickButtonBlock)(HuiFangRecordViewButtonTag);

typedef void(^HuiFangRecordViewBlock)(NSString *, NSString *);

@interface HuiFangRecordView : UIView

@property (nonatomic, strong) HuiFangModel *model;

@property (nonatomic, copy)clickButtonBlock block;

@property (nonatomic, strong)TiaoliOnceCellView *timeCell;

@property (nonatomic, copy)HuiFangRecordViewBlock textBlock;


@end
