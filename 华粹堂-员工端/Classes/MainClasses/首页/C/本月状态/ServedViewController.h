//
//  ServedViewController.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/22.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ServedVCType) {
    ServedVCTypeHaveServed      = 0, //本月已服务
    ServedVCTypeWaitServe      = 1,  //本月待服务
};

@interface ServedViewController : ChildBaseViewController
@property (nonatomic, assign) ServedVCType viewType; //界面类型
@end
