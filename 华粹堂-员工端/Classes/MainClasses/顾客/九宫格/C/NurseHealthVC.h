//
//  NurseHealthVC.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "ChildBaseViewController.h"
typedef NS_ENUM(NSInteger, NurseHealthViewType) {
    NurseHealthViewTypeLog      = 0,
    NurseHealthViewTypeLife     = 1,
    NurseHealthViewTypeAdvice   = 2,
};

@interface NurseHealthVC : ChildBaseViewController
@property (nonatomic, assign) NurseHealthViewType viewType;
@end
