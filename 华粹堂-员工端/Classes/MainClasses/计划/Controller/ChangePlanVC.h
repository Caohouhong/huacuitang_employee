//
//  ChangePlanVC.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "ChildBaseViewController.h"
#import "TomPlanListModel.h"

@interface ChangePlanVC : ChildBaseViewController

@property (nonatomic, strong) TomPlanListModel *model;

@property (nonatomic, strong) NSString *timeStr;

@end
