//
//  HighTechDetailVC.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "ChildBaseViewController.h"
#import "HighTechDetailModel.h"
typedef NS_ENUM(NSInteger, HighTechViewType) {
    HighTechViewTypeLog       = 0,
    HighTechViewTypeAdvice   =  1,
};

@interface HighTechDetailVC : ChildBaseViewController
@property (nonatomic, assign) HighTechViewType viewType;
@property (nonatomic, copy) NSString *YongHuId;
@property (nonatomic, strong) HighTechDetailModel *model;

@end
