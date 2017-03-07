//
//  YuYueDateChooseVC.h
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/16.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "ChildBaseViewController.h"

typedef void(^DidClickDateBlock)(NSDate *startDate,NSDate*endDate);

@interface YuYueDateChooseVC : ChildBaseViewController

@property (nonatomic, copy) DidClickDateBlock didClickDateBlock;

@end
