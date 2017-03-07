//
//  MonthDetailVC.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "ChildBaseViewController.h"
typedef NS_ENUM(NSInteger, MonthDetailViewType) {
    MonthDetailViewTypeBegin   = 0,
    MonthDetailViewTypeAudit   = 1,
    MonthDetailViewTypeEnd     = 2,
};


@interface MonthDetailVC : ChildBaseViewController
@property (nonatomic, assign) MonthDetailViewType viewType;
@end
