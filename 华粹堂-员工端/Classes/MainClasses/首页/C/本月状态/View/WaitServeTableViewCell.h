//
//  WaitServeTableViewCell.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/23.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServeModel.h"
#import "ModelTrackManage.h"
#import "HuiFangModel.h"

typedef void(^WaitServeTableViewCellBlock)();

@interface WaitServeTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *rightBottomLabel; //状态

@property (nonatomic, strong) WaitServeTableViewCellBlock block;

@property (nonatomic, strong) ServeModel *model;

@property (nonatomic, strong) ModelTrackManage *trackModel; //调理备忘列表

@property (nonatomic, strong) HuiFangModel *huiFangModel;

+ (WaitServeTableViewCell *)cellWithTableView:(UITableView *)tableView;
@end
