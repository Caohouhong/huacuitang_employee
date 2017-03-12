//
//  AccountInfoDetailVC.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "ChildBaseViewController.h"
#import "AccountModel.h"
@interface AccountInfoDetailVC : ChildBaseViewController
@property(nonatomic ,strong) AccountModel *model;
@property(nonatomic ,copy) NSString *YongHuId;
@end
