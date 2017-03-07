//
//  SelfDailySummaryVC.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "ChildBaseViewController.h"

@interface SelfDailySummaryVC : ChildBaseViewController
@property (nonatomic, strong) NSString *employeeId; //员工id
@property (nonatomic, assign) BOOL isCheck; //是否是查看
@property (nonatomic, assign) int type;
@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *conent;

//总结id
@property (nonatomic, strong) NSString *workSummaryId;

@end
