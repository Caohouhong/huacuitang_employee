//
//  WriteSecretVC.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/3/9.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "ChildBaseViewController.h"
#import "ModelTrackManage.h"

typedef NS_ENUM(NSInteger, WriteSecretViewType) {
    WriteSecretViewTypeLife     = 0, //私密生活
    WriteSecretViewTypeTopic    = 1,  //私密话题
};

@interface WriteSecretVC : ChildBaseViewController

@property (nonatomic, assign) WriteSecretViewType type;

@property (nonatomic, assign) ModelTrackManage *employeeModel;

@end
