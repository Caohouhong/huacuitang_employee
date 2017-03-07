//
//  SubHealthVC.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "ChildBaseViewController.h"
#import "SubHealthModel.h"
@interface SubHealthVC : ChildBaseViewController
@property(nonatomic ,copy) NSString *YongHuId;
@property(nonatomic, strong) SubHealthModel *model;

@end
