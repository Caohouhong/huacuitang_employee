//
//  ReturnVisitVC.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "ChildBaseViewController.h"
#import "ReturnVisitModel.h"
@interface ReturnVisitVC : ChildBaseViewController
@property(nonatomic ,strong) NSString *YongHuId;
@property(nonatomic ,strong) NSString *name;

@property(nonatomic ,strong) ReturnVisitModel *model;
@end
