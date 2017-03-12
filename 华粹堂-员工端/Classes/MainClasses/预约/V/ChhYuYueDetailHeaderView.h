//
//  ChhYuYueDetailHeaderView.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/24.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelHealthBooking.h"
#import "ModelTrackManage.h"
#import "HuiFangModel.h"

@interface ChhYuYueDetailHeaderView : UIView

@property (nonatomic, strong) UIImageView *iconImageView; //头像
@property (nonatomic, strong) UILabel *nameTextlabel; //姓名
@property (nonatomic, strong) UILabel *phoneTextlabel; //电话
@property (nonatomic, strong) UILabel *addressTextlabel; //地点
@property (nonatomic, strong) UIImageView *sexImageView; //性别
@property (nonatomic, strong) UILabel *yearTextlabel; //年龄

@property (nonatomic, strong) ModelHealthBooking *yuyueModel;//预约

@property (nonatomic, strong) ModelTrackManage *trackModel;//调理

@property (nonatomic, strong) HuiFangModel *huifangModel;//回访

@end
