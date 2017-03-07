//
//  RechargeViewController.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/22.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, RechargeVCType) {
    RechargeVCTypeRecharge      = 0, //本月充值
    RechargeVCTypeSpend      = 1,  //本月消费
};

@interface RechargeViewController : ChildBaseViewController
@property (nonatomic, assign) RechargeVCType viewType; //界面类型
@end
